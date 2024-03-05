import 'dart:async';
import 'dart:io';

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
  AnchoredAdaptiveBannerAdSize? size;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAd();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MobileAds.instance.initialize();

    // TODO: Load a banner ad

   /* BannerAd(
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
    ).load();*/
  }

  Future<void> _loadAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());
    print('$size Unable to get height of anchored banner.');
    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _bannerAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
      adUnitId: widget.adUnitId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _bannerAd!.load();
  }



  @override
  Widget build(BuildContext context) {
    print('_bannerAd$_bannerAd');
    print('Keyboard1234$_keyboardVisible');
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      setState(() {
        _keyboardVisible = visible;
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
          if (_bannerAd != null && _isLoaded)
            Visibility(
              visible: !_keyboardVisible,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
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
    super.dispose();
    _bannerAd?.dispose();
  }
}
