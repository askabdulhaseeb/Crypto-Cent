import '../database/crypto_wallet/binance_api.dart';

class CryptoFunction {
  Future<double> btcPrinceLive({required double dollor}) async {
    final double exchangeRate = await BinanceApi().btcPrice();
    return dollor / exchangeRate;
  }

  static double btcPrince({required double dollor, required double rate}) {
    return dollor / rate;
  }
}
