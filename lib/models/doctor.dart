class Doctor {
  final String idPerson;
  final int age;
  final String email;
  final String name;
  final String phoneNumber;
  final String sex;
  final String avatar;
  final String degree;
  final String specialized;
  final int yearsExperience;

  Doctor({
    required this.idPerson,
    required this.age,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.sex,
    required this.avatar,
    required this.degree,
    required this.specialized,
    required this.yearsExperience,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      idPerson: json['idperson'],
      age: json['age'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phonenumber'],
      sex: json['sex'],
      avatar: json['avatar'],
      degree: json['degree'],
      specialized: json['specialized'],
      yearsExperience: json['yearsexperience'],
    );
  }
}
