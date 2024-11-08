import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/medicine.dart';


class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({super.key});

  @override
  MedicineListScreenState createState() => MedicineListScreenState();
}

class MedicineListScreenState extends State<MedicineListScreen> {
  late Future<List<Medicine>> futureMedicines;

  @override
  void initState() {
    super.initState();
    futureMedicines = ApiService().getMedicines();
  }

  Future<void> _refreshMedicines() async {
    setState(() {
      futureMedicines = ApiService().getMedicines();
    });
  }

  Future<void> _deleteMedicine(int idMedicine) async {
    bool success = await ApiService().deleteMedicine(idMedicine);
    if (!mounted) return;
    if (success) {
      _refreshMedicines();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Xóa thuốc thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách thuốc"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add_medicine').then((_) => _refreshMedicines());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Medicine>>(
        future: futureMedicines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có dữ liệu thuốc"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final medicine = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(medicine.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hạn sử dụng: ${medicine.expirationdate}"),
                        Text("Giá: ${medicine.price} VND"),
                        Text("Số lượng: ${medicine.quantity}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMedicineScreen(medicine: medicine),
                              ),
                            ).then((_) => _refreshMedicines());
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteMedicine(medicine.idmedicine),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
class EditMedicineScreen extends StatefulWidget {
  final Medicine medicine;

  const EditMedicineScreen({required this.medicine, Key? key}) : super(key: key);

  @override
  EditMedicineScreenState createState() => EditMedicineScreenState();
}

class EditMedicineScreenState extends State<EditMedicineScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _expirationDateController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.medicine.name);
    _priceController = TextEditingController(text: widget.medicine.price.toString());
    _quantityController = TextEditingController(text: widget.medicine.quantity.toString());
    _expirationDateController = TextEditingController(text: widget.medicine.expirationdate);
  }

  Future<void> _updateMedicine() async {
    setState(() {
      _isLoading = true;
    });

    String expirationDate = _expirationDateController.text;

    Medicine updatedMedicine = Medicine(
      idmedicine: widget.medicine.idmedicine,
      name: _nameController.text,
      expirationdate: expirationDate,
      price: int.tryParse(_priceController.text) ?? 0,
      quantity: int.tryParse(_quantityController.text) ?? 0,
    );

    bool success = await ApiService().updateMedicine(updatedMedicine);

    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (success) {
      Navigator.pop(context, true); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật thông tin thuốc thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa thuốc ${widget.medicine.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Tên thuốc"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Giá"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: "Số lượng"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expirationDateController,
              decoration: const InputDecoration(labelText: "Ngày hết hạn (YYYY-MM-DD)"),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _updateMedicine,
                    child: const Text("Lưu thay đổi"),
                  ),
          ],
        ),
      ),
    );
  }
}