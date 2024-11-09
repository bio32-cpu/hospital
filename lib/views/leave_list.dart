import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/leave.dart';

class LeaveListScreen extends StatefulWidget {
  const LeaveListScreen({Key? key}) : super(key: key);

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

  Future<void> _refreshLeaves() async {
    setState(() {
      futureLeaves = ApiService().getLeaves();
    });
  }

  Future<void> _deleteLeave(int id) async {
    bool success = await ApiService().deleteLeave(id);
    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa nghỉ phép thành công')),
      );
      _refreshLeaves();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa nghỉ phép thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách nghỉ phép"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_onleave')
                  .then((_) => _refreshLeaves());
            },
          ),
        ],
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
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text("ID Nhân viên: ${leave.idPerson}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ngày bắt đầu: ${leave.startDate}"),
                        Text("Ngày kết thúc: ${leave.endDate}"),
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
                          onPressed: () => _deleteLeave(leave.id),
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
