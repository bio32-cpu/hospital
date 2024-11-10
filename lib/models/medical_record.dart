class MedicalRecord {
  int idMedicalRecord;
  String conclusion;
  String conjecture;
  bool examined;
  String idDoctor;
  int idMedicine;
  String idNuser;
  int idPatient;
  int price;

  MedicalRecord({
    required this.idMedicalRecord,
    required this.conclusion,
    required this.conjecture,
    required this.examined,
    required this.idDoctor,
    required this.idMedicine,
    required this.idNuser,
    required this.idPatient,
    required this.price,
  });


    factory MedicalRecord.fromJson(Map<String, dynamic> json) {
  return MedicalRecord(
    idMedicalRecord: json['idmedicalrecord'] is int
        ? json['idmedicalrecord']
        : int.tryParse(json['idmedicalrecord'].toString()) ?? 0,
    conclusion: json['conclusion'] ?? '',
    conjecture: json['conjecture'] ?? '',
    examined: json['examined'] == 1,
    idDoctor: json['iddoctor'] ?? '',
    idMedicine: json['idmedicine'] is int
        ? json['idmedicine']
        : int.tryParse(json['idmedicine'].toString()) ?? 0,
    idNuser: json['idnuser'] ?? '',
    idPatient: json['idpatient'] is int
        ? json['idpatient']
        : int.tryParse(json['idpatient'].toString()) ?? 0,
    price: json['price'] is int
        ? json['price']
        : int.tryParse(json['price'].toString()) ?? 0,
  );
}
  Map<String, dynamic> toJson() {
    return {
      'idmedicalrecord': idMedicalRecord,
      'conclusion': conclusion,
      'conjecture': conjecture,
      'examined': examined ? 1 : 0,
      'iddoctor': idDoctor,
      'idmedicine': idMedicine,
      'idnuser': idNuser,
      'idpatient': idPatient,
      'price': price,
    };
  }
}
