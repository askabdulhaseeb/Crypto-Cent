import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';

class SendBitcoinScreen extends StatefulWidget {
  const SendBitcoinScreen({Key? key}) : super(key: key);

  @override
  State<SendBitcoinScreen> createState() => _SendBitcoinScreenState();
}

class _SendBitcoinScreenState extends State<SendBitcoinScreen> {
  final TextEditingController _walletaddress = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  btcSend() async {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    String temp = _amount.text;
    double amount = double.parse(temp);
    Encryption encryption = Encryption();
    String address=encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].address);
    String walletAddress=encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
    String transferKey=encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].transferKey);
    final double balance = await WallletWithApi()
        .getWalletBalance(address);
    if (balance > amount) {
      await WallletWithApi().transferCoin(
          walletAddress,
          transferKey,
          _walletaddress.text,
          amount.toString());
    } else {
      CustomToast.errorToast(message: 'You havenot enough Balance ');
    }
  }

  @override
  Widget build(BuildContext context) {
    WalletProvider walletPro = Provider.of<WalletProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Send Btc')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Enter BTC Address :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: _walletaddress,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'BTC Address',
                      labelText: 'BTC Address',
                      prefixIcon: Icon(Icons.wallet)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Amount :',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(40)),
                child: TextFormField(
                  controller: _amount,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Amount',
                      labelText: 'Amount',
                      prefixIcon: Icon(Icons.monetization_on_outlined)),
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Available Balance : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  FutureBuilder<double>(
                      future: WallletWithApi().getWalletBalance(
                          walletPro.wallet!.coinsWallet[0].address),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          double balance = snapshot.data!;
                          return Text(
                            '\$${balance.toStringAsFixed(4)}',
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
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        btcSend();
                      },
                      child: const Text('Send')))
            ],
          ),
        ),
      ),
    );
  }
}
