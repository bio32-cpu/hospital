class Medicine {
  int idmedicine; 
  String name;
  String expirationdate;
  int price;
  int quantity;

  Medicine({
    required this.idmedicine,
    required this.name,
    required this.expirationdate,
    required this.price,
    required this.quantity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      idmedicine: json['idmedicine'] ,
      name: json['name'] ?? '',
      expirationdate: json['expirationdate'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idmedicine': idmedicine,
      'name': name,
      'expirationdate': expirationdate,
      'price': price,
      'quantity': quantity,
    };
  }
}
