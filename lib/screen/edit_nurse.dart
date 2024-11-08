import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/nurse.dart';

class EditNurseScreen extends StatefulWidget {
  final Nurse nurse;

  const EditNurseScreen({required this.nurse, Key? key}) : super(key: key);

  @override
  EditNurseScreenState createState() => EditNurseScreenState();
}

class EditNurseScreenState extends State<EditNurseScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phonenumberController;
  late TextEditingController _sexController;
  late TextEditingController _avatarController;
  late TextEditingController _degreeController;
  late TextEditingController _priceController;
  late TextEditingController _experienceController;
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.nurse.name);
    _ageController = TextEditingController(text: widget.nurse.age.toString());
    _emailController = TextEditingController(text: widget.nurse.email);
    _phonenumberController = TextEditingController(text: widget.nurse.phonenumber);
    _sexController = TextEditingController(text: widget.nurse.sex);
    _avatarController = TextEditingController(text: widget.nurse.avatar);
    _degreeController = TextEditingController(text: widget.nurse.degree);
    _priceController = TextEditingController(text: widget.nurse.price.toString());
    _experienceController = TextEditingController(text: widget.nurse.yearsexperience.toString());
    _selectedRoom = widget.nurse.room; // Khởi tạo với giá trị hiện tại
  }

  Future<void> _updateNurse() async {
    setState(() {
      _isLoading = true;
    });

    Nurse updatedNurse = Nurse(
      idPerson: widget.nurse.idPerson,
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      email: _emailController.text,
      phonenumber: _phonenumberController.text,
      sex: _sexController.text,
      avatar: _avatarController.text,
      degree: _degreeController.text,
      price: int.tryParse(_priceController.text) ?? 0,
      room: _selectedRoom ?? '', // Sử dụng giá trị đã chọn cho "Phòng"
      yearsexperience: int.tryParse(_experienceController.text) ?? 0,
    );

    bool success = await ApiService().updateNurse(updatedNurse);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true); // Trả về true để báo thành công
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
        title: Text("Sửa y tá ${widget.nurse.name}"),
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
                    onPressed: _updateNurse,
                    child: const Text("Lưu thay đổi"),
                  ),
          ],
        ),
      ),
    );
  }
}
