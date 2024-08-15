import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'add_cubit_state.dart';

class AddCubitCubit extends Cubit<AddCubitState> {
  AddCubitCubit() : super(AddCubitInitial());
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  void loadBannerAd(String adUnitId) {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          emit(AddLoaded(bannerAd: _bannerAd, isLoaded: true)); // Ad loaded
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          emit(AddError(bannerAd: null, isLoaded: false)); // Ad failed to load
        },
      ),
    )..load();
  }

  void loadInterstitialAd(String adUnitId) {
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
  Future<void> close() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    return super.close();
  }
}
