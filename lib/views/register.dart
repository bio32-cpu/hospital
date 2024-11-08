import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  try {
    final success = await ApiService().register(
      _usernameController.text,
      _passwordController.text,
      _emailController.text,
      _phoneController.text,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      if(mounted){
        Navigator.pop(context); // Quay lại màn hình đăng nhậ
      }
      
    } else {
      setState(() {
        _errorMessage = "Đăng ký không thành công. Tên đăng nhập có thể đã tồn tại.";
      });
    }
  } catch (e) {
    setState(() {
      _isLoading = false;
      _errorMessage = "Đã xảy ra lỗi: $e"; // Hiển thị chi tiết lỗi
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng Ký"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Tên đăng nhập'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Số điện thoại'),
            ),
            const SizedBox(height: 20),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text("Đăng Ký"),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Đã có tài khoản? Đăng nhập"),
            ),
          ],
        ),
      ),
    );
  }
}
