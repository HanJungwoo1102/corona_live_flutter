import 'dart:convert';
import 'dart:developer' as developer;
import 'package:corona_live_flutter/widgets/ContentLayout.dart';
import 'package:corona_live_flutter/lib/PreviousPageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CasesDeathsPage extends StatelessWidget {
  Future<Content> futureContent;

  @override
  Widget build(BuildContext context) {
    return ContentLayout(
      futureContent: futureContent,
    );
  }
}
