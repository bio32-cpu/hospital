import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/api_service.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  AddMedicineScreenState createState() => AddMedicineScreenState();
}

class AddMedicineScreenState extends State<AddMedicineScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addMedicine() async {
  setState(() {
    _isLoading = true;
  });

  String name = _nameController.text.trim();
  String expirationDate = _expirationDateController.text.trim();
  int price = int.tryParse(_priceController.text.trim()) ?? 0;
  int quantity = int.tryParse(_quantityController.text.trim()) ?? 0;

  // Validate input fields
  if (name.isEmpty || price <= 0 || quantity <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vui lòng nhập đầy đủ và chính xác thông tin')),
    );
    setState(() {
      _isLoading = false;
    });
    return;
  }

  // Create Medicine object
  Medicine newMedicine = Medicine(
    idmedicine: 0, // ID is auto-generated on the server
    name: name,
    expirationdate: expirationDate,
    price: price,
    quantity: quantity,
  );

  final response = await ApiService().addMedicine(newMedicine);

  setState(() {
    _isLoading = false;
  });

  if (!mounted) return;

  if (response['success'] == true) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thêm thuốc thành công')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lỗi: ${response['message'] ?? 'Thêm thuốc thất bại. Kiểm tra lại dữ liệu.'}')),
    );
  }
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm thuốc"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Tên thuốc"),
            ),
            TextField(
              controller: _expirationDateController,
              decoration: const InputDecoration(labelText: "Hạn sử dụng (YYYY-MM-DD)"),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Giá"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Số lượng"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _addMedicine,
                    child: const Text("Thêm thuốc"),
                  ),
          ],
        ),
      ),
    );
  }
}
