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
  String _selectedRole = 'PATIENT'; 
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
        _selectedRole,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        if (mounted) {
          Navigator.pop(context); // Quay lại màn hình đăng nhập
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
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //            Image.network(
  //                 'https://cdn-icons-png.freepik.com/256/3209/3209074.png?semt=ais_hybrid',
  //                 width: 80,
  //                 height: 80,
  //            ),
  //           TextField(
  //             controller: _usernameController,
  //             decoration: const InputDecoration(
  //               labelText: 'Tên đăng nhập',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           const SizedBox(height: 20),
  //           TextField(
  //             controller: _passwordController,
  //             decoration: const InputDecoration(
  //               labelText: 'Mật khẩu',
  //               border: OutlineInputBorder(),
  //             ),
  //             obscureText: true,
  //           ),
  //           const SizedBox(height: 20),
  //           DropdownButton<String>(
  //             value: _selectedRole,
  //             items: ['ADMIN', 'DOCTOR', 'NURSE', 'PATIENT', 'RECEPTION']
  //                 .map((role) => DropdownMenuItem(
  //                       value: role,
  //                       child: Text(role),
  //                     ))
  //                 .toList(),
  //             onChanged: (value) {
  //               setState(() {
  //                 _selectedRole = value ?? 'PATIENT';
  //               });
  //             },
  //             isExpanded: true,
  //           ),
  //           const SizedBox(height: 20),
  //           if (_errorMessage != null)
  //             Text(
  //               _errorMessage!,
  //               style: const TextStyle(color: Colors.red),
  //             ),
  //           const SizedBox(height: 20),
  //           _isLoading
  //               ? const CircularProgressIndicator()
  //               : ElevatedButton(
  //                   onPressed: _register,
  //                   child: const Text('Đăng ký'),
  //                 ),
  //                 const SizedBox(height: 10),
  //           Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const Text("Đã có tài khoản?"),
  //                   TextButton(
  //                     onPressed: () {
  //                       Navigator.pop(context, '/login');
  //                     },
  //                     child: const Text('Đăng nhập'),
  //                   ),
  //                 ],
  //               ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Hình nền
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://static.vecteezy.com/system/resources/previews/023/639/130/non_2x/molecular-structure-with-hospital-cross-for-medical-chemistry-and-science-concept-background-illustration-vector.jpg',
              ),
              fit: BoxFit.cover, // Đảm bảo hình nền bao phủ toàn bộ màn hình
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn-icons-png.freepik.com/256/3209/3209074.png?semt=ais_hybrid',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên đăng nhập',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: _selectedRole,
                    items: ['ADMIN', 'DOCTOR', 'NURSE', 'PATIENT', 'RECEPTION']
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedRole = value ?? 'PATIENT';
                      });
                    },
                    isExpanded: true,
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
                          child: const Text('Đăng ký'),
                        ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Đã có tài khoản?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, '/login');
                        },
                        child: const Text('Đăng nhập'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}
