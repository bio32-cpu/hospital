class Leave {
  int id;
  String idPerson;
  String startDate; // Biến ngày bắt đầu dưới dạng chuỗi
  String endDate; // Biến ngày kết thúc dưới dạng chuỗi

  Leave({
    required this.id,
    required this.idPerson,
    required this.startDate,
    required this.endDate,
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'] ?? 0,
      idPerson: json['idperson'] ?? '',
      startDate: json['startdate'] ?? '',
      endDate: json['enddate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idperson': idPerson,
      'startdate': startDate,
      'enddate': endDate,
    };
  }
}
