import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/nurse.dart';

class NurseListScreen extends StatefulWidget {
  const NurseListScreen({super.key});

  @override
  NurseListScreenState createState() => NurseListScreenState();
}

class NurseListScreenState extends State<NurseListScreen> {
  late Future<List<Nurse>> futureNurses;

  @override
  void initState() {
    super.initState();
    futureNurses = ApiService().getNurses();
  }

  Future<void> _refreshNurses() async {
    setState(() {
      futureNurses = ApiService().getNurses();
    });
  }

   Future<void> _deleteNurse(String idPerson) async {
    bool success = await ApiService().deleteNurse(idPerson);
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa y tá thành công')),
      );
      _refreshNurses();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa y tá thất bại')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách y tá"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addnurse').then((_) => _refreshNurses());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Nurse>>(
        future: futureNurses,
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
                final nurse = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: nurse.avatar.isNotEmpty
                          ? NetworkImage(nurse.avatar)
                          : const AssetImage("assets/default_avatar.png") as ImageProvider,
                    ),
                    title: Text(nurse.name ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Phòng: ${nurse.room  }"),
                        Text("Kinh nghiệm: ${nurse.yearsexperience  }năm"),
                        Text("Email: ${nurse.email  }"),
                        Text("Số điện thoại: ${nurse.phonenumber }"),
                        Text("Giới tính: ${nurse.sex  }"),
                        Text("Bằng cấp: ${nurse.degree  }"),
                        Text("Giá: ${nurse.price } VND"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditNurseScreen(nurse: nurse),
                              ),
                            ).then((_) => _refreshNurses());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNurse(nurse.idPerson ),
                        ),
                      ],
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
  late TextEditingController _roomController;
  late TextEditingController _experienceController;
  bool _isLoading = false;

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
    _roomController = TextEditingController(text: widget.nurse.room);
    _experienceController = TextEditingController(text: widget.nurse.yearsexperience.toString());
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
      room: _roomController.text,
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
              decoration: const InputDecoration(labelText: "Giá"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _roomController,
              decoration: const InputDecoration(labelText: "Phòng"),
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
