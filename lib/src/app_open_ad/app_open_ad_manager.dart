import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  AppOpenAdManager({required this.adUnitId});

  String adUnitId;

  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;

  /// Load an AppOpenAd.
  void loadAd() {
    AppOpenAd.load(
      adUnitId: adUnitId,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          print('________________AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  bool get isAdAvailable {
    return _appOpenAd != null;
  }

  /// Whether an ad is available to be shown.
  void showAdIfAvailable() {
    print(' ________________AppOpenAd isAdAvailable $isAdAvailable');
    if (!isAdAvailable) {
      print(' ________________AppOpenAd Tried to show ad before available.');
      loadAd();
      return;
    }
    print(' ________________AppOpenAd _isShowingAd $_isShowingAd');
    if (_isShowingAd) {
      print('________________AppOpenAd Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        print('$ad ________________AppOpenAd onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('$ad ________________AppOpenAd onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        print('$ad ________________AppOpenAd onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAd();
      },
    );
    _appOpenAd!.show();
  }
}
