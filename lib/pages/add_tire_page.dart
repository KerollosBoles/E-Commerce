import 'package:e_commerce/data/database_helper.dart';
import 'package:flutter/material.dart';

class AddTirePage extends StatefulWidget {
  final VoidCallback onTireAdded;
  final bool isOwner;

  const AddTirePage({
    super.key,
    required this.onTireAdded,
    required this.isOwner,
  });

  @override
  State<AddTirePage> createState() => _AddTirePageState();
}

class _AddTirePageState extends State<AddTirePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _typeController = TextEditingController();
  final _supplierController = TextEditingController();
  final _quantityController = TextEditingController();
  DateTime? _purchaseDate;

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _typeController.dispose();
    _supplierController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOwner) {
      return const Center(
        child: Text('هذه الصفحة متاحة للمالك فقط'),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'إضافة صنف كاوتش جديد',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _nameController,
                label: 'اسم الكاوتش',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _brandController,
                label: 'الماركة',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _typeController,
                label: 'النوع',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _supplierController,
                label: 'اسم المورد',
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _quantityController,
                label: 'الكمية المضافة',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _purchaseDate == null
                      ? 'اختر تاريخ الشراء'
                      : 'تاريخ الشراء: ${DatabaseHelper.instance.formatDate(_purchaseDate!)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDate,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveTire,
                icon: const Icon(Icons.save),
                label: const Text('حفظ الصنف'),
              )
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

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
      initialDate: now,
      locale: const Locale('ar'),
    );
    if (picked != null) {
      setState(() {
        _purchaseDate = picked;
      });
    }
  }

  Future<void> _saveTire() async {
    if (!_formKey.currentState!.validate() || _purchaseDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى استكمال البيانات وتحديد التاريخ')),
      );
      return;
    }

    final quantity = int.tryParse(_quantityController.text.trim());
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الكمية يجب أن تكون رقماً صحيحاً أكبر من صفر')),
      );
      return;
    }

    final helper = DatabaseHelper.instance;
    await helper.addTire({
      'tire_name': _nameController.text.trim(),
      'brand': _brandController.text.trim(),
      'tire_type': _typeController.text.trim(),
      'supplier': _supplierController.text.trim(),
      'quantity': quantity,
      'purchase_date': helper.formatDate(_purchaseDate!),
    });

    widget.onTireAdded();
    _formKey.currentState!.reset();
    setState(() {
      _purchaseDate = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حفظ الصنف بنجاح')),
    );
  }
}
