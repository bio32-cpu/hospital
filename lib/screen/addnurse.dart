import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/nurse.dart';

class AddNurseScreen extends StatefulWidget {
  const AddNurseScreen({super.key});

  @override
  AddNurseScreenState createState() => AddNurseScreenState();
}

class AddNurseScreenState extends State<AddNurseScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  String? _selectedRoom; // Biến lưu trữ lựa chọn "Phòng"
  bool _isLoading = false;

  // Các tùy chọn cho dropdown của "Phòng"
  final List<String> roomOptions = [
    'BONE_DENSITOMETRY',
    'CARDIAC_DIAGNOSTICS',
    'ECHOCARDIOGRAPHY',
    'ELECTROCARDIOGRAPHY',
    'ELECTROENCEPHALOGRAPHY',
    'ENDOSCOPY',
    'LABORATORY',
    'MEDICATION_MANAGEMENT',
    'PATIENT_CARE',
    'PULMONARY_FUNCTION_TEST',
    'RADIOLOGY_DEPARTMENT',
  ];

  Future<void> _addNurse() async {
    setState(() {
      _isLoading = true;
    });

    Nurse newNurse = Nurse(
      idPerson: '',
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      email: _emailController.text,
      phonenumber: _phonenumberController.text,
      sex: _sexController.text,
      avatar: _avatarController.text,
      degree: _degreeController.text,
      price: int.tryParse(_priceController.text) ?? 0,
      room: _selectedRoom ?? '', // Sử dụng giá trị của dropdown cho "Phòng"
      yearsexperience: int.tryParse(_experienceController.text) ?? 0,
    );

    bool success = await ApiService().addNurse(newNurse);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thêm y tá thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm y tá"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Tên y tá"),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Tuổi"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
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
            TextField(
              controller: _avatarController,
              decoration: const InputDecoration(labelText: "Avatar URL"),
            ),
            TextField(
              controller: _degreeController,
              decoration: const InputDecoration(labelText: "Bằng cấp"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Giá dịch vụ"),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              value: _selectedRoom,
              items: roomOptions.map((String room) {
                return DropdownMenuItem<String>(
                  value: room,
                  child: Text(room),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRoom = newValue;
                });
              },
              decoration: const InputDecoration(labelText: "Phòng làm việc"),
            ),
            TextField(
              controller: _experienceController,
              decoration: const InputDecoration(labelText: "Số năm kinh nghiệm"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _addNurse,
                    child: const Text("Thêm y tá"),
                  ),
          ],
        ),
      ),
    );
  }
}

