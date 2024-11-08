// doctor.dart
class Doctor {
  String idPerson;
  int age;
  String email;
  String name;
  String phonenumber;
  String sex;
  String avatar;
  String degree;
  String specialized;
  int yearsexperience;

  Doctor({
    this.idPerson = '',
    required this.age,
    required this.email,
    required this.name,
    required this.phonenumber,
    required this.sex,
    required this.avatar,
    required this.degree,
    required this.specialized,
    required this.yearsexperience,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      idPerson: json['idperson'] ?? '',
      age: json['age'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      sex: json['sex'] ?? 'MALE',
      avatar: json['avatar'] ?? '',
      degree: json['degree'] ?? '',
      specialized: json['specialized'] ??  'INTERNAL_MEDICINE',
      yearsexperience: json['yearsexperience'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idperson': idPerson,
      'age': age,
      'email': email,
      'name': name,
      'phonenumber': phonenumber,
      'sex': sex,
      'avatar': avatar,
      'degree': degree,
      'specialized': specialized,
      'yearsexperience': yearsexperience,
    };
  }
}
