import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SimpleLineChart extends StatelessWidget {
  final List<double> values;
  const SimpleLineChart({Key? key, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Dynamic Y but capped at 10k
    final double maxValue = values.reduce((a, b) => a > b ? a : b);
    final double maxY = (((maxValue + 1000) ~/ 1000) * 1000).clamp(0, 10000).toDouble();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Steps Overview",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Chart with smaller height
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(handleBuiltInTouches: true),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                    // ✅ Y-Axis (Dynamic + capped at 10k)
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        interval: 2000,
                        getTitlesWidget: (value, meta) {
                          if (value % 2000 == 0 && value <= maxY) {
                            return Text(
                              "${(value ~/ 1000)}K",
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),

                    // ✅ X-Axis
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                          ];
                          final idx = value.toInt();
                          if (idx >= 0 && idx < months.length) {
                            return Text(
                              months[idx],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),

                  // ✅ Chart line
                  lineBarsData: [
                    LineChartBarData(
                      spots: values.asMap().entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.clamp(0, 10000)))
                          .toList(),
                      isCurved: true,
                      curveSmoothness: 0.3,
                      color: Colors.cyan.shade600,
                      barWidth: 2.5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.cyan.shade600.withOpacity(0.4),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],


                  minX: 0,
                  maxX: 11,
                  minY: 0,
                  maxY: maxY, // ✅ Dynamic but capped at 10k
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
