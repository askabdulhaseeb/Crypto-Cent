import '../../models/crypto_wallet/coin_wallet.dart';
import '../../models/crypto_wallet/wallet.dart';
import '../app_user/auth_method.dart';
import 'wallet_api.dart';
import 'wallet_create_api.dart';

class WalletCreation {
  Future<bool> addWallet() async {
    List<CoinsWallet> coinsWallet = await WallletWithApi().createWallet();
    final Wallets wallets = Wallets(
      coinsWallet: coinsWallet,
      walletId: AuthMethods.uid,
    );
    bool temp1 = await WalletsApi().add(wallets);
    return temp1;
  }
}
