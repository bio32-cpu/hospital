import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/patient.dart';
import '../models/doctor.dart';
import '../models/nurse.dart';
import '../models/medical_record.dart';
import '../models/medicine.dart';
import '../models/leave.dart';
import '../models/account.dart';
import '../models/medicalrecord_medicine.dart';

class ApiService {
  final String baseUrl = "http://192.168.1.10:80/hospital_flutter/php_api"; // Sử dụng 10.0.2.2 cho giả lập Android thay vì localhost

  
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
  // Gửi yêu cầu GET để lấy danh sách bệnh nhân
  final response = await http.get(Uri.parse('$baseUrl/get_patients.php'));

  if (response.statusCode == 200) {
    // Giải mã phản hồi JSON
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    // Kiểm tra xem phản hồi có chứa dữ liệu và thành công không
    if (responseData["success"] == true) {
      // Lấy danh sách bệnh nhân từ trường "data"
      List<dynamic> data = responseData["data"];
      // Chuyển đổi từng đối tượng JSON thành một đối tượng Patient
      return data.map((json) => Patient.fromJson(json)).toList();
    } else {
      // Nếu phản hồi không thành công, ném ra lỗi
      throw Exception("Không tải được danh sách bệnh nhân: ${responseData["message"]}");
    }
  } else {
    throw Exception("Lỗi khi tải dữ liệu bệnh nhân");
  }
}

Future<bool> addPatient(Patient patient) async {
  // Gửi yêu cầu POST để thêm bệnh nhân mới
  final response = await http.post(
    Uri.parse('$baseUrl/add_patient.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(patient.toJson()), // Chuyển đổi đối tượng Patient thành JSON
  );

  // Kiểm tra phản hồi có thành công không
  return response.statusCode == 200 &&
      jsonDecode(response.body)['success'] == true;
}

Future<bool> updatePatient(Patient patient) async {
  // Gửi yêu cầu PUT để cập nhật thông tin bệnh nhân
  final response = await http.put(
    Uri.parse('$baseUrl/update_patient.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(patient.toJson()), // Chuyển đổi đối tượng Patient thành JSON
  );

  // Kiểm tra phản hồi có thành công không
  return response.statusCode == 200 &&
      jsonDecode(response.body)['success'] == true;
}

Future<bool> deletePatient(int idPatient) async {
  // Gửi yêu cầu DELETE để xóa bệnh nhân dựa trên id
  final response = await http.post(
    Uri.parse('$baseUrl/delete_patient.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"idpatient": idPatient}), // Gửi id của bệnh nhân để xóa
  );

  if (response.statusCode == 200) {
    // Giải mã phản hồi JSON và kiểm tra trạng thái
    final data = jsonDecode(response.body);
    return data['success'] == true;
  } else {
    return false;
  }
}

//bác sĩ
  Future<List<Doctor>> getDoctors() async {
    final response = await http.get(Uri.parse('$baseUrl/get_doctors.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (responseData["success"] == true) {
        List<dynamic> data = responseData["data"];
        return data.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw Exception(responseData["message"] ?? "Lỗi khi tải dữ liệu bác sĩ");
      }
    } else {
      throw Exception("Lỗi khi tải dữ liệu bác sĩ: ${response.statusCode}");
    }
  }

  // Hàm thêm bác sĩ mới
  Future<bool> addDoctor(Doctor doctor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_doctor.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "idperson": doctor.idPerson,
        "name": doctor.name,
        "age": doctor.age,
        "email": doctor.email,
        "phonenumber": doctor.phonenumber,
        "sex": doctor.sex,
        "avatar": doctor.avatar,
        "degree": doctor.degree,
        "specialized": doctor.specialized,
        "yearsexperience": doctor.yearsexperience,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return true;
      } else {
        throw Exception(data['message'] ?? "Lỗi khi thêm bác sĩ");
      }
    } else {
      throw Exception("Lỗi khi thêm bác sĩ: ${response.statusCode}");
    }
  }
  Future<bool> updateDoctor(Doctor doctor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update_doctor.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(doctor.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      return false;
    }
  }

//nurses

  Future<List<Nurse>> getNurses() async {
  final response = await http.get(Uri.parse('$baseUrl/get_nurses.php'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);

    if (responseData["success"] == true) {
      List<dynamic> data = responseData["data"];
      return data.map((json) => Nurse.fromJson(json)).toList();
    } else {
      throw Exception("Không tải được danh sách y tá: ${responseData["message"]}");
    }
  } else {
    throw Exception("Lỗi khi tải dữ liệu y tá");
  }
}

Future<bool> addNurse(Nurse nurse) async {
  final response = await http.post(
    Uri.parse('$baseUrl/addnurse.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(nurse.toJson()),
  );

  return response.statusCode == 200 && 
      jsonDecode(response.body)['success'] == true;
}

Future<bool> updateNurse(Nurse nurse) async {
  final response = await http.put(
    Uri.parse('$baseUrl/update_nurse.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(nurse.toJson()),
  );

  return response.statusCode == 200 && 
      jsonDecode(response.body)['success'] == true;
}
// ApiService.dart
Future<bool> deleteNurse(String idPerson) async {
  final response = await http.post(
    Uri.parse('$baseUrl/delete_nurse.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"idperson": idPerson}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['success'] == true;
  } else {
    return false;
  }
}
Future<List<Medicine>> getMedicines() async {
    final response = await http.get(Uri.parse('$baseUrl/get_medicines.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((json) => Medicine.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load medicines");
    }
  }
  

  Future<Map<String, dynamic>> addMedicine(Medicine medicine) async {
  final Map<String, dynamic> medicineData = medicine.toJson();
  medicineData.removeWhere((key, value) => key == 'expirationdate' && (value == null || value.isEmpty)); // Remove if null or empty

  final response = await http.post(
    Uri.parse('$baseUrl/add_medicine.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(medicineData),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body); // Trả về phản hồi chi tiết từ server
  } else {
    return {
      'success': false,
      'message': 'Lỗi kết nối đến server hoặc lỗi không xác định'
    };
  }
}


  Future<bool> updateMedicine(Medicine medicine) async {
    final Map<String, dynamic> medicineData = medicine.toJson();
    medicineData.removeWhere((key, value) => key == 'expirationdate' && (value == null || value.isEmpty)); // Remove if null or empty

    final response = await http.put(
      Uri.parse('$baseUrl/update_medicine.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(medicineData),
    );

    return response.statusCode == 200 && jsonDecode(response.body)['success'] == true;
  }

  Future<bool> deleteMedicine(int idMedicine) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete_medicine.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idmedicine": idMedicine}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'] == true;
    } else {
      return false;
    }
  }
  


//medical_record
Future<List<MedicalRecord>> getMedicalRecords() async {
  final response = await http.get(Uri.parse('$baseUrl/get_medical_records.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => MedicalRecord.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load medical records');
  }
}


  Future<bool> addMedicalRecord(MedicalRecord record) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_medicalrecord.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(record.toJson()),
    );

    return response.statusCode == 200 && jsonDecode(response.body)['success'] == true;
  }

  Future<bool> updateMedicalRecord(MedicalRecord record) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update_medicalrecord.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(record.toJson()),
    );

    return response.statusCode == 200 && jsonDecode(response.body)['success'] == true;
  }

  Future<bool> deleteMedicalRecord(int idMedicalRecord) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete_medicalrecord.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"idmedicalrecord": idMedicalRecord}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'] == true;
    } else {
      return false;
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
  

Future<List<int>> getMedicineIds() async {
  final response = await http.get(Uri.parse('$baseUrl/get_medicine_ids.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => int.tryParse(item.toString()) ?? 0).toList();
  } else {
    throw Exception('Failed to load medicine IDs');
  }
}

Future<List<String>> getDoctorIds() async {
  final response = await http.get(Uri.parse('$baseUrl/get_doctor_ids.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => item.toString()).toList(); // Trả về chuỗi
  } else {
    throw Exception('Failed to load doctor IDs');
  }
}

Future<List<String>> getNuserIds() async {
  final response = await http.get(Uri.parse('$baseUrl/get_nuser_ids.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => item.toString()).toList(); // Trả về chuỗi
  } else {
    throw Exception('Failed to load nuser IDs');
  }
}



//medicalrecord_medicine
Future<List<MedicalRecordMedicine>> getMedicalRecordMedicines() async {
    final response = await http.get(Uri.parse('$baseUrl/get_medicalrecord_medicines.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => MedicalRecordMedicine.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load medical record medicines');
    }
  }

  Future<bool> updateMedicalRecordMedicine(MedicalRecordMedicine recordMedicine) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update_medicalrecord_medicine.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(recordMedicine.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteMedicalRecordMedicine(int idMedicalRecord, int idMedicine) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete_medicalrecord_medicine.php?idmedicalrecord=$idMedicalRecord&idmedicine=$idMedicine'),
    );
    return response.statusCode == 200;
  }




  Future<List<int>> getPatientIds() async {
  final response = await http.get(Uri.parse('$baseUrl/get_patient_ids.php'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    print(data); // In ra dữ liệu để kiểm tra
    return data.map((item) => int.parse(item.toString())).toList();
  } else {
    throw Exception('Failed to load patient IDs');
  }
}

  Future<Map<String, dynamic>> addMedicalRecordWithResponse(MedicalRecord record) async {
  final response = await http.post(
    Uri.parse('$baseUrl/add_medicalrecord.php'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(record.toJson()),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Lỗi từ server: ${response.body}');
  }
}
Future<List<Map<String, dynamic>>> getOnLeaves() async {
    final response = await http.get(Uri.parse('$baseUrl/get_onleaves.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('Failed to load onleave data');
    }
  }

  Future<bool> addLeave(Leave leave) async {
  final response = await http.post(
    Uri.parse('$baseUrl/add_onleave.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'idperson': leave.idPerson,
      'startdate': leave.startDate.toIso8601String(),
      'enddate': leave.endDate?.toIso8601String(), // Optional field
    }),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody['success'];
  } else {
    throw Exception('Failed to add leave');
  }
}

  Future<bool> updateOnLeave(int id, String idPerson, String startDate, {String? endDate}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update_onleave.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'idperson': idPerson,
        'startdate': startDate,
        'enddate': endDate,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } else {
      throw Exception('Failed to update onleave');
    }
  }

  Future<bool> deleteLeave(int id) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/delete_onleave.php?id=$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody['success'];
  } else {
    throw Exception('Failed to delete leave');
  }
}
}

  



