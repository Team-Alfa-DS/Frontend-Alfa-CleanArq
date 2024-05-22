import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Fit Your Body And Make Your Healthy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          CustomCircularPercentIndicator(
            radius: 60,
            lineWidth: 15,
            percent: 0.2,
            centerText: '20%',
            progressColor: Colors.deepPurple,
            centerTextColor: Colors.deepPurple,
          ),
        ],
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

  const CustomCircularPercentIndicator({super.key, 
    required this.radius,
    required this.lineWidth,
    required this.percent,
    required this.centerText,
    required this.progressColor,
    required this.centerTextColor,
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
            style: TextStyle(color: centerTextColor),
            overflow: TextOverflow.clip,
          ),
          progressColor: progressColor,
        ),
      ),
    );
  }
}
