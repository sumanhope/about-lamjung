class Weather {
  String? cityName;
  String? desc;
  double? temp;
  double? feelslike;
  int? pressure;
  int? humidity;
  double? wind;
  int? winddeg;
  int? sunrise;
  int? sunset;

  Weather({
    this.cityName,
    this.desc,
    this.temp,
    this.feelslike,
    this.pressure,
    this.humidity,
    this.wind,
    this.winddeg,
    this.sunrise,
    this.sunset,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    desc = json["weather"][0]["main"];
    temp = json["main"]["temp"];
    feelslike = json["main"]["feels_like"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    wind = json["wind"]["speed"];
    winddeg = json["wind"]["deg"];
    sunrise = json["sys"]["sunrise"];
    sunset = json["sys"]["sunset"];
  }
}
