import 'package:flutter/material.dart';
import 'package:parttime/core/admob/provider.dart';
import 'package:provider/provider.dart';

class InterstitialAd extends StatelessWidget {
  const InterstitialAd({super.key});

  @override
  Widget build(BuildContext context) {
    final adProvider = Provider.of<AdProvider>(context);

    if (!adProvider.isBannerAdLoaded) {
      adProvider.loadBannerAd();
    }
    adProvider.loadInterstitialAd();
    return const SizedBox();
  }
}
