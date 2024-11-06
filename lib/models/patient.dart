class Patient {
  final int idPatient;
  final String address;
  final int age;
  final String name;
  final String phoneNumber;
  final String sex;

  Patient({
    required this.idPatient,
    required this.address,
    required this.age,
    required this.name,
    required this.phoneNumber,
    required this.sex,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      idPatient: json['idpatient'],
      address: json['address'],
      age: json['age'],
      name: json['name'],
      phoneNumber: json['phonenumber'],
      sex: json['sex'],
    );
  }
}
