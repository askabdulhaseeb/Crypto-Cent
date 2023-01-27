import 'package:flutter/animation.dart';
import 'package:flutter_html/flutter_html.dart';

import '../utilities/app_images.dart';

enum NotificationType {
  message(
    '',
    'Message',
    'message',
    'message',
  ),
  discountOffer(
    'assets/icons/discount.png',
    'Discount Offer',
    'Click here to check all the available discounts for you',
    'discount_offer',
  ),
  confirmOrder(
    'assets/icons/deliveryCart.png',
    'Confirm MyOrder',
    'Click to check all your confirm orders here',
    'confirm_order',
  ),
  deliverySuccess(
    'assets/icons/delivery.png',
    'Delivery Success',
    'Succefully Confirm all the Delivery',
    'delivery_success',
  ),
  cancelOrder(
    'assets/icons/shoppingCart.png',
    'Cancel MyOrder',
    'Click to check all your cancel orders here',
    'cancel_order',
  ),
  payment(
    'assets/icons/wallet.png',
    'Payment',
    'Click to check all your Payment here',
    'payment',
  ),
  ;

  const NotificationType(
    this.icon,
    this.title,
    this.subtitle,
    this.json,
  );
  final String icon;
  final String title;
  final String subtitle;
  final String json;
}

class NotificationTypeConvertor {
  static NotificationType toEnum(String type) {
    switch (type) {
      case 'message':
        return NotificationType.message;
      case 'discount_offer':
        return NotificationType.discountOffer;
      case 'confirm_order':
        return NotificationType.confirmOrder;
      case 'delivery_success':
        return NotificationType.deliverySuccess;
      case 'cancel_order':
        return NotificationType.cancelOrder;
      case 'payment':
        return NotificationType.payment;
      default:
        return NotificationType.message;
    }
  }
}
