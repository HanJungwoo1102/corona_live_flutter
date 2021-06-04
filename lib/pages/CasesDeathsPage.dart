import 'dart:convert';
import 'package:corona_live_flutter/lib/CasesDeathsContentAdapter.dart';
import 'package:corona_live_flutter/widgets/ContentLayout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:corona_live_flutter/lib/CountryCasesDeathsInfo.dart';

class CasesDeathsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContentLayout(
      futureContent: fetchContent(http.Client()),
      pageName: 'Cases/Deaths Page',
    );
  }
}

Future<Content> fetchContent(http.Client client) async {
  final response = await client.get(Uri.parse('https://covid.ourworldindata.org/data/owid-covid-data.json'));
  return parseContent(response.body);
}

Content parseContent(String responseBody) {
  try {
    final Map<String, dynamic> parsed = json.decode(responseBody);
    List<CountryCasesDeathsInfo> countryCasesDeathsInfoList = [];
    parsed.forEach((key, value) {
      countryCasesDeathsInfoList.add(CountryCasesDeathsInfo.fromJson(value));
    });

    return CasesDeathsContentAdapter.adapt(countryCasesDeathsInfoList);

  } catch(error) {
    print(error);
  }
}
