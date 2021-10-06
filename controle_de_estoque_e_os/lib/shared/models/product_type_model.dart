class ProductTypeModel {
  ProductTypeModel({
    this.id,
    this.description,
  });

  factory ProductTypeModel.fromMap(Map<String, dynamic> map) {
    return ProductTypeModel(
      id: map['id'],
      description: map['description'],
    );
  }

  final String? id;
  final String? description;

  ProductTypeModel copyWith({
    String? id,
    String? description,
  }) {
    return ProductTypeModel(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  String toString() => 'ProductTypeModel(id: $id, description: $description)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
    };
  }
}
