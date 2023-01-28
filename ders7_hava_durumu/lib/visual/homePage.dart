
import 'package:ders7_hava_durumu/Widgets/splash_screen_widget.dart';
import 'package:ders7_hava_durumu/visual/searchPage.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigate(Widget navigation) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigation,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/c.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "20°C",
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Bursa",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _navigate(const SplashScreen(screen: SearchPage(),));
                      },
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
