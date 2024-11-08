import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../services/api_service.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  AddPatientScreenState createState() => AddPatientScreenState();
}

class AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addPatient() async {
    setState(() {
      _isLoading = true;
    });

    Patient newPatient = Patient(
      idPatient: 0, // This should be generated on the server
      name: _nameController.text,
      address: _addressController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      phoneNumber: _phoneNumberController.text,
      sex: _sexController.text,
    );

    bool success = await ApiService().addPatient(newPatient);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thêm bệnh nhân thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm bệnh nhân"),
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
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Địa chỉ"),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Tuổi"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _phoneNumberController,
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
                    onPressed: _addPatient,
                    child: const Text("Thêm bệnh nhân"),
                  ),
          ],
        ),
      ),
    );
  }
}
