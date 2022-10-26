import 'package:flutter/cupertino.dart';

import '../../database/crypto_wallet/wallet_api.dart';
import '../../models/crypto_wallet/wallet.dart';

class WalletProvider with ChangeNotifier {
  Wallets? _wallet;
  Wallets? get wallet => _wallet;
  Future<bool> load(String value) async {
    bool temp = false;
    _wallet = await WalletsApi().get(value);
    temp = true;
    return temp;
  }
}
