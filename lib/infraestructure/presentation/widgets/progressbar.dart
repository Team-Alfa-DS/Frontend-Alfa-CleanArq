import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressSection extends StatelessWidget {
  const ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        color: Colors.white,
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entrena tu cuerpo y se alguien saludable.',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: 10), // Añadí un espacio entre los dos textos
                      Text(
                        'Última actualización hace 30 minutos',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                CustomCircularPercentIndicator(
                  radius: 60,
                  lineWidth: 5,
                  percent: 0.2,
                  centerText: '20%\nHecho',
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
            style: TextStyle(color: centerTextColor, fontSize: centerTextSize),
            textAlign: TextAlign.center,
          ),
          progressColor: progressColor,
        ),
      ),
    );
  }
}
