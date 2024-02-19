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
            android:value="admob android app id "/>
// Sample dart code for AdmobBannerAd implementation

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

```
passing a `LaunchMode`.