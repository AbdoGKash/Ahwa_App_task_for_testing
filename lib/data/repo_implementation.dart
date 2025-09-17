import '../../domain/entities/order.dart';
import '../../domain/repositories/i_report_generator.dart';

class DailyReportGenerator implements IReportGenerator {
  @override
  String generateReport(List<Order> orders) {
    final totalOrders = orders.length;
    final drinksCount = <String, int>{};

    for (var order in orders) {
      drinksCount[order.drinkType] = (drinksCount[order.drinkType] ?? 0) + 1;
    }

    final topDrink = drinksCount.entries.isNotEmpty
        ? drinksCount.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : 'No orders yet';

    return 'Total Orders: $totalOrders\nTop Drink: $topDrink';
  }
}
