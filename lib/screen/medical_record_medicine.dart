import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/medicalrecord_medicine.dart';

class MedicalRecordMedicineScreen extends StatefulWidget {
  const MedicalRecordMedicineScreen({Key? key}) : super(key: key);

  @override
  MedicalRecordMedicineScreenState createState() => MedicalRecordMedicineScreenState();
}

class MedicalRecordMedicineScreenState extends State<MedicalRecordMedicineScreen> {
  late Future<List<MedicalRecordMedicine>> futureMedicalRecordMedicines;

  @override
  void initState() {
    super.initState();
    futureMedicalRecordMedicines = ApiService().getMedicalRecordMedicines();
  }

  Future<void> _refreshMedicalRecordMedicines() async {
    setState(() {
      futureMedicalRecordMedicines = ApiService().getMedicalRecordMedicines();
    });
  }

  Future<void> _deleteMedicalRecordMedicine(int idMedicalRecord, int idMedicine) async {
    bool success = await ApiService().deleteMedicalRecordMedicine(idMedicalRecord, idMedicine);
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa đơn thuốc thành công')),
      );
      _refreshMedicalRecordMedicines();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa đơn thuốc thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách đơn thuốc"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_medicalrecord_medicine')
                  .then((_) => _refreshMedicalRecordMedicines());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<MedicalRecordMedicine>>(
        future: futureMedicalRecordMedicines,
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
                final recordMedicine = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text("ID Medical Record: ${recordMedicine.idMedicalRecord}"),
                    subtitle: Text("ID Medicine: ${recordMedicine.idMedicine}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMedicalRecordMedicineScreen(recordMedicine: recordMedicine),
                              ),
                            ).then((_) => _refreshMedicalRecordMedicines());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteMedicalRecordMedicine(
                            recordMedicine.idMedicalRecord,
                            recordMedicine.idMedicine,
                          ),
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


class EditMedicalRecordMedicineScreen extends StatefulWidget {
  final MedicalRecordMedicine recordMedicine;

  const EditMedicalRecordMedicineScreen({Key? key, required this.recordMedicine}) : super(key: key);

  @override
  EditMedicalRecordMedicineScreenState createState() => EditMedicalRecordMedicineScreenState();
}

class EditMedicalRecordMedicineScreenState extends State<EditMedicalRecordMedicineScreen> {
  late TextEditingController _idMedicalRecordController;
  late TextEditingController _idMedicineController;

  @override
  void initState() {
    super.initState();
    _idMedicalRecordController = TextEditingController(text: widget.recordMedicine.idMedicalRecord.toString());
    _idMedicineController = TextEditingController(text: widget.recordMedicine.idMedicine.toString());
  }

  Future<void> _updateMedicalRecordMedicine() async {
    try {
      MedicalRecordMedicine updatedRecordMedicine = MedicalRecordMedicine(
        idMedicalRecord: int.parse(_idMedicalRecordController.text),
        idMedicine: int.parse(_idMedicineController.text),
      );

      bool success = await ApiService().updateMedicalRecordMedicine(updatedRecordMedicine);
      if (!mounted) return;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật đơn thuốc thành công')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật đơn thuốc thất bại')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa đơn thuốc"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idMedicalRecordController,
              decoration: const InputDecoration(labelText: "ID Medical Record"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _idMedicineController,
              decoration: const InputDecoration(labelText: "ID Medicine"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateMedicalRecordMedicine,
              child: const Text("Lưu thay đổi"),
            ),
          ],
        ),
      ),
    );
  }
}
