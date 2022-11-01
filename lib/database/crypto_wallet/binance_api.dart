import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/crypto_wallet/binance.dart';

class BinanceApi {
  Future<Binance?> getPrice() async {
    Binance? coin;
    try {
      print('data in try');
      String temp;
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
      print(e.toString());
    }
    return coin;
  }
}
