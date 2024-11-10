import 'package:flutter/material.dart';
import '../models/medicalrecord_medicine.dart';
import '../services/api_service.dart';

class AddMedicalRecordMedicineScreen extends StatefulWidget {
  const AddMedicalRecordMedicineScreen({Key? key}) : super(key: key);

  @override
  AddMedicalRecordMedicineScreenState createState() => AddMedicalRecordMedicineScreenState();
}

class AddMedicalRecordMedicineScreenState extends State<AddMedicalRecordMedicineScreen> {
  List<int> _medicalRecordIds = [];
  List<int> _medicineIds = [];
  int? _selectedMedicalRecordId;
  int? _selectedMedicineId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadIds();
  }

  Future<void> _loadIds() async {
    try {
      List<int> medicalRecordIds = await ApiService().getMedicalRecordIds();
      List<int> medicineIds = await ApiService().getMedicineIds();

      if (mounted) {
        setState(() {
          _medicalRecordIds = medicalRecordIds;
          _medicineIds = medicineIds;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải dữ liệu ID: $e')),
      );
      print('Lỗi khi tải dữ liệu ID: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_selectedMedicalRecordId == null || _selectedMedicineId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    MedicalRecordMedicine newRecord = MedicalRecordMedicine(
      id: 0,
      idMedicalRecord: _selectedMedicalRecordId!,
      idMedicine: _selectedMedicineId!,
    );

    try {
      bool success = await ApiService().addMedicalRecordMedicine(newRecord);
      setState(() {
        _isLoading = false;
      });
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm đơn thuốc thành công')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm đơn thuốc thất bại')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi xảy ra: $e')),
      );
      print('Lỗi xảy ra: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm đơn thuốc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: "Chọn ID Bệnh án"),
              value: _selectedMedicalRecordId,
              items: _medicalRecordIds.map((id) {
                return DropdownMenuItem(
                  value: id,
                  child: Text(id.toString()),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedMedicalRecordId = newValue;
                });
              },
            ),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: "Chọn ID Thuốc"),
              value: _selectedMedicineId,
              items: _medicineIds.map((id) {
                return DropdownMenuItem(
                  value: id,
                  child: Text(id.toString()),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedMedicineId = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Thêm đơn thuốc'),
                  ),
          ],
        ),
      ),
    );
  }
}
