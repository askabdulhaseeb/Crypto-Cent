import 'package:crypto_cent/providers/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_widgets/bar_chart/custom_bar_chart.dart';
import '../../widgets/custom_widgets/bar_chart/custom_bar_line.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late int showingTooltip;

  @override
  void initState() {
    showingTooltip = -1;
    super.initState();
  }

  BarChartGroupData generateGroupData(int x, int y) {
    return BarChartGroupData(
      x: x,
      showingTooltipIndicators: showingTooltip == x ? [0] : [],
      barRods: [
        BarChartRodData(
            toY: y.toDouble(),
            color: Theme.of(context).primaryColor,
            width: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My order History'),
        leading: IconButton(
            onPressed: (() {
              Provider.of<AppProvider>(context, listen: false).onTabTapped(0);
              Navigator.pop(context);
            }),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        // ignore: always_specify_types
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(46),
                    ),
                    child: const Center(
                      child: ForText(
                        name: 'All',
                        color: Colors.white,
                        size: 24,
                        bold: true,
                      ),
                    ),
                  ),
                ],
              ),
              const CustomBarChart(),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: const Color(0xfff6f7f9),
                      height: 100,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              color: Colors.white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                ForText(
                                  name: 'Confirmed',
                                  bold: true,
                                  size: 16,
                                ),
                                ForText(
                                  name: 'OrderId:asdaddgfgg',
                                  size: 14,
                                ),
                                ForText(
                                  name: 'Item:7',
                                  size: 14,
                                ),
                              ],
                            ),
                            const ForText(
                              name: '6-9-2022',
                              bold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
