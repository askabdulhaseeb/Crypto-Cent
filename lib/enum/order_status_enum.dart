enum OrderStatusEnum<String> {
  offer('offer'),
  pending('pending'),
  inProgress('in_progress'),
  completed('completed'),
  cancel('cancel');

  const OrderStatusEnum(this.value);
  final String value;
}

class OrderStatusConvetion {
  OrderStatusEnum<String> stringToEnum(String value) {
    switch (value) {
      case 'offer':
        return OrderStatusEnum.offer;
      case 'pending':
        return OrderStatusEnum.pending;
      case 'in_progress':
        return OrderStatusEnum.inProgress;
      case 'completed':
        return OrderStatusEnum.completed;
      default:
        return OrderStatusEnum.cancel;
    }
  }
}
