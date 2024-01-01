import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:ders7_hava_durumu/Widgets/daily_card.widget.dart';
import 'package:ders7_hava_durumu/Widgets/splash_screen_widget.dart';
import 'package:ders7_hava_durumu/visual/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String location = 'Bursa';
  String weather = 'c';
  String? image = '10d';
  late DateTime dateTime;

  void getInitialData() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      await getDevicePosition();
      await getLocationDataByLatLon();
      await getDailyForecastDataByLatLon();
    } else {
      await getDailyWeatherLatLon(40.193298,29.074202);
      await getDailyForecastLatLon(40.193298,29.074202);
    }
  }

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  double? temperature;
  Position? devicePosition;

  final String key = 'abd9b969c7254ca1625702e13ac39204';
  var locationData;
  var forecastData;


  Future<void> getLocationDataByLatLon() async {
    if (devicePosition != null) {
      locationData = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${devicePosition!
              .latitude}&lon=${devicePosition!
              .longitude}&appid=$key&units=metric'));
      final locationDataParsed = jsonDecode(locationData.body);

      setState(() {
        temperature = locationDataParsed['main']['temp'];
        location = locationDataParsed['name'];
        weather = locationDataParsed['weather'].first['main'];
        image = locationDataParsed['weather'][0]['icon'];
        // weather = locationDataParsed['weather'][0]['main'];
      });
    }
  } //Current weather data with location
  Future<void> getDailyForecastDataByLatLon() async {
    if (devicePosition != null) {
      forecastData = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=${devicePosition!
              .latitude}&lon=${devicePosition!
              .longitude}&appid=$key&units=metric'));
      var forecastDataParsed = jsonDecode(forecastData.body);

      temperatures.clear();
      images.clear();
      dates.clear();

      setState(() {
        for(int i=5;i<40;i=i+8){
          temperatures.add(forecastDataParsed['list'][i]['main']['temp']);
          images.add(forecastDataParsed['list'][i]['weather'][0]['icon']);
          dates.add(forecastDataParsed['list'][i]['dt_txt']);
          // dateTime = DateTime.parse(forecastDataParsed['list'][i]['dt_txt']);
          // dates.add(weekdays[dateTime.weekday-1]);
        }
      });
    }


  }

  Future<void> getDailyWeatherLatLon(double lat,double long) async {

      locationData = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key&units=metric'));
      var locationDataParsed = jsonDecode(locationData.body);

      setState(() {
        temperature = locationDataParsed['main']['temp'];
        location = locationDataParsed['name'];
        weather = locationDataParsed['weather'].first['main'];
        image = locationDataParsed['weather'][0]['icon'];
        // weather = locationDataParsed['weather'][0]['main'];
      });

  }
  Future<void> getDailyForecastLatLon(double lat,double long) async {

      forecastData = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$key&units=metric'));
      var forecastDataParsed = jsonDecode(forecastData.body);

      temperatures.clear();
      images.clear();
      dates.clear();

      setState(() {
        for(int i=5;i<40;i=i+8){
          temperatures.add(forecastDataParsed['list'][i]['main']['temp']);
          images.add(forecastDataParsed['list'][i]['weather'][0]['icon']);
          dates.add(forecastDataParsed['list'][i]['dt_txt']);
          // dateTime = DateTime.parse(forecastDataParsed['list'][i]['dt_txt']);
          // dates.add(weekdays[dateTime.weekday-1]);
        }
      });



  }



  Future<void> getDevicePosition() async {
    try {
      devicePosition = await _determinePosition();
    } catch (e) {
      print(e);
    }
  }

  void _navigate(Widget navigation) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigation,
        ));
  }

  List<String> images = [];
  List<double> temperatures = [];
  List<String> dates = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$weather.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: (temperature == null || temperatures.isEmpty)
        // || devicePosition == null
            ? const SplashScreen(screen: HomePage())
            : Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Image.network(
                    'https://openweathermap.org/img/wn/$image@4x.png',
                  ),
                ),
                Text(
                  "$temperature°C",
                  style: const TextStyle(
                    shadows: <Shadow>[Shadow(color: Colors.black,blurRadius: 10,offset: Offset(10, 5))],
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location,
                      style: const TextStyle(
                        shadows: <Shadow>[Shadow(color: Colors.black,blurRadius: 7,offset: Offset(6, 3))],
                        fontSize: 30,
                      ),
                    ),
                    IconButton(

                      onPressed: () async {

                        final selectedCity = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const SearchPage()));
                        List<Location> locations = await locationFromAddress(selectedCity);
                        setState(() {
                          Location loc = locations.first;
                          location = selectedCity;

                          getDailyWeatherLatLon(loc.latitude, loc.longitude);
                          getDailyForecastLatLon(loc.latitude, loc.longitude);
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: buildWeatherCard(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeatherCard(BuildContext context) {
    List<DailyWeatherCard> card = [];
    for (int i = 0; i < 5; i++) {
      card.add(DailyWeatherCard(
          image: images[i], temperature: temperatures[i], date: dates[i]));
    }

    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.18,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      child: ListView(scrollDirection: Axis.horizontal, children: card),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
