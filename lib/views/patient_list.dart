import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/patient.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  PatientListScreenState createState() => PatientListScreenState();
}

class PatientListScreenState extends State<PatientListScreen> {
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = ApiService().getPatients();
  }

  Future<void> _refreshPatients() async {
    setState(() {
      futurePatients = ApiService().getPatients();
    });
  }

  Future<void> _deletePatient(int idPatient) async {
    bool success = await ApiService().deletePatient(idPatient);
    if (!mounted) return;
    if (success) {
      _refreshPatients();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa bệnh nhân thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách bệnh nhân"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_patient').then((_) => _refreshPatients());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Patient>>(
        future: futurePatients,
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
                final patient = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(patient.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Địa chỉ: ${patient.address}"),
                        Text("Tuổi: ${patient.age}"),
                        Text("Số điện thoại: ${patient.phoneNumber}"),
                        Text("Giới tính: ${patient.sex}"),
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
                                builder: (context) => EditPatientScreen(patient: patient),
                              ),
                            ).then((_) => _refreshPatients());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deletePatient(patient.idPatient),
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
