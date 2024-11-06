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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách điều dưỡng"),
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
                return ListTile(
                  title: Text(nurse.name),
                  subtitle: Text("Số điện thoại: ${nurse.phoneNumber}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
