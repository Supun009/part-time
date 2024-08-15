import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdProvider extends ChangeNotifier {
  BannerAd? bannerAd;
  InterstitialAd? _interstitialAd;
  bool isBannerAdLoaded = false;
  bool isInterstitialAd = false;

  String get adUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  Future<void> loadBannerAd() async {
    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          bannerAd = null;
          isBannerAdLoaded = false;
          notifyListeners();
        },
      ),
    );
    bannerAd?.load();
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          // Handle error
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _interstitialAd = null; // Reset after showing
      },
    );

    _interstitialAd!.show();
  }

  @override
  void dispose() {
    bannerAd?.dispose();
    super.dispose();
  }
}
