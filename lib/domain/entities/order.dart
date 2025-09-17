class Order {
  final String customerName;
  final String drinkType;
  final String specialInstructions;
  bool _isCompleted;

  Order({
    required this.customerName,
    required this.drinkType,
    required this.specialInstructions,
    bool isCompleted = false,
  }) : _isCompleted = isCompleted;

  bool get isCompleted => _isCompleted;

  void completeOrder() {
    _isCompleted = true;
  }
}
