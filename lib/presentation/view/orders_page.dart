import 'package:ahwa_app/presentation/riverpod/order_manager.dart'
    show orderManagerProvider;
import 'package:ahwa_app/presentation/riverpod/report_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> drinks = ['Tea', 'Coffee'];

class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  final nameController = TextEditingController();
  final instructionsController = TextEditingController();
  String? selectedDrink;

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderManagerProvider);
    final orderManager = ref.read(orderManagerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Ahwa Manager'),
        centerTitle: true,
        leading: const Icon(Icons.coffee),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Customer Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: selectedDrink,
                      items: drinks.map((drink) {
                        return DropdownMenuItem(
                          value: drink,
                          child: Text(drink),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        labelText: 'Drink Type',
                        prefixIcon: Icon(Icons.local_drink),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDrink = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: instructionsController,
                      decoration: const InputDecoration(
                        labelText: 'Special Instructions',
                        prefixIcon: Icon(Icons.note_alt),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: const Text(
                        'Add Order',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            selectedDrink != null) {
                          orderManager.addOrder(
                            nameController.text,
                            selectedDrink!,
                            instructionsController.text,
                          );
                          nameController.clear();
                          instructionsController.clear();
                          setState(() => selectedDrink = null);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(
                        Icons.local_cafe,
                        color: Colors.brown,
                      ),
                      title: Text('${order.customerName} - ${order.drinkType}'),
                      subtitle: Text(
                        order.specialInstructions.isEmpty
                            ? 'No instructions'
                            : order.specialInstructions,
                      ),
                      trailing: order.isCompleted
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : IconButton(
                              icon: const Icon(Icons.done),
                              onPressed: () =>
                                  orderManager.completeOrder(index),
                            ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.bar_chart, color: Colors.white),
              label: const Text(
                'Generate Report',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                final report = ref.read(reportProvider(orders));
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Daily Report'),
                    content: Text(report),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
