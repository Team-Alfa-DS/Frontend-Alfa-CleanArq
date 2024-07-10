import 'package:alpha_gymnastic_center/common/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressSection extends StatelessWidget {
  final double percent;
  final String courseTitle;
  final DateTime lastTime;

  const ProgressSection({
    super.key,
    required this.percent,
    required this.courseTitle,
    required this.lastTime,
  });

  @override
  Widget build(BuildContext context) {
    final String lastSeenMessage = formatLastSeen(lastTime);

    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseTitle,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Última actualización $lastSeenMessage',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                CustomCircularPercentIndicator(
                  radius: 65,
                  lineWidth: 10,
                  percent: percent / 100,
                  centerText: '${percent.toInt()}%\nHecho',
                  progressColor: Colors.deepPurple,
                  centerTextColor: Colors.deepPurple,
                  centerTextSize: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCircularPercentIndicator extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final double percent;
  final String centerText;
  final Color progressColor;
  final Color centerTextColor;
  final double centerTextSize;

  const CustomCircularPercentIndicator({
    super.key,
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.centerText,
    required this.progressColor,
    required this.centerTextColor,
    required this.centerTextSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: CircularPercentIndicator(
          radius: radius,
          lineWidth: lineWidth,
          percent: percent,
          center: Text(
            centerText,
            style: TextStyle(
                color: centerTextColor,
                fontSize: centerTextSize,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          progressColor: progressColor,
        ),
      ),
    );
  }
}
