import 'dart:convert';

import 'package:aboutlamjung/model/weathermodel.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<Weather>? getCurrentData(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=52f88d0fb92f73bc8b4b7f621e0c4bbb&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}
