import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Xử lý đăng xuất
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('.../assets/anh1.jpg'), // Đảm bảo có ảnh trong thư mục assets
            ),
            const SizedBox(height: 10),
            const Text(
              'Admin App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildMenuItem(context, "Danh sách bệnh nhân", Icons.people, '/patient_list', Colors.blueAccent),
                  _buildMenuItem(context, "Danh sách bác sĩ", Icons.local_hospital, '/doctor_list', Colors.greenAccent),
                  _buildMenuItem(context, "Danh sách điều dưỡng", Icons.person_outline, '/nurse_list', Colors.orangeAccent),
                  _buildMenuItem(context, "Danh sách hồ sơ y tế", Icons.folder_open, '/medical_record_list', Colors.purpleAccent),
                  _buildMenuItem(context, "Danh sách thuốc", Icons.medical_services, '/medicine_list', Colors.redAccent),
                  _buildMenuItem(context, "Đơn thuốc của bệnh nhân", Icons.local_pharmacy, '/medicalrecord_medicine', const Color.fromARGB(255, 100, 183, 255)),
                  _buildMenuItem(context, "Danh sách nghỉ phép", Icons.event_busy, '/leave_list', const Color.fromARGB(255, 60, 0, 255)),
                  _buildMenuItem(context, "Quản lý tài khoản", Icons.account_box, '/account_management', Colors.tealAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon, String route, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
