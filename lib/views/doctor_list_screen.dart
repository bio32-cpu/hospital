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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách bác sĩ"),
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
                return ListTile(
                  title: Text(doctor.name),
                  subtitle: Text("Chuyên khoa: ${doctor.specialized}, Số năm kinh nghiệm: ${doctor.yearsExperience}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
