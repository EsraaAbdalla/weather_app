// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

WeatherModel? weatherData;

class WeatherServices {
  String baseUrl = 'http://api.weatherapi.com/v1';

  String apiKey = '128582193c04450dbbb230226232704';

  Future<WeatherModel?> getweather({required String cityName}) async {
    // WeatherModel? weatherData;
    print(cityName);
    try {
      Uri url =
          Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');

      http.Response response = await http.get(url);

      Map<String, dynamic> jsonData = jsonDecode(response.body);
      // Map<String, dynamic> data = jsonData['consolidated_weather'][0];

      weatherData = WeatherModel.fromJson(jsonData);
      print("henaaa:$weatherData");
    } catch (e) {
      print(e);
    }
    return weatherData;
  }
}
