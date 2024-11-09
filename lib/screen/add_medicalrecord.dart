
import 'package:flutter/material.dart';
import '../models/medical_record.dart';
import '../services/api_service.dart';

class AddMedicalRecordScreen extends StatefulWidget {
  const AddMedicalRecordScreen({Key? key}) : super(key: key);

  @override
  AddMedicalRecordScreenState createState() => AddMedicalRecordScreenState();
}

class AddMedicalRecordScreenState extends State<AddMedicalRecordScreen> {
  final TextEditingController _conclusionController = TextEditingController();
  final TextEditingController _conjectureController = TextEditingController();
  bool _examined = false;

  List<String> _doctorIds = [];
  List<int> _medicineIds = [];
  List<String> _nuserIds = [];
  List<int> _patientIds = [];

  String? _selectedDoctorId;
  int? _selectedMedicineId;
  String? _selectedNuserId;
  int? _selectedPatientId;

  final TextEditingController _priceController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _doctorIds = await ApiService().getDoctorIds();
      _medicineIds = await ApiService().getMedicineIds();
      _nuserIds = await ApiService().getNuserIds();
      _patientIds = await ApiService().getPatientIds();

      print('Doctor IDs: $_doctorIds');
      print('Medicine IDs: $_medicineIds');
      print('Nuser IDs: $_nuserIds');
      print('Patient IDs: $_patientIds');

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải dữ liệu: $e')),
      );
      print('Lỗi khi tải dữ liệu: $e');
    }
  }

  Future<void> _addMedicalRecord() async {
    setState(() {
      _isLoading = true;
    });

    try {
      MedicalRecord newRecord = MedicalRecord(
        idMedicalRecord: 0,
        conclusion: _conclusionController.text,
        conjecture: _conjectureController.text,
        examined: _examined,
        idDoctor: _selectedDoctorId ?? '',
        idMedicine: _selectedMedicineId ?? 0,
        idNuser: _selectedNuserId ?? '',
        idPatient: _selectedPatientId ?? 1,
        price: int.tryParse(_priceController.text) ?? 0,
      );

      final response = await ApiService().addMedicalRecordWithResponse(newRecord);

      if (!mounted) return;

      if (response['success'] == true) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm hồ sơ y tế thành công')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thêm hồ sơ y tế thất bại: ${response['message'] ?? 'Không rõ lỗi'}')),
        );
        print('Thêm hồ sơ y tế thất bại: ${response['message'] ?? 'Không rõ lỗi'}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi xảy ra: $e')),
      );
      print('Lỗi xảy ra: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm hồ sơ y tế"),
      ),
      body: _doctorIds.isEmpty || _medicineIds.isEmpty || _nuserIds.isEmpty || _patientIds.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  TextField(
                    controller: _conclusionController,
                    decoration: const InputDecoration(labelText: "Kết luận"),
                  ),
                  TextField(
                    controller: _conjectureController,
                    decoration: const InputDecoration(labelText: "Chẩn đoán"),
                  ),
                  SwitchListTile(
                    title: const Text("Đã khám"),
                    value: _examined,
                    onChanged: (bool value) {
                      setState(() {
                        _examined = value;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Chọn ID bác sĩ"),
                    value: _selectedDoctorId,
                    items: _doctorIds.map((id) {
                      return DropdownMenuItem(
                        value: id,
                        child: Text(id),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDoctorId = newValue;
                      });
                    },
                  ),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: "Chọn ID thuốc"),
                    value: _selectedMedicineId,
                    items: _medicineIds.map((id) {
                      return DropdownMenuItem(
                        value: id,
                        child: Text(id.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedMedicineId = newValue;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Chọn ID y tá"),
                    value: _selectedNuserId,
                    items: _nuserIds.map((id) {
                      return DropdownMenuItem(
                        value: id,
                        child: Text(id),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedNuserId = newValue;
                      });
                    },
                  ),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: "Chọn ID bệnh nhân"),
                    value: _selectedPatientId,
                    items: _patientIds.map((id) {
                      return DropdownMenuItem(
                        value: id,
                        child: Text(id.toString()),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedPatientId = newValue;
                      });
                    },
                  ),
                  TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(labelText: "Giá"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _addMedicalRecord,
                          child: const Text("Thêm hồ sơ"),
                        ),
                ],
              ),
            ),
    );
  }
}
