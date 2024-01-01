import 'package:blurry/blurry.dart';
import 'package:ders7_hava_durumu/Widgets/splash_screen_widget.dart';
import 'package:ders7_hava_durumu/visual/homePage.dart';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  String selectedCity = '';

  void fillCity(){
    setState(() {
      selectedCity = controller.text;
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lokasyon bulunamadı',style: TextStyle(fontSize: 20),),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Lütfen geçerli bir lokasyon girin.',style: TextStyle(fontSize: 13),),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _alert() async{
    return EmojiAlert(
      alertTitle:  const Text("Hatalı konum", style:  TextStyle(fontWeight:  FontWeight.bold,color: Colors.white)),
      description:  const Column(
        children: [
          Text("Geçerli bir konum girin",style: TextStyle(color: Colors.white),),
        ],
      ),
      enableMainButton:  true,
      background: Color(0xFF4f4f4f),
      mainButtonColor:  Colors.yellow,
      mainButtonText: Text("Tamam",style: TextStyle(color: Colors.white),),
      onMainButtonPressed: () {
        print("Hello");
        Navigator.pop(context);
      },
      cancelable:  false,
      emojiType:  EMOJI_TYPE.SAD,
      height:  250,
    ).displayAlert(context);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/search.jpg'),
          fit: BoxFit.cover,

        ),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // leading: BackButton(
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen(screen: HomePage()),));
            //   },
            // ),
            // automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: controller,
                    // onChanged: (value) {
                    //   selectedCity = value;
                    // },
                    decoration: const InputDecoration(
                      hintText: "Choose City",
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    style: const TextStyle(fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,elevation: 1),
                    onPressed: () async{
                    fillCity();


                    var response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$selectedCity&appid=abd9b969c7254ca1625702e13ac39204&units=metric'));
                    if(response.statusCode == 200){
                      Navigator.pop(context,selectedCity);


                    }else{
                      // _showMyDialog();
                      _alert();

                    }


                    print(selectedCity);

                     // Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreenData(screen: HomePage()),);


                }, child: const Text("Select City",style: TextStyle(fontSize: 20),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
