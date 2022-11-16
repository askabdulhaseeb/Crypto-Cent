import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 350,
                width: double.infinity,
                child: BarChart(BarChartData(
                  barGroups: [
                    generateGroupData(1, 10),
                    generateGroupData(2, 18),
                    generateGroupData(3, 4),
                    generateGroupData(4, 11),
                  ],
                )),
              ),
              SizedBox(height: 20),
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
