import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:aswdc_admob/aswdc_admob.dart';
import 'package:flutter/material.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLifecycleReactor _appLifecycleReactor;
  String appOpenAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-3940256099942544/5575463023';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print("______________init state");
    AppOpenAdManager appOpenAdManager = AppOpenAdManager(adUnitId: appOpenAdUnitId)..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
        appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
    print("______________init state");
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          body: AdmobBannerAd(
              adUnitId: 'ca-app-pub-3940256099942544/6300978111',
              child: Expanded(
                  child: Container(
                    color: Colors.amber,
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a search term',
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
