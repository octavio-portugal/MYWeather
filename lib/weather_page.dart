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
          Column(
            children: [
              Row(
                children: [
                  buildWeekDay(
                    weekDay: city?.forecast.first.weekday,
                    max: city?.forecast.first.max,
                    min: city?.forecast.first.min
                    ),
                  buildWeekDay(
                      weekDay: city?.forecast[1].weekday,
                      max: city?.forecast[1].max,
                      min: city?.forecast[1].min
                  ),
                  buildWeekDay(
                      weekDay: city?.forecast[2].weekday,
                      max: city?.forecast[2].max,
                      min: city?.forecast[2].min
                  ),
                ],
              ),
              Row(
                children: [
                  buildWeekDay(
                      weekDay: city?.forecast[3].weekday,
                      max: city?.forecast[3].max,
                      min: city?.forecast[3].min
                  ),
                  buildWeekDay(
                      weekDay: city?.forecast[4].weekday,
                      max: city?.forecast[4].max,
                      min: city?.forecast[4].min
                  ),
                  buildWeekDay(
                      weekDay: city?.forecast[5].weekday,
                      max: city?.forecast[5].max,
                      min: city?.forecast[5].min
                  ),
                ],
              ),
            ],
          )
        ]
    );
  }
}

class buildWeekDay extends StatelessWidget {
  const buildWeekDay({
    super.key,
    required this.weekDay,
    required this.max,
    required this.min
  });

  final String? weekDay;
  final int? max;
  final int? min;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 10, bottom: 20),
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 150,
      width: 100,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text('$weekDay',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10),
            child: Text('Max. $maxºC',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 10),
            child: Text('Min. $minºC',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildWeekDays(List<Forecast>? list) {
  return ListView.builder(
    itemCount: list?.length,
    itemBuilder: (context, index) {
      final post = list?[index];
      return Container(
        color: Colors.grey.shade300,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: 100,
        width: double.maxFinite,
        child: Row(
          children: [
            // Expanded(flex: 1, child: Image.network(post.url!)),
            // SizedBox(width: 10),
            Expanded(flex: 3, child: Text(post!.weekday)),
          ],
        ),
      );
    },
  );
}
