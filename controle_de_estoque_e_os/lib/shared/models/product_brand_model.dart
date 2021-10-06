class ProductBrandModel {
  ProductBrandModel({
    this.id,
    this.description,
  });

  factory ProductBrandModel.fromMap(Map<String, dynamic> map) {
    return ProductBrandModel(
      id: map['id'],
      description: map['description'],
    );
  }
  final String? id;
  final String? description;

  ProductBrandModel copyWith({
    String? id,
    String? description,
  }) {
    return ProductBrandModel(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'ProductBrandModel(id: $id, description: $description)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
    };
  }
}
