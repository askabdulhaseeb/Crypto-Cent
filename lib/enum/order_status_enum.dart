enum OrderStatusEnum {
  pending('pending'),
  inProgress('in_progress'),
  completed('completed'),
  cancel('cancel');

  const OrderStatusEnum(this.value);
  final String value;
}
