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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4),
      appBar: AppBar(
        title: const Text(
          "Lamjung",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: getData,
            icon: const FaIcon(
              FontAwesomeIcons.rotate,
              size: 20,
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
                  color: Colors.purple,
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
                    "${data!.desc}",
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
                    // height: 40,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(100, 1, 111, 185),
                      borderRadius: BorderRadius.circular(20),
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
                            "${data?.wind}km/h (${data?.winddeg})",
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                    child: Container(
                      // height: 220,
                      width: size.width - 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(100, 1, 111, 185),
                        borderRadius: BorderRadius.circular(10),
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
                            denote: 'mbar',
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
                        "Data provided in part by ",
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
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
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
              fontSize: 16,
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
              fontSize: 16,
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
