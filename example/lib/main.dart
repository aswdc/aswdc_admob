import 'package:aswdc_admob/aswdc_admob.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          body: AdmobBannerAd(
              widget: Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  )),
              adUnitId: 'ca-app-pub-3940256099942544/6300978111'),
        ),
      ),
    );
  }
}
