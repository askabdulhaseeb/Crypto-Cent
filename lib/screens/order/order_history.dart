// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../widgets/custom_widgets/bar_chart/custom_bar_chart.dart';
// import '../../widgets/custom_widgets/custom_widget.dart';
// import '../../widgets/order/order_history_tile.dart';

// class OrderHistory extends StatefulWidget {
//   const OrderHistory({super.key});
//   @override
//   State<OrderHistory> createState() => _OrderHistoryState();
// }

// class _OrderHistoryState extends State<OrderHistory> {
//   @override
//   Widget build(BuildContext context) {
   
//     int running = 0;
//     int prevoius = 0;
//     int total = 0;
//     total = paymentPro.totalCount.toInt();
//     running = (paymentPro.proccesing + paymentPro.deleviry + paymentPro.shipped)
//         .toInt();
//     prevoius = (paymentPro.completed + paymentPro.cancel).toInt();
//     return paymentPro.order.isEmpty
//         ? Scaffold(
//             appBar: AppBar(title: const Text('My order History')),
//             body: const Center(child: Text('You do not have any order')),
//           )
//         : Scaffold(
//             appBar: AppBar(title: const Text('My order History')),
//             body: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         newMethod(context, 'All', () {
//                           paymentPro.changeName('All');
//                         }, paymentPro.tempname, total),
//                         newMethod(context, 'Running', () {
//                           paymentPro.changeName('Running');
//                         }, paymentPro.tempname, running),
//                         newMethod(context, 'Previous', () {
//                           paymentPro.changeName('Previous');
//                         }, paymentPro.tempname, prevoius),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     const CustomBarChart(),
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: paymentPro.order.length,
//                         itemBuilder: (BuildContext context, int index) =>
//                             OrderHistoryTile(order: paymentPro.order[index]),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//   }

//   Widget newMethod(BuildContext context, String title, VoidCallback onTap,
//       String name, int num) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//           decoration: BoxDecoration(
//             color: title == name
//                 ? Theme.of(context).primaryColor
//                 : Theme.of(context).secondaryHeaderColor,
//             borderRadius: BorderRadius.circular(46),
//           ),
//           child: Center(
//             child: ForText(
//               name: '$title ($num)',
//               color: title == name ? Colors.white : Colors.black,
//               size: 14,
//               bold: true,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
