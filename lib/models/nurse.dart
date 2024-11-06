class Nurse {
  final String idPerson;
  final int age;
  final String email;
  final String name;
  final String phoneNumber;
  final String sex;
  final String avatar;
  final String degree;
  final String room;

  Nurse({
    required this.idPerson,
    required this.age,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.sex,
    required this.avatar,
    required this.degree,
    required this.room,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      idPerson: json['idperson'],
      age: json['age'],
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phonenumber'],
      sex: json['sex'],
      avatar: json['avatar'],
      degree: json['degree'],
      room: json['room'],
    );
  }
}
