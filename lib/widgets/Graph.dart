import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final List<GraphPoint> points;

  Graph({ this.points });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 0, right: 40, top: 20, bottom: 20,
      ),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) => '${points[value.toInt()].xLabel}',
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: points.map<FlSpot>((item) => FlSpot(item.x, item.y)).toList(),
              colors: [
                Theme.of(context).primaryColor,
              ],
            ),
          ],
          borderData: FlBorderData(show: false),
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