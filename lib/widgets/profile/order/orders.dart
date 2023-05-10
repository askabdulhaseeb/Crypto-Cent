// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../providers/provider.dart';
// import 'buy_order.dart';
// import 'sell_order.dart';

// class OrderTabbar extends StatefulWidget {
//   const OrderTabbar({Key? key}) : super(key: key);

//   @override
//   State<OrderTabbar> createState() => _OrderTabbarState();
// }

// class _OrderTabbarState extends State<OrderTabbar> {
//   @override
//   void initState() {
//     Provider.of<PaymentProvider>(context, listen: false).load();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: const Text(
//             'MyOrder Complete Transaction',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           bottom: const TabBar(tabs: <Widget>[
//             Text(
//               'Buy',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             Text(
//               'Sell',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ]),
//         ),
//         body: const TabBarView(
//           children: <Widget>[
//             BuyOrder(),
//             SellOrder(),
//           ],
//         ),
//       ),
//     );
//   }
// }
