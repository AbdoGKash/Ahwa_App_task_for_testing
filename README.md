# 🚀 Welcome to the Ahwa App(task for testing) repository!

The Smart Ahwa Manager is a Flutter application designed to help a coffee shop owner in Cairo efficiently manage operations. The app allows adding new customer orders with name, drink type, and special instructions; marking orders as completed; displaying a dashboard of pending orders; and generating a daily report of top-selling drinks and total orders served.

# Dependencies

* flutter_riverpod for state management

* Flutter core libraries (material)

  
# 🔧 OOP Principles Applied : 

**Encapsulation**

* We grouped related data into a single class, and made _isCompleted private, controlling access to it through a getter and a setter method.


```dart
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
```

**Inheritance & Polymorphism & Abstraction**
  
* IReportGenerator is the abstraction. DailyReportGenerator is one implementation. Any other generator (e.g., WeeklyReportGenerator) can replace it without changing client code.


```dart
abstract class IReportGenerator {
  String generateReport(List<Order> orders);
}
```

```dart
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
```
```dart
// This demonstrates the Polymorphism principle since we can replace
// DailyReportGenerator with any other implementation (e.g., WeeklyReportGenerator)
// without affecting the rest of the code.
final reportGeneratorProvider = Provider<IReportGenerator>((ref) {
  return DailyReportGenerator();   
});

final reportProvider = Provider.family<String, List<Order>>((ref, orders) {
  final reportGenerator = ref.read(reportGeneratorProvider);
  return reportGenerator.generateReport(orders);
});
```


# SOLID Principles Applied

**Single Responsibility Principle (SRP)**

* Each class has one responsibility:

* Order → represents order data.

* OrderManager → manages adding/completing orders.

* DailyReportGenerator → generates reports.



**Open/Closed Principle (OCP)**

* System is open to extension but closed to modification:

* Add WeeklyReportGenerator without changing existing code.



**Liskov Substitution Principle (LSP)**

* Any class implementing IReportGenerator can replace another without breaking behavior.



**Interface Segregation Principle (ISP)**

* IReportGenerator is small and focused, avoiding unnecessary methods.



**Dependency Inversion Principle (DIP)**

* High-level modules depend on abstractions, not implementations:
* The app depends on IReportGenerator (abstraction), not directly on DailyReportGenerator.

```dart
final reportGeneratorProvider = Provider<IReportGenerator>((ref) {
  return DailyReportGenerator();   
});
```


# 🎨 UI 

<img src="https://github.com/user-attachments/assets/9e9ddd47-9c97-437b-8c09-110b7dd7f16a" width="200">
<img src="https://github.com/user-attachments/assets/63222b20-24de-44ef-8bd7-258b39a8f723" width="200">
<img src="https://github.com/user-attachments/assets/feeca8f9-a836-4116-a458-91b0a098d753" width="200">
<img src="https://github.com/user-attachments/assets/23d98d8d-38a1-41b6-9e63-5d3903c50a4b" width="200">

