import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/colors.dart';
import '../models/product.dart';
import '../providers/app_providers.dart';
import '../widgets/role_guard.dart';

class AddEditProductScreen extends ConsumerStatefulWidget {
  final Product? product;

  const AddEditProductScreen({super.key, this.product});

  @override
  ConsumerState<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends ConsumerState<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _priceController;
  late TextEditingController _costPriceController;
  late TextEditingController _quantityController;
  late TextEditingController _barcodeController;
  late TextEditingController _imageUrlController;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?.name);
    _brandController = TextEditingController(text: p?.brand);
    _modelController = TextEditingController(text: p?.model);
    _priceController = TextEditingController(text: p?.price.toString());
    _costPriceController = TextEditingController(text: p?.costPrice?.toString());
    _quantityController = TextEditingController(text: p?.quantity.toString());
    _barcodeController = TextEditingController(text: p?.barcode);
    _imageUrlController = TextEditingController(text: p?.imageUrl);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _priceController.dispose();
    _costPriceController.dispose();
    _quantityController.dispose();
    _barcodeController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: widget.product?.id, // Keep old ID if editing
        name: _nameController.text,
        brand: _brandController.text.isNotEmpty ? _brandController.text : null,
        model: _modelController.text.isNotEmpty ? _modelController.text : null,
        price: double.tryParse(_priceController.text) ?? 0.0,
        costPrice: double.tryParse(_costPriceController.text),
        quantity: int.tryParse(_quantityController.text) ?? 0,
        barcode: _barcodeController.text.isNotEmpty ? _barcodeController.text : null,
        imageUrl: _imageUrlController.text.isNotEmpty ? _imageUrlController.text : null,
      );

      ref.read(posServiceProvider).whenData((service) {
        if (_isEditing) {
          service.updateProduct(newProduct);
        } else {
          service.addProduct(newProduct);
        }
      });

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product ${_isEditing ? 'updated' : 'added'} successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit Product' : 'Add Product'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(controller: _nameController, label: 'Product Name*', icon: Icons.label_outline, validator: (v) => v!.isEmpty ? 'Name is required' : null),
                const SizedBox(height: 16),
                _buildTextField(controller: _brandController, label: 'Brand', icon: Icons.branding_watermark_outlined),
                const SizedBox(height: 16),
                _buildTextField(controller: _modelController, label: 'Model', icon: Icons.phone_android_outlined),
                const SizedBox(height: 16),
                _buildTextField(controller: _priceController, label: 'Selling Price*', icon: Icons.attach_money, keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Price is required' : null),
                const SizedBox(height: 16),
                _buildTextField(controller: _costPriceController, label: 'Cost Price', icon: Icons.money_off, keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(controller: _quantityController, label: 'Quantity*', icon: Icons.inventory_2_outlined, keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Quantity is required' : null),
                const SizedBox(height: 16),
                _buildTextField(controller: _barcodeController, label: 'Barcode (SKU)', icon: Icons.qr_code_scanner),
                const SizedBox(height: 16),
                _buildTextField(controller: _imageUrlController, label: 'Image URL', icon: Icons.image_outlined),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _saveProduct,
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text('Save Product'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}