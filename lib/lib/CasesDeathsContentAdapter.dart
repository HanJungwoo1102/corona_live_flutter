import 'package:corona_live_flutter/widgets/ContentLayout.dart';
import 'package:corona_live_flutter/lib/CountryCasesDeathsInfo.dart';
import 'package:corona_live_flutter/widgets/Graph.dart';
import 'package:corona_live_flutter/widgets/SimpleTable.dart';

class CasesDeathsContentAdapter {
  static Content adapt(List<CountryCasesDeathsInfo> countryInfos) {
    final indexOfKorea = countryInfos.indexWhere((element) => element.location == 'South Korea');
    final koreaVaccineInfo = countryInfos.elementAt(indexOfKorea);
    final parsedDateTime = koreaVaccineInfo.datas[koreaVaccineInfo.datas.length - 1].date;

    final firstBoxListItems = getFirstBoxItems(parsedDateTime, countryInfos);
    final graphs = getGraphs(parsedDateTime, countryInfos);
    final tables = getTables(parsedDateTime, countryInfos);

    return Content(
      firstBoxListItems: firstBoxListItems,
      graphs: graphs,
      tables: tables,
    );
  }
}

class DateTimeData {
  final double totalCases;
  final double totalDeaths;
  final double dailyCases;

  DateTimeData({ this.totalCases, this.totalDeaths, this.dailyCases });
}

CasesDeathsData getPriorDateCasesDeathsData(List<CasesDeathsData> list, DateTime date) {
  final priorDate = DateTime(
    date.year,
    date.month,
    date.day - 1,
  );

  final findedIndex = list.indexWhere((element) => priorDate.difference(element.date) == 0);

  return findedIndex == -1 ? null : list[findedIndex];
}

DateTimeData getCountryDateTimeData(DateTime parsedDate, CountryCasesDeathsInfo countryData) {
  double totalCases = 0;
  double totalDeaths = 0;
  double dailyCases = 0;

  int parsedDateIndex = countryData.datas.indexWhere((element) => parsedDate.difference(element.date).inDays == 0);

  parsedDateIndex = parsedDateIndex == -1 ? countryData.datas.length - 1 : parsedDateIndex;

  final parsedDateData = countryData.datas[parsedDateIndex];

  if (parsedDateData.totalCases != null) {
    totalCases += parsedDateData.totalCases;
  } else {
    final priorDateCasesDeathsData = getPriorDateCasesDeathsData(countryData.datas, parsedDate);
    if (priorDateCasesDeathsData != null && priorDateCasesDeathsData.totalCases != null) {
      totalCases += parsedDateData.totalCases;
    }
  }

  if (parsedDateData.totalDeaths != null) {
    totalDeaths += parsedDateData.totalDeaths;
  } else {
    final priorDateCasesDeathsData = getPriorDateCasesDeathsData(countryData.datas, parsedDate);
    if (priorDateCasesDeathsData != null && priorDateCasesDeathsData.totalDeaths != null) {
      totalDeaths += parsedDateData.totalDeaths;
    }
  }

  if (parsedDateData.newCases != null) {
    dailyCases += parsedDateData.newCases;
  } else {
    final priorDateCasesDeathsData = getPriorDateCasesDeathsData(countryData.datas, parsedDate);
    if (priorDateCasesDeathsData != null && priorDateCasesDeathsData.newCases != null) {
      dailyCases += parsedDateData.newCases;
    }
  }

  return DateTimeData(totalCases: totalCases, totalDeaths: totalDeaths, dailyCases: dailyCases);
}

DateTimeData getTotalDateTimeData(DateTime parsedDate, List<CountryCasesDeathsInfo> data) {
  double totalCases = 0;
  double totalDeaths = 0;
  double dailyCases = 0;

  data.forEach((countryData) {
    final countryDateTimeData = getCountryDateTimeData(parsedDate, countryData);

    totalCases += countryDateTimeData.totalCases;
    totalDeaths += countryDateTimeData.totalDeaths;
    dailyCases += countryDateTimeData.dailyCases;
  });

  return DateTimeData(totalCases: totalCases, totalDeaths: totalDeaths, dailyCases: dailyCases);
}

List<FirstBoxListItem> getFirstBoxItems(DateTime parsedDate, List<CountryCasesDeathsInfo> data) {
  final dateTimeDate = getTotalDateTimeData(parsedDate, data);
  return [
    FirstBoxListItem(
      label: 'Total Cases',
      value: '${dateTimeDate.totalCases.toInt()} people',
    ),
    FirstBoxListItem(
      label: 'Parsed latest date',
      value: '${parsedDate.year}-${parsedDate.month}-${parsedDate.day}',
    ),
    FirstBoxListItem(
      label: 'Total Deaths',
      value: '${dateTimeDate.totalDeaths.toInt()} people',
    ),
    FirstBoxListItem(
      label: 'Dally Cases',
      value: '${dateTimeDate.dailyCases.toInt()} people',
    ),
  ];
}

List<List<GraphPoint>> getGraphs(DateTime parsedDate, List<CountryCasesDeathsInfo> data) {
  final graph1Points = <GraphPoint>[];
  final graph2Points = <GraphPoint>[];
  final graph3Points = <GraphPoint>[];
  final graph4Points = <GraphPoint>[];

  for (int i = 0; i < 7; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (6 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.totalCases, xLabel: '${date.month}-${date.day}');

    graph1Points.add(point);
  }

  for (int i = 0; i < 7; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (6 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.dailyCases, xLabel: '${date.month}-${date.day}');
    graph2Points.add(point);
  }

  for (int i = 0; i < 28; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (27 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.totalCases, xLabel: (i % 7 == 0 || i == 27) ? '${date.month}-${date.day}' : '');

    graph3Points.add(point);
  }

  for (int i = 0; i < 28; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (27 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.dailyCases, xLabel: (i % 7 == 0 || i == 27) ? '${date.month}-${date.day}' : '');
    graph4Points.add(point);
  }

  return [
    graph1Points,
    graph2Points,
    graph3Points,
    graph4Points,
  ];
}

List<TableContent> getTables(DateTime parsedDate, List<CountryCasesDeathsInfo> data) {
  List<Map<String, DateTimeData>> countryDateTimeDataList = [];

  List<List<String>> firstTableRows = [];
  List<List<String>> secondTableRows = [];

  data.forEach((countryData) {
    final countryDateTimeData = getCountryDateTimeData(parsedDate, countryData);

    Map<String, DateTimeData> map = {};
    map[countryData.location] = countryDateTimeData;
    countryDateTimeDataList.add(map);
  });

  countryDateTimeDataList.sort((Map<String, DateTimeData> a, Map<String, DateTimeData> b) => a.keys.first.compareTo(b.keys.first));

  for (int i = 0; i < 7; i++) {
    final dateTimeData = countryDateTimeDataList[i];
    firstTableRows.add([dateTimeData.keys.first, '${dateTimeData.values.first.totalCases.toInt()}', '${dateTimeData.values.first.dailyCases.toInt()}', '${dateTimeData.values.first.totalDeaths.toInt()}']);
  }

  countryDateTimeDataList.sort((Map<String, DateTimeData> a, Map<String, DateTimeData> b) => b.values.first.totalCases.compareTo(a.values.first.totalCases));

  for (int i = 0; i < 7; i++) {
    final dateTimeData = countryDateTimeDataList[i];
    secondTableRows.add([dateTimeData.keys.first, '${dateTimeData.values.first.totalCases.toInt()}', '${dateTimeData.values.first.dailyCases.toInt()}', '${dateTimeData.values.first.totalDeaths.toInt()}']);
  }

  return [
    TableContent(
        rows: [
          ['Country', 'Total Cases', 'Daily Cases', 'Total Deaths'],
          ...firstTableRows,
        ]
    ),
    TableContent(
        rows: [
          ['Country', 'Total Cases', 'Daily Cases', 'Total Deaths'],
          ...secondTableRows
        ]
    )
  ];
}