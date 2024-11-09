class MedicalRecordMedicine {
  int id;
  int idMedicalRecord;
  int idMedicine;

  MedicalRecordMedicine({
    required this.id,
    required this.idMedicalRecord,
    required this.idMedicine,
  });

  factory MedicalRecordMedicine.fromJson(Map<String, dynamic> json) {
    return MedicalRecordMedicine(
      id: json['id'],
      idMedicalRecord: json['idmedicalrecord'],
      idMedicine: json['idmedicine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idmedicalrecord': idMedicalRecord,
      'idmedicine': idMedicine,
    };
  }
}
