import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang chủ"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến danh sách bệnh nhân
              },
              child: const Text("Danh sách bệnh nhân"),
            ),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến danh sách bác sĩ
              },
              child: const Text("Danh sách bác sĩ"),
            ),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến danh sách điều dưỡng
              },
              child: const Text("Danh sách điều dưỡng"),
            ),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến danh sách hồ sơ y tế
              },
              child: const Text("Danh sách hồ sơ y tế"),
            ),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến danh sách thuốc
              },
              child: const Text("Danh sách thuốc"),
            ),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến danh sách nghỉ phép
              },
              child: const Text("Danh sách nghỉ phép"),
            ),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến quản lý tài khoản
              },
              child: const Text("Quản lý tài khoản"),
            ),
          ],
        ),
      ),
    );
  }
}
