class Nurse {
  String idPerson;
  int age;
  String email;
  String name;
  String phonenumber;
  String sex;
  String avatar;
  String degree;
  int price;
  String room;
  int yearsexperience;

  Nurse({
    required this.idPerson,
    required this.age,
    required this.email,
    required this.name,
    required this.phonenumber,
    required this.sex,
    required this.avatar,
    required this.degree,
    required this.price,
    required this.room,
    required this.yearsexperience,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      idPerson: json['idperson'],
      age: json['age'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      sex: json['sex'] ?? 'MALE',
      avatar: json['avatar'] ?? '',
      degree: json['degree'] ?? '',
      price: json['price'] ?? 0,
      room: json['room'] ?? 'PATIENT_CARE',
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
      'price': price,
      'room': room,
      'yearsexperience': yearsexperience,
    };
  }
}
