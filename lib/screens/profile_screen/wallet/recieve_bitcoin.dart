import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../providers/crypto_wallet/binance_provider.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class ReceiveBTCScreen extends StatefulWidget {
  const ReceiveBTCScreen({Key? key}) : super(key: key);

  @override
  State<ReceiveBTCScreen> createState() => _ReceiveBTCScreenState();
}

class _ReceiveBTCScreenState extends State<ReceiveBTCScreen> {
  @override
  void initState() {
    super.initState();
  }

  double balance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recieve Bitcoin'),
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        // ignore: always_specify_types
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer2<WalletProvider, BinanceProvider>(builder: (
            BuildContext context,
            WalletProvider walletPro,
            BinanceProvider coinprice,
            _,
          ) {
            String address = walletPro.wallet == null
                ? 'loading...'
                : Encryption()
                    .appDecrypt(walletPro.wallet!.coinsWallet[0].address);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 16),
                walletPro.wallet == null
                    ? const ShowLoading()
                    : QrImage(
                        data: address,
                        version: QrVersions.auto,
                        size: 120.0,
                      ),
                const SizedBox(height: 16),
                const Text(
                  'Your BTC Address :',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Text(
                  address,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: address));
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy Address'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    const Text(
                      'Your Balance : ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    FutureBuilder<double>(
                        future: WallletWithApi().getWalletBalance(address),
                        builder: (BuildContext context,
                            AsyncSnapshot<double> snapshot) {
                          if (snapshot.hasData) {
                            double balance =
                                (snapshot.data ?? 0) * coinprice.coin.price;
                            return Text(
                              '\$ ${balance.toStringAsFixed(3)}',
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
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
