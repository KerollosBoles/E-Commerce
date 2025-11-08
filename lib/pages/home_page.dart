import 'package:e_commerce/pages/add_tire_page.dart';
import 'package:e_commerce/pages/inventory_page.dart';
import 'package:e_commerce/pages/login_page.dart';
import 'package:e_commerce/pages/sales_invoice_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Map<String, dynamic>? user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    final role = user?['role'] as String? ?? 'staff';
    final pages = [
      AddTirePage(onTireAdded: _handleRefresh, isOwner: role == 'المالك'),
      InventoryPage(key: ValueKey('inventory-$_refreshKey')),
      SalesInvoicePage(onSaleCompleted: _handleRefresh),
    ];

    final allowedPages = role == 'المالك' ? pages : [pages[1], pages[2]];
    final allowedTitles = role == 'المالك'
        ? ['إضافة صنف جديد', 'المخزن', 'فاتورة بيع']
        : ['المخزن', 'فاتورة بيع'];

    final currentPage = role == 'المالك'
        ? pages[_selectedIndex]
        : allowedPages[_selectedIndex];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('أهلاً ${user?['name'] ?? ''}'),
        ),
        drawer: _buildDrawer(role, allowedTitles),
        body: currentPage,
      ),
    );
  }

  int _refreshKey = 0;

  void _handleRefresh() {
    setState(() {
      _refreshKey++;
    });
  }

  Widget _buildDrawer(String role, List<String> titles) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user?['name'] ?? ''),
              accountEmail: Text('${user?['email'] ?? ''} - $role'),
            ),
            if (role == 'المالك')
              ListTile(
                leading: const Icon(Icons.add_box),
                title: Text(titles[0]),
                selected: _selectedIndex == 0,
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    Navigator.pop(context);
                  });
                },
              ),
            ListTile(
              leading: const Icon(Icons.store),
              title: Text(role == 'المالك' ? titles[1] : titles[0]),
              selected: _selectedIndex == (role == 'المالك' ? 1 : 0),
              onTap: () {
                setState(() {
                  _selectedIndex = role == 'المالك' ? 1 : 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: Text(role == 'المالك' ? titles[2] : titles[1]),
              selected: _selectedIndex == (role == 'المالك' ? 2 : 1),
              onTap: () {
                setState(() {
                  _selectedIndex = role == 'المالك' ? 2 : 1;
                  Navigator.pop(context);
                });
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل الخروج'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.routeName, (route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
