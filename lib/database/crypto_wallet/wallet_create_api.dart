// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import'package:http/http.dart' as http;

import '../../models/crypto_wallet/coin_wallet.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class WallletWithApi {
  static String myWalletId = '';
  static String url = 'https://apirone.com/api/v2/wallets';
  List<String> units = ['btc'];

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  Future<CoinsWallet?> createWallet() async {
    CoinsWallet? wallet;

    for (String un in units) {
      Map<String, dynamic> body = <String, dynamic>{
        'type': 'saving',
        'currency': un,
        // ignore: always_specify_types
        'callback': {
          'url': 'https://yourweburl.com/notifications-wallet.php',
        }
      };
      try {
        await http
            .post(Uri.parse(url),
                headers: requestHeaders, body: jsonEncode(body))
            .then((http.Response value) async {
          if (value.statusCode == 200) {
            var body = jsonDecode(value.body);

            String walletId = body['wallet'];
            String transferKey = body['transfer_key'];

            try {
              http.Response? addressResponse = await http
                  .post(
                Uri.parse('$url/$walletId/addresses'),
                headers: requestHeaders,
              )
                  .then((http.Response value) {
                if (value.statusCode == 200) {
                  var body = jsonDecode(value.body);
                  String address = body['address'];
                  CoinsWallet temp = CoinsWallet(
                    symble: un,
                    address: address,
                    transferKey: transferKey,
                    wallet: walletId,
                  );
                  wallet = temp;
                } else {
                  CustomToast.errorToast(message: 'Error');
                }
              }).timeout(
                const Duration(seconds: 60),
              );
              return addressResponse;
            } catch (e) {
              //print(e);
            }
          }
        }).timeout(
          const Duration(seconds: 60),
        );
      } catch (e) {
        CustomToast.errorToast(message: e.toString());
      }
    }

    return wallet;
  }

  // ignore: always_specify_types
  Future<double> getWalletBalance(String walletIds) async {
    double temp = 0;
    try {
      await http
          .get(
              Uri.parse(
                '$url/$walletIds/balance',
              ),
              headers: requestHeaders)
          .then((http.Response value) {
        if (value.statusCode == 200) {
          var body = jsonDecode(value.body);
          // print('body $body');
          double total = ((body['total']) / 100000000.00);
          temp = total;
        }
      }).timeout(
        const Duration(seconds: 30),
      );
    } catch (e) {
      CustomToast.errorToast(message: e.toString());
    }
    return temp;
  }
}
