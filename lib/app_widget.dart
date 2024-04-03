
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/home_page.dart';

class AppWidget extends StatelessWidget {

  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}