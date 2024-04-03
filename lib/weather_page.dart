import 'package:flutter/material.dart';

import 'hg_services.dart';

class WeatherPage extends StatefulWidget {
  final String city;

  const WeatherPage({super.key, required this.city});

  @override
  _WeatherPage createState() => _WeatherPage(city: city);
}

class _WeatherPage extends State<WeatherPage> {
  late Future<City> futureCity;
  final String city;

  _WeatherPage({required this.city});

  @override
  void initState() {
    super.initState();
    futureCity = CityWeatherService().getCity(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: Center(
        child: FutureBuilder<City>(
            future: futureCity,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CItyWidget(
                      city: snapshot?.data,
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('ERROR: ${snapshot.error}'),
                );
              }
              return const CircularProgressIndicator();
            })),
      ),
    );
  }
}

class CItyWidget extends StatelessWidget {
  final City? city;

  const CItyWidget({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '${city?.cityName}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Temp. Hoje',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '${city?.temp} Cº',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}
