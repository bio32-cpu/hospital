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

  Future<void> _deleteMedicalRecordMedicine(int id) async {
    bool success = await ApiService().deleteMedicalRecordMedicine(id);
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
                final record = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text("ID Bệnh án: ${record.idMedicalRecord}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID Thuốc: ${record.idMedicine}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Implement the edit functionality here
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteMedicalRecordMedicine(record.id),
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
