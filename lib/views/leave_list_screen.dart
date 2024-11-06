import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/leave.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({super.key});

  @override
  LeaveListScreenState createState() => LeaveListScreenState();
}

class LeaveListScreenState extends State<LeaveListScreen> {
  late Future<List<Leave>> futureLeaves;

  @override
  void initState() {
    super.initState();
    futureLeaves = ApiService().getLeaves();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách nghỉ phép"),
      ),
      body: FutureBuilder<List<Leave>>(
        future: futureLeaves,
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
                final leave = snapshot.data![index];
                return ListTile(
                  title: Text("Nghỉ phép #${leave.id}"),
                  subtitle: Text("Bắt đầu: ${leave.startDate}, Kết thúc: ${leave.endDate}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
