import 'package:flutter/material.dart';
import 'package:my_weather/hg_services.dart';
import 'package:my_weather/weather_page.dart';

class HomePage extends StatelessWidget {
  final cities = [
    'Campinas,SP',
    'São Paulo,SP',
    'Rio de Janeiro,RJ'
  ];

  HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cities')),
        body: ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final city = cities[index];
              return ListTile(
                title: Text('$city'),
                onTap: () => openPage(context, city),
                trailing: const Icon(Icons.chevron_right_outlined),
              );
            }));
  }

  openPage(context, String city) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WeatherPage(city: city)));
  }
}
