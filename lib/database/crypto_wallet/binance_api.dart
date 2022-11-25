import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../models/crypto_wallet/binance.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class BinanceApi {
  Future<Binance?> getPrice() async {
    Binance? coin;
    try {
      String url = 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT';
      http.Response response = await http.get(Uri.parse(url));
      // ignore: always_specify_types
      var json = jsonDecode(response.body);
      //  print(json['symbol']);
      Binance coinData = Binance(
        price: double.parse(json['price']),
        symbol: json['symbol'] ?? '',
      );
      coin = coinData;
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return coin;
  }

  Future<double> btcPrice() async {
    try {
      String url = 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT';
      http.Response response = await http.get(Uri.parse(url));
      dynamic json = jsonDecode(response.body);
      return double.parse(json['price']);
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return 0;
  }
}
