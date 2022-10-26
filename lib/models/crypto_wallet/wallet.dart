import 'package:cloud_firestore/cloud_firestore.dart';

import 'coin_wallet.dart';

class Wallets {
  Wallets({
    required this.walletId,
    required this.coinsWallet,
  });

  final String walletId;
  final CoinsWallet coinsWallet;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wallet_id': walletId,
      'coins_wallet': coinsWallet.toMap(),
    };
  }

  // ignore: sort_constructors_first
  factory Wallets.fromMap(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Wallets(
      walletId: doc.data()?['wallet_id'] ?? '',
      coinsWallet: CoinsWallet.fromMap(
          doc.data()?['coins_wallet'] ?? <String, dynamic>{}),
    );
  }
}
