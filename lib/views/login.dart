// import 'package:flutter/material.dart';
// import '../services/api_service.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   LoginScreenState createState() => LoginScreenState();
// }

// class LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//   String? _errorMessage;

//  void _login() async {
//   setState(() {
//     _isLoading = true;
//     _errorMessage = null;
//   });

//   try {
//     final success = await ApiService().login(
//       _usernameController.text,
//       _passwordController.text,
//     );

//     setState(() {
//       _isLoading = false;
//     });

//     if (success) {
//       if (!mounted) return; // Kiểm tra nếu widget vẫn còn tồn tại trong cây widget
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       setState(() {
//         _errorMessage = "Sai tên đăng nhập hoặc mật khẩu";
//       });
//     }
//   } catch (e) {
//     setState(() {
//       _isLoading = false;
//       _errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại.";
//     });
//   }
// }




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//              Image.network(
//                   'https://cdn-icons-png.freepik.com/256/3209/3209074.png?semt=ais_hybrid',
//                   width: 80,
//                   height: 80,
//                 ),
//                 const SizedBox(height: 16),
//             TextField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Tài khoản ',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//              TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Mật khẩu',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     suffixIcon: const Icon(Icons.visibility_off),
//                   ),
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 10),
//             if (_errorMessage != null)
//               Text(
//                 _errorMessage!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             const SizedBox(height: 20),
//              _isLoading
//                     ? const CircularProgressIndicator()
//                     : SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _login,
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                           ),
//                           child: const Text('Đăng nhập'),
//                         ),
//                       ),
//                 const SizedBox(height: 10),
//             // 
//             Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Chưa có tài khoản?"),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/register');
//                       },
//                       child: const Text('Đăng ký'),
//                     ),
//                   ],
//                 ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final success = await ApiService().login(
        _usernameController.text,
        _passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (success) {
        if (!mounted) return; // Kiểm tra nếu widget vẫn còn tồn tại trong cây widget
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = "Sai tên đăng nhập hoặc mật khẩu";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Đã xảy ra lỗi. Vui lòng thử lại.";
      });
    }
  }

  @override
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
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Tài khoản ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: const Icon(Icons.visibility_off),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text('Đăng nhập'),
                            ),
                          ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chưa có tài khoản?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text('Đăng ký'),
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

