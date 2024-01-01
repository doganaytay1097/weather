main (){
  List<String> weekdays = ['Pazartesi','Salı','Çarşamba','Perşembe','Cuma','Cumartesi','Pazar'];
  DateTime simdi = DateTime.now();

  print(simdi);

  DateTime cumhuriyet = DateTime.utc(1923,10,29,9,30);

  print(cumhuriyet);

  DateTime localTime = DateTime.parse('2023-12-30');
  print(localTime);

  print(localTime.weekday);

  print(weekdays[localTime.weekday-1]);
}
//
// Future<void> getLocationDataByLocation() async {
//   locationData = await http.get(Uri.parse(
//       'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric'));
//   final locationDataParsed = jsonDecode(locationData.body);
//
//   setState(() {
//     temperature = locationDataParsed['main']['temp'];
//     location = locationDataParsed['name'];
//     weather = locationDataParsed['weather'].first['main'];
//     image = locationDataParsed['weather'][0]['icon'];
//     // weather = locationDataParsed['weather'][0]['main'];
//   });
// }
// Future<void> getDailyForecastDataByLocation() async {
//   forecastData = await http.get(Uri.parse(
//       'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$key&units=metric'));
//   var forecastDataParsed = jsonDecode(forecastData.body);
//
//   temperatures.clear();
//   images.clear();
//   dates.clear();
//
//   setState(() {
//     for(int i=5;i<40;i=i+8){
//       temperatures.add(forecastDataParsed['list'][i]['main']['temp']);
//       images.add(forecastDataParsed['list'][i]['weather'][0]['icon']);
//       dates.add(forecastDataParsed['list'][i]['dt_txt']);
//     }
//
//   });
// }
// ElevatedButton(
//     onPressed: () async {
//       print(locationData);
//       await getLocationData();
//
//
//       final locationDataParsed = jsonDecode(locationData.body);
//
//       debugPrint('getLocationData() çağırıldıktan sonra $locationData');
//       debugPrint(locationDataParsed.toString());
//       debugPrint(locationDataParsed.runtimeType.toString());
//
//       print(locationDataParsed['main']['temp']);
//
//
//       /// Future.delayed(Duration(seconds: 3),() => print(locationData));
//     },
//     child: Text("getLocationData")),