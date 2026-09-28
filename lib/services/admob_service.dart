import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  // Aap ki Real Banner Ad Unit ID
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5015993859793728/7762682708';
    }
    return null;
  }

  // SDK Initialize
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
  }
}