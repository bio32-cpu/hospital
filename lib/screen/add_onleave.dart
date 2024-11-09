import 'package:flutter/material.dart';
import '../models/leave.dart';
import '../services/api_service.dart';

class AddOnLeaveScreen extends StatefulWidget {
  const AddOnLeaveScreen({Key? key}) : super(key: key);

  @override
  AddOnLeaveScreenState createState() => AddOnLeaveScreenState();
}

class AddOnLeaveScreenState extends State<AddOnLeaveScreen> {
  List<String> _doctorIds = [];
  String? _selectedDoctorId;
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDoctorIds();
  }

  Future<void> _loadDoctorIds() async {
    try {
      _doctorIds = await ApiService().getDoctorIds(); // Ensure this function exists in ApiService
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi tải dữ liệu ID bác sĩ: $e')),
      );
      print('Lỗi khi tải dữ liệu ID bác sĩ: $e');
    }
  }

  Future<void> _addLeave() async {
  if (_selectedDoctorId == null || _startDateController.text.isEmpty || _endDateController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  Leave newLeave = Leave(
    id: 0,
    idPerson: _selectedDoctorId!,
    startDate: _startDateController.text,
    endDate: _endDateController.text,
  );

  try {
    print('Selected ID: ${newLeave.idPerson}');
    print('Start Date: ${newLeave.startDate}');
    print('End Date: ${newLeave.endDate}');

    final response = await ApiService().addLeave(newLeave);

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (response ['success'] == true) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thêm nghỉ phép thành công')),
      );
    } else {
      final errorMessage = response ['message'] ?? 'Kiểm tra lại dữ liệu.'  'Phản hồi từ máy chủ không hợp lệ';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thêm nghỉ phép thất bại: $errorMessage')),
      );
      print('Thêm nghỉ phép thất bại: $errorMessage');
    }
  } catch (e) {
    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lỗi xảy ra: $e')),
    );
    print('Lỗi xảy ra: $e');
  }



  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toIso8601String().split('T').first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm nghỉ phép"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
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
            TextField(
              controller: _startDateController,
              decoration: const InputDecoration(
                labelText: "Ngày bắt đầu (YYYY-MM-DD)",
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _startDateController),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _endDateController,
              decoration: const InputDecoration(
                labelText: "Ngày kết thúc (YYYY-MM-DD)",
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _endDateController),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _addLeave,
                    child: const Text("Thêm nghỉ phép"),
                  ),
          ],
        ),
      ),
    );
  }
}
