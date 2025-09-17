import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/repositories/i_report_generator.dart';
import '../../../data/repo_implementation.dart';

final reportGeneratorProvider = Provider<IReportGenerator>((ref) {
  return DailyReportGenerator();
});

final reportProvider = Provider.family<String, List<Order>>((ref, orders) {
  final reportGenerator = ref.read(reportGeneratorProvider);
  return reportGenerator.generateReport(orders);
});
