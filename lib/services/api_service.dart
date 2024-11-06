import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient.dart';
import '../models/doctor.dart';
import '../models/nurse.dart';
import '../models/medical_record.dart';
import '../models/medicine.dart';
import '../models/leave.dart';
import '../models/account.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2/hospital_flutter/php_api"; // Sử dụng 10.0.2.2 cho giả lập Android thay vì localhost

  
  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      throw Exception("Lỗi khi đăng nhập");
    }
  }

  
  Future<bool> register(String username, String password, String email, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "password": password,
        "email": email,
        "phone": phone,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      throw Exception("Lỗi khi đăng ký");
    }
  }

  Future<List<Patient>> getPatients() async {
    final response = await http.get(Uri.parse('$baseUrl/get_patients.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu bệnh nhân");
    }
  }

  Future<List<Doctor>> getDoctors() async {
    final response = await http.get(Uri.parse('$baseUrl/get_doctors.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Doctor.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu bác sĩ");
    }
  }

  Future<List<Nurse>> getNurses() async {
    final response = await http.get(Uri.parse('$baseUrl/get_nurses.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Nurse.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu điều dưỡng");
    }
  }

  Future<List<MedicalRecord>> getMedicalRecords() async {
    final response = await http.get(Uri.parse('$baseUrl/get_medical_records.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => MedicalRecord.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu hồ sơ y tế");
    }
  }

  Future<List<Medicine>> getMedicines() async {
    final response = await http.get(Uri.parse('$baseUrl/get_medicines.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Medicine.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu thuốc");
    }
  }

  Future<List<Leave>> getLeaves() async {
    final response = await http.get(Uri.parse('$baseUrl/get_leaves.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Leave.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu nghỉ phép");
    }
  }

  Future<List<Account>> getAccounts() async {
    final response = await http.get(Uri.parse('$baseUrl/get_accounts.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Account.fromJson(json)).toList();
    } else {
      throw Exception("Lỗi khi tải dữ liệu tài khoản");
    }
  }
}
