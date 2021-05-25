import 'package:corona_live_flutter/pages/CasesDeathsPage.dart';
import 'package:corona_live_flutter/pages/LoginPage.dart';
import 'package:corona_live_flutter/pages/NavigationPage.dart';
import 'package:corona_live_flutter/lib/PreviousPageProvider.dart';
import 'package:corona_live_flutter/lib/UserProvider.dart';
import 'package:corona_live_flutter/pages/VaccinePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PreviousPageProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/navigation': (context) => NavigationPage(),
          '/contents/vaccine': (context) => VaccinePage(),
          '/contents/cases-deaths': (context) => CasesDeathsPage(),
        },
      )
    );
  }
}
