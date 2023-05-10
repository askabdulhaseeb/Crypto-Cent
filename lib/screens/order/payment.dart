// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';

// import '../../function/crypto_function.dart';
// import '../../function/encryption_function.dart';
// import '../../models/app_user/app_user.dart';
// import '../../models/my_device_token.dart';
// import '../../providers/provider.dart';
// import '../../widgets/custom_widgets/custom_toast.dart';
// import '../../widgets/custom_widgets/custom_widget.dart';
// import '../../widgets/custom_widgets/show_loading.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});
//   static String routeName = '/payment';

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   Encryption encryption = Encryption();
//   bool paid = false;
//   Future<bool> btcSend(
//     double totalAmount,
//   ) async {
//   WalletProvider walletPro =
//       Provider.of<WalletProvider>(context, listen: false);
//   double amount = totalAmount;
//   String address =
//       encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].address);
//   String walletAddress =
//       encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
//   String transferKey =
//       encryption.appDecrypt(walletPro.wallet!.coinsWallet[0].transferKey);
//   final double balance = await WallletWithApi().getWalletBalance(address);
//   String adminWalletAddress = '3Fv1QCCbmUfNf8R8y7Ujp1tg9VHnEWMm27';
//   if (balance > amount) {
//     await WallletWithApi().transferCoin(
//         walletAddress, transferKey, adminWalletAddress, amount.toString());
//     paid = true;
//   } else {
//     CustomToast.errorToast(message: 'You havenot enough Balance ');
//   }
//     return paid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     UserProvider userPro = Provider.of<UserProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//         leading: IconButton(
//           onPressed: (() {
//             Provider.of<AppProvider>(context, listen: false).onTabTapped(2);
//             Navigator.pop(context);
//           }),
//           icon: const Icon(Icons.arrow_back_ios_sharp),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Consumer2<CartProvider, WalletProvider>(builder: (
//           BuildContext context,
//           CartProvider cartPro,
//           WalletProvider walletPro,
//           _,
//         ) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const ForText(
//                 name: 'Payment System',
//                 bold: true,
//               ),
//               const SizedBox(height: 16),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(26),
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       const ForText(
//                         name: 'Your Balance',
//                         color: Colors.white,
//                         bold: true,
//                         size: 28,
//                       ),
//                       const SizedBox(height: 10),
//                       FutureBuilder<double>(
//                           future: walletPro.currentBalance(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<double> snapshot) {
//                             return snapshot.hasError
//                                 ? Text(snapshot.error.toString())
//                                 : snapshot.hasData
//                                     ? Text(
//                                         snapshot.data.toString(),
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16,
//                                         ),
//                                       )
//                                     : const ShowLoading();
//                           }),
//                       const SizedBox(height: 5),
//                       const SizedBox(height: 20),
//                       Container(
//                         height: 40,
//                         width: 120,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16)),
//                         child: const Center(child: ForText(name: 'Bitcoin')),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               FutureBuilder<double>(
//                   future: CryptoFunction()
//                       .btcPrinceLive(dollor: cartPro.totalPrice()),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<double> exchangeRate) {
//                     return ForText(
//                       name: exchangeRate.hasError
//                           ? '-- ERROR --'
//                           : exchangeRate.hasData
//                               ? 'Total Payable Btc: ${exchangeRate.data ?? 0}'
//                               : 'fetching ...',
//                       bold: true,
//                       size: 16,
//                     );
//                   }),
//               const Spacer(),
//               CustomElevatedButton(
//                 title: 'Pay',
//                 onTap: () async {
//                   await HapticFeedback.heavyImpact();
//                   WalletProvider walletPro =
//                       Provider.of<WalletProvider>(context, listen: false);
//                   double amount = await CryptoFunction()
//                       .btcPrinceLive(dollor: cartPro.totalPrice());
//                   String address = encryption
//                       .appDecrypt(walletPro.wallet!.coinsWallet[0].address);
//                   String walletAddress = encryption
//                       .appDecrypt(walletPro.wallet!.coinsWallet[0].wallet);
//                   String transferKey = encryption.appDecrypt(
//                       walletPro.wallet!.coinsWallet[0].transferKey);
//                   final double balance =
//                       await WallletWithApi().getWalletBalance(address);
//                   // String adminWalletAddress =
//                   //     '3Fv1QCCbmUfNf8R8y7Ujp1tg9VHnEWMm27';
//                   if (balance > amount) {
//                     await WallletWithApi().transferCoin(walletAddress,
//                         transferKey, '3Fv1QCCbmUfNf8R8y7Ujp1tg9VHnEWMm27', amount.toString());
//                     paid = true;
//                      AppUser me = userPro.user(cartPro.cartItem[0].sellerID);
//                   List<MyDeviceToken> deviceToken = me.deviceToken ?? [];
//                   final bool done =
//                       await Provider.of<PaymentProvider>(context, listen: false)
//                           .productOrder(context, cartPro.cartItem, deviceToken);
//                   if (done) {
//                     if (!mounted) return;
//                     cartPro.deleteAllItem();
//                     Navigator.of(context).pop();
//                   }
//                   } else {
//                     CustomToast.errorToast(
//                         message: 'You havenot enough Balance ');
//                   }
                 
//                 },
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }
