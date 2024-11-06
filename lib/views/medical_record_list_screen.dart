import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/medical_record.dart';

class MedicalRecordListScreen extends StatefulWidget {
  const MedicalRecordListScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách hồ sơ y tế"),
      ),
      body: FutureBuilder<List<MedicalRecord>>(
        future: futureMedicalRecords,
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
                return ListTile(
                  title: Text("Hồ sơ y tế #${record.idMedicalRecord}"),
                  subtitle: Text("Kết luận: ${record.conclusion}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
