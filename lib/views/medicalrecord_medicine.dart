import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/medicalrecord_medicine.dart';

class MedicalRecordMedicineScreen extends StatefulWidget {
  const MedicalRecordMedicineScreen({Key? key}) : super(key: key);

  @override
  MedicalRecordMedicineScreenState createState() => MedicalRecordMedicineScreenState();
}

class MedicalRecordMedicineScreenState extends State<MedicalRecordMedicineScreen> {
  late Future<List<MedicalRecordMedicine>> futureMedicines;

  @override
  void initState() {
    super.initState();
    
  }

  

  
  Future<void> _addMedicine(int idMedicalRecord, int idMedicine) async {
    final response = await ApiService().addMedicalRecordMedicine(idMedicalRecord, idMedicine);
    if (response['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thêm thuốc vào hồ sơ thành công')),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${response['message']}')),
      );
    }
  }

  Future<void> _updateMedicine(int id, int idMedicalRecord, int idMedicine) async {
    final response = await ApiService().updateMedicalRecordMedicine(id, idMedicalRecord, idMedicine);
    if (response['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thuốc trong hồ sơ thành công')),
      );
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${response['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn thuốc của bệnh nhân"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Mở dialog hoặc màn hình để thêm thuốc mới vào hồ sơ
            },
          ),
        ],
      ),
      body: FutureBuilder<List<MedicalRecordMedicine>>(
        future: futureMedicines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có đơn thuốc trong hồ sơ"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final medicineRecord = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text("ID MedicalRecord: ${medicineRecord.idMedicalRecord}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID Medicine: ${medicineRecord.idMedicine}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Implement chức năng cập nhật thuốc ở đây
                          },
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
