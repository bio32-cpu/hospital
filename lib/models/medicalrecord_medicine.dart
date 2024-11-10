class MedicalRecordMedicine {
  final int id;
  final int idMedicalRecord;
  final int idMedicine;

  MedicalRecordMedicine({
    required this.id,
    required this.idMedicalRecord,
    required this.idMedicine,
  });

  factory MedicalRecordMedicine.fromJson(Map<String, dynamic> json) {
    return MedicalRecordMedicine(
      id: int.parse(json['id'].toString()), 
      idMedicalRecord: int.parse(json['idmedicalrecord'].toString()),
      idMedicine: int.parse(json['idmedicine'].toString()), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idMedicalRecord': idMedicalRecord,
      'idMedicine': idMedicine,
    };
  }
}
