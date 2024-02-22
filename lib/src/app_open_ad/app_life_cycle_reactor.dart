
import 'package:aswdc_admob/src/app_open_ad/app_open_ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Listens for app foreground events and shows app open ads.
class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    print('___________listenToAppStateChanges');
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    print('___________onAppStateChanged');
    if (appState == AppState.foreground) {
      print('_________onAppStateChanged appState ==$appOpenAdManager');
      appOpenAdManager.showAdIfAvailable();
    }
  }
}