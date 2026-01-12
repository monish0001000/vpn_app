import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vpn_provider.dart';

class SpeedGraph extends StatelessWidget {
  const SpeedGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VpnProvider>(
      builder: (context, provider, child) {
        if (provider.status != VpnStatus.connected) {
          return const SizedBox(height: 150);
        }

        return Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                // Download Speed Line (Cyan)
                LineChartBarData(
                  spots: provider.downloadSpots,
                  isCurved: true,
                  color: Colors.cyanAccent,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.cyanAccent.withOpacity(0.1),
                  ),
                ),
                // Upload Speed Line (Pink/Purple)
                LineChartBarData(
                  spots: provider.uploadSpots,
                  isCurved: true,
                  color: Colors.purpleAccent,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.purpleAccent.withOpacity(0.1),
                  ),
                ),
              ],
              minY: 0,
              maxY: 100, // Assuming max speed 100 Mbps for visual
            ),
          ),
        );
      },
    );
  }
}
