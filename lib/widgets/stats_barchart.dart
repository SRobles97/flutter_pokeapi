import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/models/stats.dart';

class StatsBarChart extends StatelessWidget {
  final Stats stats;
  final Color color;

  const StatsBarChart({super.key, required this.stats, required this.color});

  @override
  Widget build(BuildContext context) {
    Map<String, int> statsMap = stats.toMap();
    final barGroups = statsMap.entries.map((entry) {
      final index = statsMap.keys.toList().indexOf(entry.key);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: color,
            width: 16,
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${statsMap.keys.elementAt(group.x.toInt())}: ${rod.toY}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < statsMap.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(statsMap.keys.elementAt(index),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              )),
                    );
                  }
                  return const Text('');
                },
                reservedSize: 30,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < statsMap.length) {
                    return Text(
                      '${statsMap.values.elementAt(index)}',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            )),
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
      ),
    );
  }
}
