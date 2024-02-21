import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

bool _keyboardVisible = false;
late StreamSubscription<bool> keyboardSubscription;
var keyboardVisibilityController = KeyboardVisibilityController();
class AdmobBannerAd extends StatefulWidget {
  AdmobBannerAd({super.key, required this.child, required this.adUnitId});

  var child;
  String adUnitId;

  @override
  State<AdmobBannerAd> createState() => _AdmobBannerAdState();
}

class _AdmobBannerAdState extends State<AdmobBannerAd> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MobileAds.instance.initialize();

    // TODO: Load a banner ad


    BannerAd(
      adUnitId: widget.adUnitId,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    print('_bannerAd$_bannerAd');
    print('Keyboard1234$_keyboardVisible');
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardVisible=visible;
      });
      print('Keyboard visibility update. Is visible: $visible');
    });
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: KeyboardDismissOnTap(
              dismissOnCapturedTaps: true,
              child: widget.child,
            ),
            flex: 1,
          ),
          if (_bannerAd != null)
            Visibility(
              visible: !_keyboardVisible,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 2.0),
                  color: Colors.black12,
                  height: _bannerAd!.size.height.toDouble(),
                  width: _bannerAd!.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    if (_bannerAd != null) _bannerAd?.dispose();

    super.dispose();
  }
}
