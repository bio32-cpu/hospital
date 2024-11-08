class MedicalRecordMedicine {
  int idMedicalRecord;
  int idMedicine;

  MedicalRecordMedicine({
    required this.idMedicalRecord,
    required this.idMedicine,
  });

  factory MedicalRecordMedicine.fromJson(Map<String, dynamic> json) {
    return MedicalRecordMedicine(
      idMedicalRecord: json['idmedicalrecord'],
      idMedicine: json['idmedicine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idmedicalrecord': idMedicalRecord,
      'idmedicine': idMedicine,
    };
  }
}
