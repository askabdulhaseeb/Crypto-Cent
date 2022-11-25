import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../database/app_user/auth_method.dart';
import '../../database/crypto_wallet/wallet_api.dart';
import '../../database/crypto_wallet/wallet_create_api.dart';
import '../../enum/order_status_enum.dart';
import '../../function/encryption_function.dart';
import '../../models/crypto_wallet/wallet.dart';
import '../payment/payment_provider.dart';

class WalletProvider with ChangeNotifier {
  WalletProvider() {
    load();
  }
  update(PaymentProvider paymentpro) {
    for (int i = 0; i < paymentpro.receipt.length; i++) {
      for (int j = 0; j < paymentpro.order.length; j++) {
        if (paymentpro.receipt[i].receiptID == paymentpro.order[j].receiptID) {
          if (paymentpro.order[j].status == OrderStatusEnum.pending) {
            _payableBalance += paymentpro.receipt[i].totalLocalAmount;
          }
        }
      }
    }
    log('Payabale Balance : $_payableBalance');
  }

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
    getBalance();
    return temp;
  }

  getBalance() async {
    double tempBalance = 0;
    String WalletId = Encryption().appDecrypt(_wallet!.coinsWallet[0].wallet);
    log('Wallet ID: $WalletId');
    tempBalance = await WallletWithApi().getWalletBalance(WalletId);
    _balance = tempBalance;
    notifyListeners();
  }

  Future<double> currentBalance() async {
    String walletId = Encryption().appDecrypt(_wallet!.coinsWallet[0].wallet);
    double tempBalance = await WallletWithApi().getWalletBalance(walletId);
    return tempBalance - _payableBalance;
  }

  double _balance = 0;
  double get balance => _balance;
  double _payableBalance = 0;
  double get payableBalance => _payableBalance;
  //double payableBalance = 0;
}
