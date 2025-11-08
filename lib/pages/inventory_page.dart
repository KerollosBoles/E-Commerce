import 'package:e_commerce/data/database_helper.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late Future<List<Map<String, dynamic>>> _tiresFuture;

  @override
  void initState() {
    super.initState();
    _loadTires();
  }

  @override
  void didUpdateWidget(covariant InventoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadTires();
  }

  void _loadTires() {
    _tiresFuture = DatabaseHelper.instance.getTires();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _loadTires();
          });
          await _tiresFuture;
        },
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _tiresFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا يوجد أصناف في المخزن حالياً'));
            }

            final tires = snapshot.data!;
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final tire = tires[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(tire['quantity'].toString()),
                    ),
                    title: Text('${tire['tire_name']} - ${tire['brand']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('النوع: ${tire['tire_type']}'),
                        Text('المورد: ${tire['supplier']}'),
                        Text('تاريخ الشراء: ${tire['purchase_date']}'),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: tires.length,
            );
          },
        ),
      ),
    );
  }
}
