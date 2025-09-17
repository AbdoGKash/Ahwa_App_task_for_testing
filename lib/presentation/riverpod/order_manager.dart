import 'package:flutter_riverpod/legacy.dart';
import '../../../domain/entities/order.dart';

class OrderManager extends StateNotifier<List<Order>> {
  OrderManager() : super([]);

  void addOrder(String name, String drink, String instructions) {
    state = [
      ...state,
      Order(
        customerName: name,
        drinkType: drink,
        specialInstructions: instructions,
      ),
    ];
  }

  void completeOrder(int index) {
    final updatedOrders = [...state];
    updatedOrders[index].completeOrder();
    state = updatedOrders;
  }
}

final orderManagerProvider = StateNotifierProvider<OrderManager, List<Order>>((
  ref,
) {
  return OrderManager();
});
