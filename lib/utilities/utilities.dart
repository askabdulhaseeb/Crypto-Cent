import 'package:url_launcher/url_launcher.dart';
class Utilities {
  static double get mobileMaxWidth => 400;
  static double get tabMaxWidth => 720;
  static double get desktopMaxWidth => 800;
  static double get maxWidth => 1000;
  static String get firebaseServerID =>
      'AAAAkU8lP00:APA91bGdUVxn6InaIrZaftdLE6__tP1A3RWL0WKGxYk8jagQxk8H8-3Ims7GKL8B4FT8JP0kmMbYpVQrvMJSpmmVT3FfTY-Yt9ZLrQQ9xyC6g0xk1aNoH_wFsPLPnF3wluTwDykQTiWj';
  Future<void> launchURL(String value) async {
    if (!await launchUrl(Uri.parse(value))) {
      throw Exception('Could not launch $value');
    }
  }
}

