import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';

class RecieveBitcoinScreen extends StatelessWidget {
  const RecieveBitcoinScreen({super.key});
  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              QrImage(
                data: walletPro.wallet!.coinsWallet.address,
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
                walletPro.wallet!.coinsWallet.address,
                //walletPro.walletadd,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              TextButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(
                    text: walletPro.wallet!.coinsWallet.address,
                  ));
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy Address'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Your Balance : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  FutureBuilder<double>(
                      future: WallletWithApi().getWalletBalance(
                        walletPro.wallet!.coinsWallet.wallet,
                      ),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.hasData) {
                          double balance = snapshot.data!;
                          return Text(
                            '\$${balance.toStringAsFixed(3)}',
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
          ),
        ),
      ),
    );
  }
}
