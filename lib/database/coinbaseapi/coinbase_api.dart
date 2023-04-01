
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../widgets/custom_widgets/custom_toast.dart';
class CoinBaseApi{
  String api='a26a49a1-e777-4e7e-8b65-33f85bbfc4db';
  String url='https://api.commerce.coinbase.com/checkouts';
 Future<void> checkout()async {
Map<String, String> requestHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'X-CC-Version':api
};
//var request = http.Request('POST', Uri.parse('https://api.commerce.coinbase.com/checkouts'));
Map<String, dynamic> body = <String, dynamic>{
        'name': 'Samsung Galaxy A73',
        'description': 'Samsung Galaxy A73 black color',
        'requested_info': ['usmanafzal854@gmail.com', 'usman'],
        'pricing_type': 'fixed_price',
        'local_price':{
        'amount':10,
        'currency':'usd',
        },
        
      };
      try{
         await http
            .post(Uri.parse(url),
                headers: requestHeaders, body: jsonEncode(body))
            .then((http.Response value){
              if(value.statusCode==200){

               var body = jsonDecode(value.body);
               print(body);
               print('chal giya be');
              }
              else{
                print('Status code ${value.statusCode}');
              }
            });
      }
      catch(e){
       CustomToast.errorToast(message: e.toString());
      }
// request.headers.addAll(headers);

// http.StreamedResponse response = await request.send();

// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }
  }
}