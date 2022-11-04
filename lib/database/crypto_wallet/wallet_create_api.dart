// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, always_specify_types

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../function/encryption_function.dart';
import '../../models/crypto_wallet/coin_wallet.dart';
import '../../models/crypto_wallet/wallet_histroty.dart';
import '../../widgets/custom_widgets/custom_toast.dart';

class WallletWithApi {
  static String myWalletId = '';
  static String url = 'https://apirone.com/api/v2/wallets';
  List<String> units = ['btc'];
  Encryption encrypt = Encryption();

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
  };
  Future<List<CoinsWallet>> createWallet() async {
    List<CoinsWallet> wallet = <CoinsWallet>[];

    for (String un in units) {
      Map<String, dynamic> body = <String, dynamic>{
        'type': 'saving',
        'currency': un,
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
                    address: encrypt.appEncrypt(address),
                    transferKey: encrypt.appEncrypt(transferKey),
                    wallet: encrypt.appEncrypt(walletId),
                  );
                  wallet.add(temp);
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

  Future<WalletHistory?> getWalletHistory(String walletId) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse('$url/$walletId/history?limit=20&offset=0'),
            headers: requestHeaders,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      var body = jsonDecode(response.body);
      var status = response.statusCode;
      if (status == 200) {
        return WalletHistory.fromMap(body);
      } else {
        CustomToast.errorToast(message: 'Error While fetching history');
      }
    } catch (e) {
      CustomToast.errorToast(message: 'Error While fetching history');
    }
    return null;
  }

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

  String TRANSFERKEY = 'transfer_key';
  String DESTINATIONS = 'destinations';
  String ADDRESS = 'address';
  String AMOUNT = 'amount';
  String STATUS = 'status';
  String HASH = 'hash';
  Future<Map> transferCoin(
    String walletId,
    String transferKey,
    String address,
    String amount,
  ) async {
    Map result;

    Map<String, dynamic> trxnBody = {
      TRANSFERKEY: transferKey,
      DESTINATIONS: [
        {
          ADDRESS: address,
          AMOUNT: (double.tryParse(amount)! * 100000000).toInt()
        },
      ],
    };
    try {
      http.Response response = await http
          .post(Uri.parse('$url/$walletId/transfer'),
              headers: requestHeaders, body: jsonEncode(trxnBody))
          .timeout(
            const Duration(seconds: 30),
          );

      var body = jsonDecode(response.body);
      int status = response.statusCode;
      var txs = body['txs'];

      if (status == 200) {
        result = {
          STATUS: true,
          HASH: txs,
        };

        return result;
      } else {
        result = {
          STATUS: false,
          HASH: null,
        };

        return result;
      }
    } catch (e) {
      result = {
        STATUS: false,
        HASH: null,
      };

      return result;
    }
  }
}
