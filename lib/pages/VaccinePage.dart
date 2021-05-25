import 'dart:convert';
import 'package:corona_live_flutter/lib/VaccineContentAdapter.dart';
import 'package:corona_live_flutter/widgets/ContentLayout.dart';
import 'package:corona_live_flutter/lib/CountryVaccineInfo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VaccinePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ContentLayout(
      futureContent: fetchContent(http.Client()),
    );
  }
}

Future<Content> fetchContent(http.Client client) async {
  final response = await client.get(Uri.parse('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.json'));
  return parseContent(response.body);
}

Content parseContent(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  final countryVaccineInfos = parsed.map<CountryVaccineInfo>((json) => CountryVaccineInfo.fromJson(json)).toList();
  return VaccineContentAdapter.adapt(countryVaccineInfos);
}


