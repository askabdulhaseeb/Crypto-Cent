
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
    _payableBalance = 0;
    for (int i = 0; i < paymentpro.receipt.length; i++) {
      for (int j = 0; j < paymentpro.order.length; j++) {
        if (paymentpro.receipt[i].receiptID == paymentpro.order[j].receiptID) {
          if (paymentpro.order[j].status == OrderStatusEnum.pending) {
            _payableBalance += paymentpro.receipt[i].totalLocalAmount;
          }
        }
      }
    }
    
  }

  Future<bool> load() async {
    if (AuthMethods.getCurrentUser == null) return false;
    bool temp = false;
    String id = AuthMethods.uid;
    _allWallets = await WalletsApi().get();
    for (int i = 0; i < _allWallets.length; i++) {
      if (_allWallets[i].walletId == id) {
        _wallet = _allWallets[i];
        break;
      }
    }
    temp = true;
    getBalance();
    return temp;
  }

  bool getSellerWallet(String id) {
    bool temp = false;
    for (int i = 0; i < _allWallets.length; i++) {
      if (_allWallets[i].walletId == id) {
        temp = true;
        _sellerWallet = _allWallets[i];
        break;
      }
    }
    return temp;
  }

  getBalance() async {
    double tempBalance = 0;
    String walletIDD = Encryption().appDecrypt(_wallet!.coinsWallet[0].wallet);
   
    tempBalance = await WallletWithApi().getWalletBalance(walletIDD);
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
  Wallets? _wallet;
  Wallets? get wallet => _wallet;
  List<Wallets> _allWallets = <Wallets>[];
  List<Wallets> get allWallets => _allWallets;
  Wallets? _sellerWallet;
  Wallets? get sellerWallet => _sellerWallet;
  //double payableBalance = 0;
}
