import 'package:http/http.dart' as http;
import 'dart:convert';

class City {
  final int temp;
  final String description;
  final String currently;
  final String time;
  final String cityName;
  final List<Forecast> forecast;

  const City({
      required this.temp,
      required this.description,
      required this.currently,
      required this.time,
      required this.cityName,
      required this.forecast});

  factory City.fromJson(Map<String, dynamic> json) {
    var forecastJson = json['forecast'] as List;
    List<Forecast> forecastList =
    forecastJson.map((forecast) => Forecast.fromJson(forecast)).toList();

    return City(
        temp: json['temp'],
        description: json['description'],
        currently: json['currently'],
        time: json['time'],
        cityName: json['city_name'],
        forecast: forecastList,
    );
  }
}

class Forecast {
  final String date;
  final String weekday;
  final int max;
  final int min;

  const Forecast({
    required this.date,
    required this.weekday,
    required this.max,
    required this.min
  });

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
        date: json['date'],
        weekday: json['weekday'],
        max: json['max'],
        min: json['min']);
  }
}

class CityWeatherService {
  Future<City> getCity(String cityName) async {
    final response = await http
        .get(Uri.parse("https://api.hgbrasil.com/weather?key=86a143dd&city_name=$cityName"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['results'];

      final City city = City.fromJson(data);

      return city;
    } else {
      throw Exception('HTTP Failed');
    }
  }
}
