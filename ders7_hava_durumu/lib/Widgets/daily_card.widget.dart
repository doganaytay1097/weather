import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyWeatherCard extends StatelessWidget {
   DailyWeatherCard({super.key, required this.image, required this.temperature, required this.date});

  final String image;
  final double temperature;
  final String date;

  // final DateTime weekday = DateTime.parse(date);

  @override
  Widget build(BuildContext context) {

    List<String> weekdays = ['Pazartesi ','Salı','Çarşamba','Perşembe','Cuma','Cumartesi','Pazar'];

    String weekday = weekdays[DateTime.parse(date).weekday - 1];


    return Card(
      color: Colors.transparent,
      child: SizedBox(
        height: 120,
        width: 80,
        child: Column(
          children: [
            Image.network('https://openweathermap.org/img/wn/$image.png'),
            Text(
              "$temperature°C",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(weekday),
            Text('15.00')
          ],
        ),
      ),
    );
  }
}
