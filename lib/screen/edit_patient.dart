import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/patient.dart';

class EditPatientScreen extends StatefulWidget {
  final Patient patient;

  const EditPatientScreen({required this.patient, Key? key}) : super(key: key);

  @override
  EditPatientScreenState createState() => EditPatientScreenState();
}

class EditPatientScreenState extends State<EditPatientScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;
  late TextEditingController _phonenumberController;
  late TextEditingController _sexController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.patient.name);
    _ageController = TextEditingController(text: widget.patient.age.toString());
    _addressController = TextEditingController(text: widget.patient.address);
    _phonenumberController = TextEditingController(text: widget.patient.phoneNumber);
    _sexController = TextEditingController(text: widget.patient.sex);
  }

  Future<void> _updatePatient() async {
    setState(() {
      _isLoading = true;
    });

    Patient updatedPatient = Patient(
      idPatient: widget.patient.idPatient,
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      address: _addressController.text,
      phoneNumber: _phonenumberController.text,
      sex: _sexController.text,
    );

    bool success = await ApiService().updatePatient(updatedPatient);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true); // Return true to indicate success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thông tin thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa bệnh nhân ${widget.patient.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Tên bệnh nhân"),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Tuổi"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Địa chỉ"),
            ),
            TextField(
              controller: _phonenumberController,
              decoration: const InputDecoration(labelText: "Số điện thoại"),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _sexController,
              decoration: const InputDecoration(labelText: "Giới tính (FEMALE hoặc MALE)"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _updatePatient,
                    child: const Text("Lưu thay đổi"),
                  ),
          ],
        ),
      ),
    );
  }
}