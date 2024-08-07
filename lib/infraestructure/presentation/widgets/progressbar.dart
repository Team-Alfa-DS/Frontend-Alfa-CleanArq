import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressSection extends StatelessWidget {
  final double percent;

  const ProgressSection({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entrena tu cuerpo y se alguien saludable.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: 10), // Añadí un espacio entre los dos textos
                      Text(
                        'Última actualización hace 30 minutos',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
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
