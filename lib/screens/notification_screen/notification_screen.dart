import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../function/time_date_function.dart';
import '../../models/my_notification.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/custom_widgets/custom_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const String routeName = '/notification-screen';
  @override
  Widget build(BuildContext context) {
    NotificationProvider notificationPro =
        Provider.of<NotificationProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('NotificationScreen'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: ListView.builder(
        itemCount: notificationPro.notification.length,
        itemBuilder: (context, index) {
          return listViewWidget(width, notificationPro.notification[index]);
        },
      ),
    );
  }

  Widget listViewWidget(double width, MyNotification notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: width,
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.asset(notification.type.icon),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ForText(
                        name: notification.type.title,
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        notification.type.subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        TimeStamp.timeInWords(notification.timestamp),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
