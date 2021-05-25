import 'package:corona_live_flutter/widgets/ContentLayout.dart';
import 'package:corona_live_flutter/lib/CountryVaccineInfo.dart';
import 'dart:developer' as developer;

import 'package:corona_live_flutter/widgets/Graph.dart';
import 'package:corona_live_flutter/widgets/SimpleTable.dart';

class VaccineContentAdapter {
  static Content adapt(List<CountryVaccineInfo> countryVaccineInfos) {
    int totalVacc = 0;
    String parsedLatestDate = '';
    int totalFullyVacc = 0;
    int dailyVacc = 0;

    countryVaccineInfos.forEach((info) {
      final latestVaccineStatus = info.vaccineStatusList[info.vaccineStatusList.length - 1];

      if (latestVaccineStatus.totalVaccinations != null) {
        totalVacc += latestVaccineStatus.totalVaccinations;
      } else if (latestVaccineStatus.peopleVaccinated != null) {
        totalVacc += latestVaccineStatus.peopleVaccinated;
      } else if (latestVaccineStatus.peopleFullyVaccinated != null) {
        totalVacc += latestVaccineStatus.peopleFullyVaccinated;
      }

      if (latestVaccineStatus.peopleFullyVaccinated != null) {
        totalFullyVacc += latestVaccineStatus.peopleFullyVaccinated;
      } else {
        if (info.vaccineStatusList.length > 1) {
          final priorVaccineStatus = info.vaccineStatusList[info.vaccineStatusList.length - 2];
          if (priorVaccineStatus.peopleFullyVaccinated != null) {
            totalFullyVacc += priorVaccineStatus.peopleFullyVaccinated;
          }
        }
      }

      if (latestVaccineStatus.peopleFullyVaccinated != null) {
        totalFullyVacc += latestVaccineStatus.peopleFullyVaccinated;
      } else {
        if (info.vaccineStatusList.length > 1) {
          final priorVaccineStatus = info.vaccineStatusList[info.vaccineStatusList.length - 2];
          if (priorVaccineStatus.peopleFullyVaccinated != null) {
            totalFullyVacc += priorVaccineStatus.peopleFullyVaccinated;
          }
        }
      }

      if (latestVaccineStatus.dailyVaccinations != null) {
        dailyVacc += latestVaccineStatus.dailyVaccinations;
      } else {
        if (info.vaccineStatusList.length > 1) {
          final priorVaccineStatus = info.vaccineStatusList[info.vaccineStatusList.length - 2];
          if (priorVaccineStatus.dailyVaccinations != null) {
            dailyVacc += priorVaccineStatus.dailyVaccinations;
          }
        }
      }

      if (info.country == 'South Korea') {
        parsedLatestDate = latestVaccineStatus.date;
      }
    });

    return Content(
      firstBoxListItems: [
        FirstBoxListItem(
          label: 'Total Vacc.',
          value: '$totalVacc people',
        ),
        FirstBoxListItem(
            label: 'Parsed latest date',
            value: parsedLatestDate,
        ),
        FirstBoxListItem(
          label: 'Total fully Vacc.',
          value: '$totalFullyVacc people',
        ),
        FirstBoxListItem(
          label: 'Dally Vacc',
          value: '$dailyVacc people',
        ),
      ],
      graphs: [
        [
          GraphPoint(x: 0, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 1, y: 2, xLabel: 'hihi'),
          GraphPoint(x: 2, y: 3, xLabel: 'hihi'),
          GraphPoint(x: 3, y: 4, xLabel: 'hihi'),
          GraphPoint(x: 4, y: 3, xLabel: 'hihi'),
          GraphPoint(x: 5, y: 2, xLabel: 'hihi'),
          GraphPoint(x: 6, y: 6, xLabel: 'hihi'),
          GraphPoint(x: 7, y: 7, xLabel: 'hihi'),
        ],
        [
          GraphPoint(x: 0, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 1, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 2, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 3, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 4, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 5, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 6, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 7, y: 1, xLabel: 'hihi'),
        ],
        [
          GraphPoint(x: 0, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 1, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 2, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 3, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 4, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 5, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 6, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 7, y: 1, xLabel: 'hihi'),
        ],
        [
          GraphPoint(x: 0, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 1, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 2, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 3, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 4, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 5, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 6, y: 1, xLabel: 'hihi'),
          GraphPoint(x: 7, y: 1, xLabel: 'hihi'),
        ],
      ],
      tables: [
        TableContent(
          rows: [
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
          ]
        ),
        TableContent(
          rows: [
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
            ['item1', 'item2', 'item3', 'item4'],
          ]
        )
      ]
    );
  }
}
