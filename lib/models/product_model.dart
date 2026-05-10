class ProductModel {
  final int id;
  final String name;
  final double price;
  final String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] == null
          ? 0.0
          : double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'description': description,
  };
}
