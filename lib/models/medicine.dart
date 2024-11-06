class Medicine {
  final int idMedicine;
  final String name;
  final DateTime expirationDate;
  final int price;
  final int quantity;

  Medicine({
    required this.idMedicine,
    required this.name,
    required this.expirationDate,
    required this.price,
    required this.quantity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      idMedicine: json['idmedicine'],
      name: json['name'],
      expirationDate: DateTime.parse(json['expirationdate']),
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
