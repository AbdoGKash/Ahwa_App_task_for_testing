import '../entities/order.dart';

abstract class IReportGenerator {
  String generateReport(List<Order> orders);
}
