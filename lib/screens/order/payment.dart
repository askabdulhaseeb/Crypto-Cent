import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/crypto_wallet/wallet_create_api.dart';
import '../../function/encryption_function.dart';
import '../../providers/app_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/crypto_wallet/binance_provider.dart';
import '../../providers/crypto_wallet/wallet_provider.dart';
import '../../widgets/custom_widgets/custom_toast.dart';
import '../../widgets/custom_widgets/custom_widget.dart';
import 'order_succefully.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static String routes = '/payment';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Encryption encryption = Encryption();
  bool paid = false;
  Future<bool> btcSend(
    double totalAmount,
  ) async {
    WalletProvider walletPro =
        Provider.of<WalletProvider>(context, listen: false);
    double amount = totalAmount;
    String address =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].address);
    String walletAddress =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
    String transferKey =
        encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].transferKey);
    final double balance = await WallletWithApi().getWalletBalance(address);
    String adminWalletAddress = '3Fv1QCCbmUfNf8R8y7Ujp1tg9VHnEWMm27';
    if (balance > amount) {
      await WallletWithApi().transferCoin(
          walletAddress, transferKey, adminWalletAddress, amount.toString());
      paid = true;
    } else {
      CustomToast.errorToast(message: 'You havenot enough Balance ');
    }
    return paid;
  }

  @override
  Widget build(BuildContext context) {
    // CartProvider cartPro = Provider.of<CartProvider>(context);
    // WalletProvider walletPro = Provider.of<WalletProvider>(context);
    // BinanceProvider coinprice = Provider.of<BinanceProvider>(context);
    // String address =
    //     encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
            onPressed: (() {
              Provider.of<AppProvider>(context, listen: false).onTabTapped(2);
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ForText(
              name: 'Payment System',
              bold: true,
            ),
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
                    const SizedBox(height: 10),
                    const ForText(
                      name: '15',
                      color: Colors.white,
                      bold: true,
                      size: 28,
                    ),
                    // FutureBuilder<double>(
                    //     future: WallletWithApi().getWalletBalance(address),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<double> snapshot) {
                    //       if (snapshot.hasData) {
                    //         double balance =
                    //             (snapshot.data ?? 0) * coinprice.coin.price;
                    //         return Text(
                    //           '\$ ${balance.toStringAsFixed(2)}',
                    //           style: const TextStyle(
                    //             fontSize: 18,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.white,
                    //           ),
                    //         );
                    //       } else {
                    //         return snapshot.hasError
                    //             ? const Text('ERROR')
                    //             : const CircularProgressIndicator.adaptive();
                    //       }
                    //     }),
                    const SizedBox(
                      height: 5,
                    ),
                    // FutureBuilder<double>(
                    //     future: WallletWithApi().getWalletBalance(address),
                    //     builder: (BuildContext context,
                    //         AsyncSnapshot<double> snapshot) {
                    //       if (snapshot.hasData) {
                    //         double balance = snapshot.data!;
                    //         return Text(
                    //           'Btc ${balance.toStringAsFixed(8)}',
                    //           style: const TextStyle(
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.white,
                    //           ),
                    //         );
                    //       } else {
                    //         return snapshot.hasError
                    //             ? const Text('ERROR')
                    //             : const CircularProgressIndicator.adaptive();
                    //       }
                    //     }),
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
            const SizedBox(height: 15),
            Row(
              children: const <Widget>[
                ForText(
                  name: 'Total',
                  bold: true,
                ),
                SizedBox(width: 20),
                ForText(
                  name: '\$ 10',
                  bold: true,
                ),
              ],
            ),
            const Spacer(),
            CustomElevatedButton(
                title: 'Pay',
                onTap: () {
                  // bool temp = btcSend(cartPro.totalPrice()) as bool;
                  // if (temp) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (BuildContext context) =>
                  //           const OrderSuccefully(),
                  //     ),
                  //   );
                  // }
                })
          ],
        ),
      ),
    );
  }
}
