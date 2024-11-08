class Patient {
  int idPatient;
  String address;
  int age;
  String name;
  String phoneNumber;
  String sex;

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
      address: json['address'] ?? '',
      age: json['age'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phonenumber'] ?? '',
      sex: json['sex'] ?? 'MALE',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idpatient': idPatient,
      'address': address,
      'age': age,
      'name': name,
      'phonenumber': phoneNumber,
      'sex': sex,
    };
  }
}
