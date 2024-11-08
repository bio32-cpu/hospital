import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/doctor.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  DoctorListScreenState createState() => DoctorListScreenState();
}

class DoctorListScreenState extends State<DoctorListScreen> {
  late Future<List<Doctor>> futureDoctors;

  @override
  void initState() {
    super.initState();
    futureDoctors = ApiService().getDoctors();
  }

  Future<void> _refreshDoctors() async {
    setState(() {
      futureDoctors = ApiService().getDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách bác sĩ"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/adddoctor').then((_) => _refreshDoctors());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Doctor>>(
        future: futureDoctors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có dữ liệu"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final doctor = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: doctor.avatar.isNotEmpty
                          ? NetworkImage(doctor.avatar)
                          : const AssetImage("assets/default_avatar.png") as ImageProvider,
                    ),
                    title: Text(doctor.name ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Chuyên khoa: ${doctor.specialized }"),
                        Text("Kinh nghiệm: ${doctor.yearsexperience } năm"),
                        Text("Email: ${doctor.email }"),
                        Text("Số điện thoại: ${doctor.phonenumber }"),
                        Text("Giới tính: ${doctor.sex }"),
                        Text("Bằng cấp: ${doctor.degree }"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDoctorScreen(doctor: doctor),
                          ),
                        ).then((_) => _refreshDoctors());
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


class EditDoctorScreen extends StatefulWidget {
  final Doctor doctor;

  const EditDoctorScreen({required this.doctor, Key? key}) : super(key: key);

  @override
  EditDoctorScreenState createState() => EditDoctorScreenState();
}

class EditDoctorScreenState extends State<EditDoctorScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _phonenumberController;
  late TextEditingController _sexController;
  late TextEditingController _avatarController;
  late TextEditingController _degreeController;
  late TextEditingController _specializedController;
  late TextEditingController _experienceController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.doctor.name);
    _ageController = TextEditingController(text: widget.doctor.age.toString());
    _emailController = TextEditingController(text: widget.doctor.email);
    _phonenumberController = TextEditingController(text: widget.doctor.phonenumber);
    _sexController = TextEditingController(text: widget.doctor.sex);
    _avatarController = TextEditingController(text: widget.doctor.avatar);
    _degreeController = TextEditingController(text: widget.doctor.degree);
    _specializedController = TextEditingController(text: widget.doctor.specialized);
    _experienceController = TextEditingController(text: widget.doctor.yearsexperience.toString());
  }

  Future<void> _updateDoctor() async {
    setState(() {
      _isLoading = true;
    });

    Doctor updatedDoctor = Doctor(
      idPerson: widget.doctor.idPerson,
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      email: _emailController.text,
      phonenumber: _phonenumberController.text,
      sex: _sexController.text,
      avatar: _avatarController.text,
      degree: _degreeController.text,
      specialized: _specializedController.text,
      yearsexperience: int.tryParse(_experienceController.text) ?? 0,
    );

    bool success = await ApiService().updateDoctor(updatedDoctor);

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
        title: Text("Sửa bác sĩ ${widget.doctor.name}"),
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
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _updateDoctor,
                    child: const Text("Lưu thay đổi"),
                  ),
          ],
        ),
      ),
    );
  }
}