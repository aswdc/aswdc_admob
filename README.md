<?code-excerpt path-base="excerpts/packages/url_launcher_example"?>

# ASWDC FLUTTER PUB

[![pub package]](https://pub.dev/packages/url_launcher)

A Flutter plugin for launching a URL.

|             | Android | iOS   | Linux | macOS  | Web | Windows     |
|-------------|---------|-------|-------|--------|-----|-------------|
| **Support** | SDK 16+ | 11.0+ | Any   | 10.14+ | Any | Windows 10+ |

## Usage

To use this plugin, add `url_launcher` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example


<?code-excerpt "basic.dart (basic-example)"?>
``` dart
For Android 
    - register admob app id in AndroidManifest.xml
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-3940256099942544~3347511713"/>
// Sample dart code for AdmobBannerAd implementation

import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:aswdc_admob/aswdc_admob.dart';
import 'package:flutter/material.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// Start Open App Ad Implementation
  late AppLifecycleReactor _appLifecycleReactor;
  String appOpenAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-3940256099942544/5575463023';
// End Open App Ad Implementation
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Start Open App Ad Implementation
    print("______________init state");
    AppOpenAdManager appOpenAdManager = AppOpenAdManager(adUnitId: appOpenAdUnitId)..loadAd();
    _appLifecycleReactor = AppLifecycleReactor(
        appOpenAdManager: appOpenAdManager);
    _appLifecycleReactor.listenToAppStateChanges();
    print("______________init state");
    // End Open App Ad Implementation
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SafeArea(
        child: Scaffold(
          body: AdmobBannerAd(
              child: Expanded(
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

```
passing a `LaunchMode`.