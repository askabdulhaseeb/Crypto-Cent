import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../models/crypto_wallet/wallet_histroty.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../../widgets/wallet/wallet_history_tile.dart';

class BitcoinHistroyScreen extends StatelessWidget {
  const BitcoinHistroyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    String walletID = walletPro.wallet == null
        ? 'loading'
        : Encryption().appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          leading: IconButton(
              onPressed: (() {
                //Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back_ios_sharp)),
        ),
        body: FutureBuilder<WalletHistory?>(
          future: WallletWithApi().getWalletHistory(walletID),
          builder: (
            BuildContext context,
            AsyncSnapshot<WalletHistory?> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Facing issues while fetching the history'),
              );
            } else if (snapshot.hasData) {
              final WalletHistory? history = snapshot.data;
              if (history == null) {
                return const Center(
                  child: Text('Facing issues while fetching the history'),
                );
              } else {
                return history.items.isEmpty
                    ? const Center(
                        child: Text('No History available to display'),
                      )
                    : ListView.builder(
                        itemCount: history.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final WalletItem item = history.items[index];
                          return WalletHistoryTile(item: item);
                        });
              }
            } else {
              return const ShowLoading();
            }
          },
        ),
        );
  }
}
