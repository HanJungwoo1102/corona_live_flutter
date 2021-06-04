class CountryCasesDeathsInfo {
  final String location;
  final List<CasesDeathsData> datas;

  CountryCasesDeathsInfo({this.location, this.datas});

  factory CountryCasesDeathsInfo.fromJson(Map<String, dynamic> jsonData) {
    return CountryCasesDeathsInfo(
      location: jsonData['location'],
      datas: jsonData['data'].map<CasesDeathsData>((item) => CasesDeathsData.fromJson(item)).toList(),
    );
  }
}

class CasesDeathsData {
  final DateTime date;
  final double totalCases;
  final double newCases;
  final double totalDeaths;

  CasesDeathsData({this.date, this.totalCases, this.newCases, this.totalDeaths });

  factory CasesDeathsData.fromJson(Map<String, dynamic> jsonData) {
    return CasesDeathsData(
      date: DateTime.parse(jsonData['date']),
      totalCases: jsonData['total_cases'],
      newCases: jsonData['new_cases'],
      totalDeaths: jsonData['total_deaths'],
    );
  }
}