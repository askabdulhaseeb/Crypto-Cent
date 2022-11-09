import 'package:flutter/cupertino.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/crypto_wallet/wallet_api.dart';
import '../../models/crypto_wallet/wallet.dart';

class WalletProvider with ChangeNotifier {
  Wallets? _wallet;
  Wallets? get wallet => _wallet;
  Future<bool> load() async {
    bool temp = false;
    String id = AuthMethods.uid;
    List<Wallets> wallets = await WalletsApi().get();
    for (int i = 0; i < wallets.length; i++) {
      if (wallets[i].walletId == id) {
        _wallet = wallets[i];
        break;
      }
    }
    temp = true;
    return temp;
  }
}
