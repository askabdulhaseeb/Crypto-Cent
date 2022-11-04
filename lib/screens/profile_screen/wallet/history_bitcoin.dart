import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../models/crypto_wallet/wallet_histroty.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

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
          // ignore: always_specify_types
          actions: const [Icon(Icons.more_vert)],
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
                          final bool received =
                              history.items[index].type == 'receipt';
                          final WalletItem item = history.items[index];
                          DateFormat format = DateFormat('dd-MM-yy');
                          return ListTile(
                            leading: const Icon(Icons.attach_money_outlined),
                            title: Text(
                              item.id,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Status: ${item.isConfirmed}',
                                ),
                                // const SizedBox(height: 10),
                                Text(
                                  'Date: ${format.format(item.date)}',
                                  style: TextStyle(
                                    color: received ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Column(
                              children: <Widget>[
                                const Text('BTC'),
                                Text(
                                  '${item.amount / 100000000}',
                                  style: TextStyle(
                                    color: received ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
              }
            } else {
              return const ShowLoading();
            }
          },
        ));
  }
}
