class Leave {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final String idPerson;

  Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.idPerson,
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'],
      startDate: DateTime.parse(json['startdate']),
      endDate: DateTime.parse(json['enddate']),
      idPerson: json['idperson'],
    );
  }
}
