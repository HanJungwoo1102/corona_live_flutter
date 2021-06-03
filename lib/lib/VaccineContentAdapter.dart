import 'package:corona_live_flutter/widgets/ContentLayout.dart';
import 'package:corona_live_flutter/lib/CountryVaccineInfo.dart';
import 'dart:developer' as developer;

import 'package:corona_live_flutter/widgets/Graph.dart';
import 'package:corona_live_flutter/widgets/SimpleTable.dart';

class VaccineContentAdapter {
  static Content adapt(List<CountryVaccineInfo> countryVaccineInfos) {
    final indexOfKorea = countryVaccineInfos.indexWhere((element) => element.country == 'South Korea');
    final koreaVaccineInfo = countryVaccineInfos.elementAt(indexOfKorea);
    final parsedDateTime = koreaVaccineInfo.vaccineStatusList[koreaVaccineInfo.vaccineStatusList.length - 1].date;

    final firstBoxListItems = getFirstBoxItems(parsedDateTime, countryVaccineInfos);
    final graphs = getGraphs(parsedDateTime, countryVaccineInfos);
    final tables = getTables(parsedDateTime, countryVaccineInfos);

    return Content(
      firstBoxListItems: firstBoxListItems,
      graphs: graphs,
      tables: tables,
    );
  }
}

class DateTimeData {
  final int totalVacc;
  final int totalFullyVacc;
  final int dailyVacc;

  DateTimeData({ this.totalVacc, this.totalFullyVacc, this.dailyVacc });
}

VaccineStatus getPriorDateVaccineStatus(List<VaccineStatus> list, DateTime date) {
  final priorDate = DateTime(
    date.year,
    date.month,
    date.day - 1,
  );

  final findedIndex = list.indexWhere((element) => priorDate.difference(element.date) == 0);

  return findedIndex == -1 ? null : list[findedIndex];
}

DateTimeData getCountryDateTimeData(DateTime parsedDate, CountryVaccineInfo countryData) {
  int totalVacc = 0;
  int totalFullyVacc = 0;
  int dailyVacc = 0;

  int parsedDateIndex = countryData.vaccineStatusList.indexWhere((element) => parsedDate.difference(element.date).inDays == 0);

  parsedDateIndex = parsedDateIndex == -1 ? countryData.vaccineStatusList.length - 1 : parsedDateIndex;

  final parsedDateVaccineStatus = countryData.vaccineStatusList[parsedDateIndex];

  if (parsedDateVaccineStatus.totalVaccinations != null) {
    totalVacc += parsedDateVaccineStatus.totalVaccinations;
  } else if (parsedDateVaccineStatus.peopleVaccinated != null) {
    totalVacc += parsedDateVaccineStatus.peopleVaccinated;
  } else if (parsedDateVaccineStatus.peopleFullyVaccinated != null) {
    totalVacc += parsedDateVaccineStatus.peopleFullyVaccinated;
  }

  if (parsedDateVaccineStatus.peopleFullyVaccinated != null) {
    totalFullyVacc += parsedDateVaccineStatus.peopleFullyVaccinated;
  } else {
    final priorDateVaccineStatus = getPriorDateVaccineStatus(countryData.vaccineStatusList, parsedDate);
    if (priorDateVaccineStatus != null && priorDateVaccineStatus.peopleFullyVaccinated != null) {
      totalFullyVacc += priorDateVaccineStatus.peopleFullyVaccinated;
    }
  }

  if (parsedDateVaccineStatus.dailyVaccinations != null) {
    dailyVacc += parsedDateVaccineStatus.dailyVaccinations;
  } else {
    final priorDateVaccineStatus = getPriorDateVaccineStatus(countryData.vaccineStatusList, parsedDate);
    if (priorDateVaccineStatus != null && priorDateVaccineStatus.dailyVaccinations != null) {
      dailyVacc += priorDateVaccineStatus.dailyVaccinations;
    }
  }

  return DateTimeData(totalVacc: totalVacc, totalFullyVacc: totalFullyVacc, dailyVacc: dailyVacc);
}

DateTimeData getTotalDateTimeData(DateTime parsedDate, List<CountryVaccineInfo> data) {
  int totalVacc = 0;
  int totalFullyVacc = 0;
  int dailyVacc = 0;

  data.forEach((countryData) {
    final countryDateTimeData = getCountryDateTimeData(parsedDate, countryData);

    totalVacc += countryDateTimeData.totalVacc;
    totalFullyVacc += countryDateTimeData.totalFullyVacc;
    dailyVacc += countryDateTimeData.dailyVacc;
  });

  return DateTimeData(totalVacc: totalVacc, totalFullyVacc: totalFullyVacc, dailyVacc: dailyVacc);
}

List<FirstBoxListItem> getFirstBoxItems(DateTime parsedDate, List<CountryVaccineInfo> data) {
  final dateTimeDate = getTotalDateTimeData(parsedDate, data);
  return [
    FirstBoxListItem(
      label: 'Total Vacc.',
      value: '${dateTimeDate.totalVacc} people',
    ),
    FirstBoxListItem(
      label: 'Parsed latest date',
      value: '${parsedDate.year}-${parsedDate.month}-${parsedDate.day}',
    ),
    FirstBoxListItem(
      label: 'Total fully Vacc.',
      value: '${dateTimeDate.totalFullyVacc} people',
    ),
    FirstBoxListItem(
      label: 'Dally Vacc',
      value: '${dateTimeDate.dailyVacc} people',
    ),
  ];
}

List<List<GraphPoint>> getGraphs(DateTime parsedDate, List<CountryVaccineInfo> data) {
  final graph1Points = <GraphPoint>[];
  final graph2Points = <GraphPoint>[];
  final graph3Points = <GraphPoint>[];
  final graph4Points = <GraphPoint>[];

  for (int i = 0; i < 7; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (6 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.totalVacc.toDouble(), xLabel: '${date.month}-${date.day}');

    graph1Points.add(point);
  }

  for (int i = 0; i < 7; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (6 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.dailyVacc.toDouble(), xLabel: '${date.month}-${date.day}');
    graph2Points.add(point);
  }

  for (int i = 0; i < 28; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (27 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.totalVacc.toDouble(), xLabel: (i % 7 == 0 || i == 27) ? '${date.month}-${date.day}' : '');

    graph3Points.add(point);
  }

  for (int i = 0; i < 28; i++) {
    final date = DateTime(parsedDate.year, parsedDate.month, parsedDate.day - (27 - i));
    final DateTimeDate = getTotalDateTimeData(date, data);

    final point = GraphPoint(x: i.toDouble(), y: DateTimeDate.dailyVacc.toDouble(), xLabel: (i % 7 == 0 || i == 27) ? '${date.month}-${date.day}' : '');
    graph4Points.add(point);
  }

  return [
    graph1Points,
    graph2Points,
    graph3Points,
    graph4Points,
  ];
}

List<TableContent> getTables(DateTime parsedDate, List<CountryVaccineInfo> data) {
  List<Map<String, DateTimeData>> countryDateTimeDataList = [];

  List<List<String>> firstTableRows = [];
  List<List<String>> secondTableRows = [];

  data.forEach((countryData) {
    final countryDateTimeData = getCountryDateTimeData(parsedDate, countryData);

    Map<String, DateTimeData> map = {};
    map[countryData.country] = countryDateTimeData;
    countryDateTimeDataList.add(map);
  });

  countryDateTimeDataList.sort((Map<String, DateTimeData> a, Map<String, DateTimeData> b) => a.keys.first.compareTo(b.keys.first));

  for (int i = 0; i < 7; i++) {
    final dateTimeData = countryDateTimeDataList[i];
    firstTableRows.add([dateTimeData.keys.first, '${dateTimeData.values.first.totalVacc}', '${dateTimeData.values.first.totalFullyVacc}', '${dateTimeData.values.first.dailyVacc}']);
  }

  countryDateTimeDataList.sort((Map<String, DateTimeData> a, Map<String, DateTimeData> b) => b.values.first.totalVacc.compareTo(a.values.first.totalVacc));

  for (int i = 0; i < 7; i++) {
    final dateTimeData = countryDateTimeDataList[i];
    secondTableRows.add([dateTimeData.keys.first, '${dateTimeData.values.first.totalVacc}', '${dateTimeData.values.first.totalFullyVacc}', '${dateTimeData.values.first.dailyVacc}']);
  }

  return [
    TableContent(
        rows: [
          ['Country', 'Total', 'Fully', 'Daily'],
          ...firstTableRows,
        ]
    ),
    TableContent(
        rows: [
          ['Country', 'Total', 'Fully', 'Daily'],
          ...secondTableRows
        ]
    )
  ];
}