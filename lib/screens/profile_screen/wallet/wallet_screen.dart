import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../providers/crypto_wallet/binance_provider.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/cutom_text.dart';
import 'history_bitcoin.dart';
import 'recieve_bitcoin.dart';
import 'send_bitcoin.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
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
                      FutureBuilder<double>(
                          future: WallletWithApi().getWalletBalance(walletID),
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            if (snapshot.hasData) {
                              print(coinprice.coin.price);
                              print(walletID);
                              double balance =
                                  (snapshot.data ?? 0) * coinprice.coin.price;
                              return Text(
                                '\$ ${balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return snapshot.hasError
                                  ? const Text('ERROR')
                                  : const CircularProgressIndicator.adaptive();
                            }
                          }),
                      FutureBuilder<double>(
                          future: WallletWithApi().getWalletBalance(walletID),
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            if (snapshot.hasData) {
                              double balance = snapshot.data ?? 0;
                              return Text(
                                'BTC $balance',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return snapshot.hasError
                                  ? const Text('ERROR')
                                  : const CircularProgressIndicator.adaptive();
                            }
                          }),
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
                children: [
                  customWidget(
                    context,
                    'Add Money',
                    Icons.add,
                    () {
                      Navigator.push(
                        context,
                        // ignore: always_specify_types
                        MaterialPageRoute(
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
                        // ignore: always_specify_types
                        MaterialPageRoute(
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
                        // ignore: always_specify_types
                        MaterialPageRoute(
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
              const Center(child: Text('No history found to display')),
            ],
          ),
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
