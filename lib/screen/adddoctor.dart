import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/doctor.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  AddDoctorScreenState createState() => AddDoctorScreenState();
}

class AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _specializedController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  bool _isLoading = false;

  Future<void> _addDoctor() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Doctor newDoctor = Doctor(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        email: _emailController.text,
        phonenumber: _phonenumberController.text,
        sex: _sexController.text,
        avatar: _avatarController.text,
        degree: _degreeController.text,
        specialized: _specializedController.text,
        yearsexperience: int.parse(_experienceController.text),
      );

      bool success = await ApiService().addDoctor(newDoctor);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (success) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm bác sĩ thất bại')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm bác sĩ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Tên bác sĩ"),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: "Tuổi"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _phonenumberController,
              decoration: const InputDecoration(labelText: "Số điện thoại"),
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
              controller: _specializedController,
              decoration: const InputDecoration(labelText: "Chuyên khoa"),
            ),
            TextField(
              controller: _experienceController,
              decoration: const InputDecoration(labelText: "Số năm kinh nghiệm"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addDoctor,
                    child: const Text("Thêm bác sĩ"),
                  ),
          ],
        ),
      ),
    );
  }
}

