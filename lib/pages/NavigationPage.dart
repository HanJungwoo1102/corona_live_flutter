import 'package:corona_live_flutter/lib/PreviousPageProvider.dart';
import 'package:corona_live_flutter/lib/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatelessWidget {
  final String PAGE_CASES_DEATH = 'cases-deaths';
  final String PAGE_VACCINE = 'vaccine';

  onTapListTile(BuildContext context, String tileKey, PreviousPageProvider previousPageProvider) {
    if (tileKey == PAGE_CASES_DEATH) {
      Navigator.pushNamed(context, '/contents/cases-deaths');
      previousPageProvider.visit('Cases/Deaths Page');
    } else if (tileKey == PAGE_VACCINE) {
      Navigator.pushNamed(context, '/contents/vaccine');
      previousPageProvider.visit('Vaccine Page');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final previousPageProvider = Provider.of<PreviousPageProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: Column(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.airline_seat_individual_suite_outlined),
                  title: Text('Cases/Deaths'),
                  onTap: () => onTapListTile(context, PAGE_CASES_DEATH, previousPageProvider),
                ),
                ListTile(
                  leading: Icon(Icons.local_hospital_rounded),
                  title: Text('Vaccine'),
                  onTap: () => onTapListTile(context, PAGE_VACCINE, previousPageProvider),
                ),
              ],
            ),
            Text('Welcome! ${userProvider.userId}'),
            Text('Previous: ${previousPageProvider.previousPageName}'),
          ],
        ),
    );
  }
}
