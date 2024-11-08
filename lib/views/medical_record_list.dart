
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/medical_record.dart';

class MedicalRecordListScreen extends StatefulWidget {
  const MedicalRecordListScreen({Key? key}) : super(key: key);

  @override
  MedicalRecordListScreenState createState() => MedicalRecordListScreenState();
}

class MedicalRecordListScreenState extends State<MedicalRecordListScreen> {
  late Future<List<MedicalRecord>> futureMedicalRecords;

  @override
  void initState() {
    super.initState();
    futureMedicalRecords = ApiService().getMedicalRecords();
  }

  Future<void> _refreshMedicalRecords() async {
    setState(() {
      futureMedicalRecords = ApiService().getMedicalRecords();
    });
  }

  Future<void> _deleteMedicalRecord(int idMedicalRecord) async {
    try {
      bool success = await ApiService().deleteMedicalRecord(idMedicalRecord);
      if (!mounted) return;
      if (success) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Xóa hồ sơ y tế thành công')),
          );
        });
        _refreshMedicalRecords();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Xóa hồ sơ y tế thất bại')),
          );
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi xảy ra khi xóa: $e')),
        );
      });
      print('Lỗi xảy ra khi xóa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách hồ sơ y tế"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_medicalrecord')
                  .then((_) => _refreshMedicalRecords());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<MedicalRecord>>(
        future: futureMedicalRecords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Lỗi: ${snapshot.error}")),
              );
            });
            return const Center(child: Text("Lỗi khi tải dữ liệu"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có dữ liệu"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final medicalRecord = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kết luận: ${medicalRecord.conclusion}"),
                        Text("Chẩn đoán: ${medicalRecord.conjecture}"),
                        Text("Đã khám: ${medicalRecord.examined ? 'Có' : 'Không'}"),
                        Text("ID Bác sĩ: ${medicalRecord.idDoctor}"),
                        Text("ID Thuốc: ${medicalRecord.idMedicine}"),
                        Text("ID Y tá: ${medicalRecord.idNuser}"),
                        Text("ID Bệnh nhân: ${medicalRecord.idPatient}"),
                        Text("Giá: ${medicalRecord.price} VND"),
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
                                builder: (context) => EditMedicalRecordScreen(medicalRecord: medicalRecord),
                              ),
                            ).then((_) => _refreshMedicalRecords());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteMedicalRecord(medicalRecord.idMedicalRecord),
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

class EditMedicalRecordScreen extends StatefulWidget {
  final MedicalRecord medicalRecord;

  const EditMedicalRecordScreen({Key? key, required this.medicalRecord}) : super(key: key);

  @override
  EditMedicalRecordScreenState createState() => EditMedicalRecordScreenState();
}

class EditMedicalRecordScreenState extends State<EditMedicalRecordScreen> {
  late TextEditingController _conclusionController;
  late TextEditingController _conjectureController;
  bool _examined = false;
  late TextEditingController _idDoctorController;
  late TextEditingController _idMedicineController;
  late TextEditingController _idNuserController;
  late TextEditingController _idPatientController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _conclusionController = TextEditingController(text: widget.medicalRecord.conclusion);
    _conjectureController = TextEditingController(text: widget.medicalRecord.conjecture);
    _examined = widget.medicalRecord.examined;
    _idDoctorController = TextEditingController(text: widget.medicalRecord.idDoctor);
    _idMedicineController = TextEditingController(text: widget.medicalRecord.idMedicine.toString());
    _idNuserController = TextEditingController(text: widget.medicalRecord.idNuser);
    _idPatientController = TextEditingController(text: widget.medicalRecord.idPatient.toString());
    _priceController = TextEditingController(text: widget.medicalRecord.price.toString());
  }

  Future<void> _updateMedicalRecord() async {
    // Add your logic to update the medical record here
    Navigator.pop(context, true); // Return true to refresh the list after edit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa hồ sơ y tế"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _conclusionController,
              decoration: const InputDecoration(labelText: "Kết luận"),
            ),
            TextField(
              controller: _conjectureController,
              decoration: const InputDecoration(labelText: "Chẩn đoán"),
            ),
            SwitchListTile(
              title: const Text("Đã khám"),
              value: _examined,
              onChanged: (bool value) {
                setState(() {
                  _examined = value;
                });
              },
            ),
            TextField(
              controller: _idDoctorController,
              decoration: const InputDecoration(labelText: "ID Bác sĩ"),
            ),
            TextField(
              controller: _idMedicineController,
              decoration: const InputDecoration(labelText: "ID Thuốc"),
            ),
            TextField(
              controller: _idNuserController,
              decoration: const InputDecoration(labelText: "ID Y tá"),
            ),
            TextField(
              controller: _idPatientController,
              decoration: const InputDecoration(labelText: "ID Bệnh nhân"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Giá"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateMedicalRecord,
              child: const Text("Lưu thay đổi"),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _conclusionController.dispose();
    _conjectureController.dispose();
    _idDoctorController.dispose();
    _idMedicineController.dispose();
    _idNuserController.dispose();
    _idPatientController.dispose();
    _priceController.dispose();
    super.dispose();
}
}