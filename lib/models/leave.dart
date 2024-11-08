class Leave {
  int id;
  String idPerson;
  DateTime startDate;
  DateTime? endDate;

  Leave({
    required this.id,
    required this.idPerson,
    required this.startDate,
    this.endDate,
  });

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      id: json['id'],
      idPerson: json['idperson'],
      startDate: DateTime.parse(json['startdate']),
      endDate: json['enddate'] != null ? DateTime.parse(json['enddate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idperson': idPerson,
      'startdate': startDate.toIso8601String(),
      'enddate': endDate?.toIso8601String(),
    };
  }
}
