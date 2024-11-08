import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/api_service.dart';

class EditMedicineScreen extends StatefulWidget {
  final Medicine medicine;

  const EditMedicineScreen({required this.medicine, Key? key}) : super(key: key);

  @override
  EditMedicineScreenState createState() => EditMedicineScreenState();
}

class EditMedicineScreenState extends State<EditMedicineScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _expirationDateController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicine.name);
    _priceController = TextEditingController(text: widget.medicine.price.toString());
    _quantityController = TextEditingController(text: widget.medicine.quantity.toString());
    _expirationDateController = TextEditingController(text: widget.medicine.expirationdate);
  }

  Future<void> _updateMedicine() async {
    setState(() {
      _isLoading = true;
    });

    String expirationDate = _expirationDateController.text;

    Medicine updatedMedicine = Medicine(
      idmedicine: widget.medicine.idmedicine,
      name: _nameController.text,
      expirationdate: expirationDate,
      price: int.tryParse(_priceController.text) ?? 0,
      quantity: int.tryParse(_quantityController.text) ?? 0,
    );

    bool success = await ApiService().updateMedicine(updatedMedicine);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true); // Quay về màn hình trước và báo thành công
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thông tin thuốc thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa thuốc ${widget.medicine.name}"),
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
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Giá"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Số lượng"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expirationDateController,
              decoration: const InputDecoration(labelText: "Ngày hết hạn (YYYY-MM-DD)"),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _updateMedicine,
                    child: const Text("Lưu thay đổi"),
                  ),
          ],
        ),
      ),
    );
  }
}
