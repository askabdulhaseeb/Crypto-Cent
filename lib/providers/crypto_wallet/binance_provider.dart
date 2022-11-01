import 'package:flutter/cupertino.dart';
import '../../database/crypto_wallet/binance_api.dart';
import '../../models/crypto_wallet/binance.dart';

class BinanceProvider with ChangeNotifier {
  BinanceProvider() {
    load();
  }
  Binance? _coin;
  Binance get coin => _coin!;
  Future<void> load() async {
    _coin = await BinanceApi().getPrice();
    notifyListeners();
  }
}
