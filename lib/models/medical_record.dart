class MedicalRecord {
  final int idMedicalRecord;
  final String conclusion;
  final String conjecture;
  final bool examined;
  final int idDoctor;
  final int idNurse;
  final int idPatient;
  final int price;

  MedicalRecord({
    required this.idMedicalRecord,
    required this.conclusion,
    required this.conjecture,
    required this.examined,
    required this.idDoctor,
    required this.idNurse,
    required this.idPatient,
    required this.price,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      idMedicalRecord: json['idmedicalrecord'],
      conclusion: json['conclusion'],
      conjecture: json['conjecture'],
      examined: json['examined'] == 1,
      idDoctor: json['iddoctor'],
      idNurse: json['idnuser'],
      idPatient: json['idpatient'],
      price: json['price'],
    );
  }
}
