import 'package:aboutlamjung/model/weathermodel.dart';
import 'package:aboutlamjung/services/weatherapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  @override
  void initState() {
    super.initState();
  }

  Future<void> getData() async {
    data = await client.getCurrentData("Lamjung");
  }

  String getSunTime(int? timestamp) {
    if (timestamp == null) {
      return "null";
    }
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formattedTime = DateFormat('HH:mm').format(dateTime);

    return formattedTime;
  }

  String firstLetter(String? input) {
    if (input == null) {
      return "null";
    }

    return input[0].toUpperCase() + input.substring(1);
  }

  String getDirection(int? angle) {
    if (angle == null) {
      return "";
    }
    if (angle >= 0 && angle < 22.5) {
      return 'N';
    } else if (angle >= 22.5 && angle < 67.5) {
      return 'NE';
    } else if (angle >= 67.5 && angle < 112.5) {
      return 'E';
    } else if (angle >= 112.5 && angle < 157.5) {
      return 'SE';
    } else if (angle >= 157.5 && angle < 202.5) {
      return 'S';
    } else if (angle >= 202.5 && angle < 247.5) {
      return 'SW';
    } else if (angle >= 247.5 && angle < 292.5) {
      return 'W';
    } else if (angle >= 292.5 && angle < 337.5) {
      return 'NW';
    } else if (angle >= 337.5 && angle < 360) {
      return 'N';
    } else {
      return 'Invalid angle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 231, 231, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(
              Icons.cloud_rounded,
              color: Color(0xFF1B1B1B),
              size: 30,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Weather",
              style: TextStyle(
                color: Color(0xFF1B1B1B),
                fontFamily: 'Rubik',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: getData,
            icon: const FaIcon(
              FontAwesomeIcons.rotate,
              size: 20,
              color: Color(0xFF1B1B1B),
            ),
          )
        ],
        //backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 200, left: 190),
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data!.temp}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 80,
                              fontFamily: 'Rubik',
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 13.0),
                            child: Text(
                              "°",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 7.0),
                            child: Text(
                              "c",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    firstLetter(data!.desc),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * 0.06,
                    width: size.width * 0.5,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(90, 27, 27, 27),
                          blurRadius: 4,
                          offset: Offset(0, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.wind,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${data?.wind}m/s (${getDirection(data?.winddeg)})",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(90, 27, 27, 27),
                            blurRadius: 4,
                            offset: Offset(0, 8), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Additional Informations:",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ),
                          ExtraWeatherRow(
                            which: 'Humidity',
                            amount: "${data?.humidity}",
                            denote: '%',
                          ),
                          ExtraWeatherRow(
                            which: 'Real feel',
                            amount: "${data?.feelslike}",
                            denote: '°',
                          ),
                          ExtraWeatherRow(
                            which: 'Pressure',
                            amount: "${data?.pressure}",
                            denote: 'hPa',
                          ),
                          ExtraWeatherRow(
                            which: 'sunrise',
                            amount: getSunTime(data?.sunrise),
                            denote: '',
                          ),
                          ExtraWeatherRow(
                            which: 'sunset',
                            amount: getSunTime(data?.sunset),
                            denote: '',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Data provided by ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                      Icon(CupertinoIcons.sun_haze_fill),
                      Text(
                        " OpenWeather",
                        style: TextStyle(
                          color: Color(0xFF016FB9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class ExtraWeatherRow extends StatelessWidget {
  const ExtraWeatherRow({
    super.key,
    required this.which,
    required this.amount,
    required this.denote,
  });
  final String which;
  final String amount;
  final String denote;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
            top: 8,
            bottom: 8,
          ),
          child: Text(
            which,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0, top: 8, bottom: 8),
          child: Text(
            "$amount$denote",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
        ),
      ],
    );
  }
}

class RowWeatherDetails extends StatelessWidget {
  const RowWeatherDetails({
    super.key,
    required this.min,
    required this.max,
    required this.weather,
    required this.day,
    required this.icon,
  });
  final IconData icon;
  final String min;
  final String max;
  final String weather;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 10,
            bottom: 8,
          ),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: SizedBox(
            width: 230,
            child: Text(
              "$day, $weather",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),
          ),
        ),
        // const SizedBox(
        //   width: 130,
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            "$max° / $min°",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
        ),
      ],
    );
  }
}
