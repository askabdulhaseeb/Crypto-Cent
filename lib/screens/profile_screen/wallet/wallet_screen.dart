import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../models/crypto_wallet/wallet_histroty.dart';
import '../../../providers/crypto_wallet/binance_provider.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/cutom_text.dart';
import '../../../widgets/custom_widgets/show_loading.dart';
import '../../../widgets/wallet/wallet_history_tile.dart';
import 'history_bitcoin.dart';
import 'recieve_bitcoin.dart';
import 'send_bitcoin.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  static const String routeName = '/wallet-screen';
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool temp = false;
  Encryption encryption = Encryption();
  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    BinanceProvider coinprice = Provider.of<BinanceProvider>(context);

    String walletID = walletPro.wallet == null
        ? 'loading'
        : encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    const ForText(
                      name: 'Your Balance',
                      color: Colors.white,
                      bold: true,
                      size: 28,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      walletPro.balance.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(child: ForText(name: 'Bitcoin')),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                customWidget(
                  context,
                  'Add Money',
                  Icons.add,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<ReceiveBTCScreen>(
                        builder: (BuildContext context) =>
                            const ReceiveBTCScreen(),
                      ),
                    );
                  },
                ),
                customWidget(
                  context,
                  'Transfer',
                  Icons.call_missed_outgoing_outlined,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<SendBitcoinScreen>(
                        builder: (BuildContext context) =>
                            const SendBitcoinScreen(),
                      ),
                    );
                  },
                ),
                customWidget(
                  context,
                  'History',
                  Icons.history,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<BitcoinHistroyScreen>(
                        builder: (BuildContext context) =>
                            const BitcoinHistroyScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Divider(color: Colors.grey),
            ),
            Expanded(
              child: FutureBuilder<WalletHistory?>(
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
            )
          ],
        ),
      ),
    );
  }

  Widget customWidget(
      BuildContext context, String name, IconData? icon, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 24,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(icon),
          ),
          const SizedBox(height: 6),
          Text(name),
        ],
      ),
    );
  }
}
