import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/medicine.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({super.key});

  @override
  MedicineListScreenState createState() => MedicineListScreenState();
}
class MedicineListScreenState extends State<MedicineListScreen> {
  late Future<List<Medicine>> futureMedicines;

  @override
  void initState() {
    super.initState();
    futureMedicines = ApiService().getMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách thuốc"),
      ),
      body: FutureBuilder<List<Medicine>>(
        future: futureMedicines,
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
                final medicine = snapshot.data![index];
                return ListTile(
                  title: Text(medicine.name),
                  subtitle: Text("Giá: ${medicine.price}, Số lượng: ${medicine.quantity}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
