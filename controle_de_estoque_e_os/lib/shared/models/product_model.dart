import 'package:controle_de_estoque_e_os/shared/models/product_brand_model.dart';
import 'package:controle_de_estoque_e_os/shared/models/product_type_model.dart';

class ProductModel {
  ProductModel({
    this.id,
    this.description,
    this.additionalInfo,
    this.productType,
    this.productBrand,
    this.costPrice,
    this.salePrice,
    this.quantityInStock,
    this.minimumQuantity,
    this.quanatityIn,
    this.quantityOut,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      description: map['description'],
      additionalInfo: map['additionalInfo'],
      productType: ProductTypeModel.fromMap(map['productType']),
      productBrand: ProductBrandModel.fromMap(map['productBrand']),
      costPrice: map['costPrice'],
      salePrice: map['salePrice'],
      quantityInStock: map['quantityInStock'],
      minimumQuantity: map['minimumQuantity'],
      quanatityIn: map['quanatityIn'],
      quantityOut: map['quantityOut'],
    );
  }

  final String? id;
  final String? description;
  final String? additionalInfo;
  final ProductTypeModel? productType;
  final ProductBrandModel? productBrand;
  final num? costPrice;
  final num? salePrice;
  final num? quantityInStock;
  final num? minimumQuantity;
  final num? quanatityIn;
  final num? quantityOut;

  ProductModel copyWith({
    String? id,
    String? description,
    String? additionalInfo,
    ProductTypeModel? productType,
    ProductBrandModel? productBrand,
    num? costPrice,
    num? salePrice,
    num? quantityInStock,
    num? minimumQuantity,
    num? quanatityIn,
    num? quantityOut,
  }) {
    return ProductModel(
      id: id ?? this.id,
      description: description ?? this.description,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      productType: productType ?? this.productType,
      productBrand: productBrand ?? this.productBrand,
      costPrice: costPrice ?? this.costPrice,
      salePrice: salePrice ?? this.salePrice,
      quantityInStock: quantityInStock ?? this.quantityInStock,
      minimumQuantity: minimumQuantity ?? this.minimumQuantity,
      quanatityIn: quanatityIn ?? this.quanatityIn,
      quantityOut: quantityOut ?? this.quantityOut,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, description: $description, additionalInfo: $additionalInfo, productType: $productType, productBrand: $productBrand, costPrice: $costPrice, salePrice: $salePrice, quantityInStock: $quantityInStock, minimumQuantity: $minimumQuantity, quanatityIn: $quanatityIn, quantityOut: $quantityOut)';
  }
}
