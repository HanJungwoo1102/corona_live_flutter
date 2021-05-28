import 'dart:convert' ;
import 'dart:developer' as developer;

class CountryVaccineInfo {
  final String country;
  final List<VaccineStatus> vaccineStatusList;

  CountryVaccineInfo({this.country, this.vaccineStatusList});

  factory CountryVaccineInfo.fromJson(Map<String, dynamic> jsonData) {
    return CountryVaccineInfo(
      country: jsonData['country'],
      vaccineStatusList: jsonData['data'].map<VaccineStatus>((item) => VaccineStatus.fromJson(item)).toList(),
    );
  }
}

class VaccineStatus {
  final DateTime date;
  final int totalVaccinations;
  final int peopleVaccinated;
  final int peopleFullyVaccinated;
  final int dailyVaccinations;

  VaccineStatus({
    this.date, this.totalVaccinations, this.peopleVaccinated, this.peopleFullyVaccinated, this.dailyVaccinations,
  });

  factory VaccineStatus.fromJson(Map<String, dynamic> json) {
    return VaccineStatus(
      date: DateTime.parse(json['date']),
      totalVaccinations: json['total_vaccinations'],
      peopleVaccinated: json['people_vaccinated'],
      peopleFullyVaccinated: json['people_fully_vaccinated'],
      dailyVaccinations: json['daily_vaccinations']
    );
  }
}
