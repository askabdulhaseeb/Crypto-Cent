// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Item {
  final String name;
  final double price;
   
  Item({required this.name, required this.price});

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price};
  }
}

class CoinbaseeCommerce {
  static const _baseUrl = 'https://api.commerce.coinbase.com/charges';

  static Future<String?> generatePaymentLink(List<Item> items) async {
    final headers = {
      'Content-Type': 'application/json',
      'X-CC-Api-Key': 'a26a49a1-e777-4e7e-8b65-33f85bbfc4db',
      'X-CC-Version': '2018-03-22',
    };

    final payload = {
      'name': 'Vintage Clock',
      'description': ' Payment for items',
      'local_price': {
        'amount': items.map((e) => e.price).reduce((a, double b) => a + b).toStringAsFixed(2),
        'currency': 'USDT',
      },
      'pricing_type': 'fixed_price',
      'metadata': {'items': jsonEncode(items.map((Item e) => e.toJson()).toList())},
    };

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: headers,
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data']['hosted_url'];
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
