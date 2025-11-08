import 'package:e_commerce/data/database_helper.dart';
import 'package:flutter/material.dart';

class SalesInvoicePage extends StatefulWidget {
  final VoidCallback onSaleCompleted;

  const SalesInvoicePage({super.key, required this.onSaleCompleted});

  @override
  State<SalesInvoicePage> createState() => _SalesInvoicePageState();
}

class _SalesInvoicePageState extends State<SalesInvoicePage> {
  final _formKey = GlobalKey<FormState>();
  final _buyerController = TextEditingController();
  final _sellerController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  int? _selectedTireId;
  Map<String, dynamic>? _selectedTire;
  List<Map<String, dynamic>> _tires = [];
  Map<String, dynamic>? _lastInvoice;

  @override
  void initState() {
    super.initState();
    _loadTires();
  }

  @override
  void dispose() {
    _buyerController.dispose();
    _sellerController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _loadTires() async {
    final tires = await DatabaseHelper.instance.getTires();
    setState(() {
      _tires = tires;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إنشاء فاتورة بيع',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              if (_tires.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: const Text(
                    'لا يوجد أصناف متاحة حالياً، يرجى إضافة صنف إلى المخزن أولاً.',
                  ),
                )
              else
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DropdownButtonFormField<int>(
                        value: _selectedTireId,
                        items: _tires
                            .map(
                              (tire) => DropdownMenuItem<int>(
                                value: tire['id'] as int,
                                child: Text(
                                    '${tire['tire_name']} - ${tire['brand']} (متاح: ${tire['quantity']})'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedTireId = value;
                            _selectedTire = _tires
                                .firstWhere((element) => element['id'] == value);
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'اختر الكاوتش',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار الكاوتش';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _buyerController,
                        label: 'اسم المشتري',
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _sellerController,
                        label: 'اسم البائع',
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _quantityController,
                        label: 'الكمية المباعة',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _priceController,
                        label: 'السعر الإجمالي',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _submitSale,
                        icon: const Icon(Icons.receipt),
                        label: const Text('حفظ الفاتورة'),
                      ),
                    ],
                  ),
                ),
              if (_lastInvoice != null) ...[
                const SizedBox(height: 24),
                _buildInvoiceCard(),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'من فضلك أدخل $label';
        }
        return null;
      },
      decoration: InputDecoration(labelText: label),
    );
  }

  Future<void> _submitSale() async {
    if (!_formKey.currentState!.validate()) return;

    final quantityRequested = int.tryParse(_quantityController.text.trim()) ?? 0;
    if (_selectedTire == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار الكاوتش')), 
      );
      return;
    }

    final available = _selectedTire!['quantity'] as int;
    if (quantityRequested <= 0 || quantityRequested > available) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('الكمية المتاحة ${available.toString()} فقط'),
        ),
      );
      return;
    }

    final helper = DatabaseHelper.instance;
    final saleDate = helper.formatDate(DateTime.now());
    await helper.updateTireQuantity(
        _selectedTireId!, available - quantityRequested);
    final saleId = await helper.addSale({
      'tire_id': _selectedTireId!,
      'buyer_name': _buyerController.text.trim(),
      'seller_name': _sellerController.text.trim(),
      'quantity': quantityRequested,
      'price': double.tryParse(_priceController.text.trim()) ?? 0,
      'sale_date': saleDate,
    });

    setState(() {
      _lastInvoice = {
        'id': saleId,
        'tire_name': _selectedTire!['tire_name'],
        'brand': _selectedTire!['brand'],
        'quantity': quantityRequested,
        'buyer_name': _buyerController.text.trim(),
        'seller_name': _sellerController.text.trim(),
        'sale_date': saleDate,
        'price': _priceController.text.trim(),
      };
      _selectedTireId = null;
      _selectedTire = null;
      _buyerController.clear();
      _sellerController.clear();
      _quantityController.clear();
      _priceController.clear();
    });

    await _loadTires();
    widget.onSaleCompleted();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم إنشاء الفاتورة وتحديث المخزون')), 
      );
    }
  }

  Widget _buildInvoiceCard() {
    final invoice = _lastInvoice!;
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'فاتورة بيع رقم ${invoice['id']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم تجهيز الفاتورة للطباعة على ورق A4'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.print),
                  tooltip: 'طباعة A4',
                )
              ],
            ),
            const Divider(),
            Text('اسم الكاوتش: ${invoice['tire_name']}'),
            Text('الماركة: ${invoice['brand']}'),
            Text('الكمية: ${invoice['quantity']}'),
            Text('اسم المشتري: ${invoice['buyer_name']}'),
            Text('اسم البائع: ${invoice['seller_name']}'),
            Text('تاريخ البيع: ${invoice['sale_date']}'),
            Text('السعر: ${invoice['price']}'),
          ],
        ),
      ),
    );
  }
}
