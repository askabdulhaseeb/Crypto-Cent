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
    String address =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].address);
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ForText(
                        name: 'Your Balance',
                        color: Colors.white,
                        bold: true,
                        size: 28,
                      ),
                      FutureBuilder<double>(
                          future: WallletWithApi().getWalletBalance(address),
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            if (snapshot.hasData) {
                              double balance =
                                  snapshot.data! * coinprice.coin.price;
                              return Text(
                                '\$ ${balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
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
                          future: WallletWithApi().getWalletBalance(address),
                          builder: (BuildContext context,
                              AsyncSnapshot<double> snapshot) {
                            if (snapshot.hasData) {
                              double balance = snapshot.data!;
                              return Text(
                                'BTC ${balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
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
                  customWidget(context, 'Add Money', Icons.add, () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ReceiveBTCScreen(),
                      ),
                    );
                  }),
                  customWidget(context, 'History', Icons.arrow_drop_down_sharp,
                      () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const BitcoinHistroyScreen(),
                      ),
                    );
                  }),
                  customWidget(
                      context, 'Send Money', Icons.arrow_drop_down_sharp, () {
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SendBitcoinScreen(),
                      ),
                    );
                  }),
                ],
              )
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
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black,
                size: 26,
              ),
              ForText(
                name: name,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
