import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database/crypto_wallet/wallet_create_api.dart';
import '../../../function/encryption_function.dart';
import '../../../models/app_user/app_user.dart';
import '../../../models/crypto_wallet/wallet.dart';
import '../../../providers/crypto_wallet/wallet_provider.dart';
import '../../../widgets/custom_widgets/custom_toast.dart';
import '../../../widgets/custom_widgets/show_loading.dart';

class SendBitcoinScreen extends StatefulWidget {
  const SendBitcoinScreen({required this.iscontact, this.sellerUser, Key? key})
      : super(key: key);
  final bool iscontact;
  final AppUser? sellerUser;
  @override
  State<SendBitcoinScreen> createState() => _SendBitcoinScreenState();
}

class _SendBitcoinScreenState extends State<SendBitcoinScreen> {
  TextEditingController _walletaddress = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  btcSend() async {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    String temp = _amount.text;
    double amount = double.parse(temp);
    Encryption encryption = Encryption();
    String address =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].address);
    String walletAddress =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
    String transferKey =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].transferKey);
    final double balance = await walletPro.currentBalance();
    if (balance > amount) {
      await WallletWithApi().transferCoin(
          walletAddress, transferKey, _walletaddress.text, amount.toString());
    } else {
      CustomToast.errorToast(message: 'You havenot enough Balance ');
    }
  }

  String sellerAddress = '';
  SellerAddress() {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    print('User Addresss ${widget.sellerUser}');
    Wallets? wallet = walletPro.getWallet(widget.sellerUser!.uid);
    String sellerAddress = walletPro.wallet == null
        ? 'loading...'
        : Encryption().userDecrypt(
            wallet!.coinsWallet[0].address, widget.sellerUser!.uid);
    print('User Addresss ${sellerAddress}');
    setState(() {
      _walletaddress = TextEditingController(text: sellerAddress);
    });
  }

  @override
  void initState() {
    if (widget.iscontact) {
      SellerAddress();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Btc'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                  readOnly: widget.iscontact ? true : false,
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
                children: <Widget>[
                  const Text(
                    'Available Balance : ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  FutureBuilder<double>(
                      future:
                          Provider.of<WalletProvider>(context).currentBalance(),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        return snapshot.hasError
                            ? Text(snapshot.error.toString())
                            : snapshot.hasData
                                ? Text(
                                    snapshot.data.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  )
                                : const ShowLoading();
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
