import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final List<GraphPoint> points;

  Graph({ this.points });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) =>
                const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
                getTitles: (value) {
                  return '${points[value.toInt()].xLabel}';
                },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: points.map<FlSpot>((item) => FlSpot(item.x, item.y)).toList(),
              colors: [
                const Color(0xff4af699),
              ],
            ),
          ]
        ),
      ),
    );
  }
}

class GraphPoint {
  final double x;
  final double y;
  final String xLabel;

  GraphPoint({ this.x, this.y, this.xLabel });
}