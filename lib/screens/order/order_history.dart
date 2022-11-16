import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
