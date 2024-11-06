import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/account.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  AccountManagementScreenState createState() => AccountManagementScreenState();
}

class AccountManagementScreenState extends State<AccountManagementScreen> {
  late Future<List<Account>> futureAccounts;

  @override
  void initState() {
    super.initState();
    futureAccounts = ApiService().getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý tài khoản"),
      ),
      body: FutureBuilder<List<Account>>(
        future: futureAccounts,
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
                final account = snapshot.data![index];
                return ListTile(
                  title: Text(account.username),
                  subtitle: Text("Vai trò: ${account.role}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
