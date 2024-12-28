import 'package:grocery_ecommerce/model/tag_model.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

List<ProductModel> popularProductListFromJson(Map<String, dynamic> json) =>
    List<ProductModel>.from(
      json['data'].map((popularProduct) => ProductModel.popularProductListFromJson(popularProduct)),
    );

List<ProductModel> productListFromJson(Map<String, dynamic> json) =>
    List<ProductModel>.from(
      json['data'].map((product) => ProductModel.productListFromJson(product)),
    );

@HiveType(typeId: 3)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<String> images;

  @HiveField(4)
  final List<TagModel> tags;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.tags,
  });

  // Factory constructor for popular products (if structure differs)
  factory ProductModel.popularProductListFromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'],
      name: data['product']?['name'] ?? 'Unknown',
      description: data['product']?['description'] ?? 'No description available',
      images: (data['product']?['images'] as List<dynamic>?)
          ?.map((image) => image['formats']?['thumbnail']?['url'] ?? '')
          .cast<String>()
          .toList() ??
          [],
      tags: [], // Assuming no tags for popular products
    );
  }

  // Factory constructor for regular products
  factory ProductModel.productListFromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data['id'],
      name: data['name'] ?? 'Unknown',
      description: data['description'] ?? 'No description available',
      images: (data['images'] as List<dynamic>?)
          ?.map((image) => image['formats']?['thumbnail']?['url'] ?? '')
          .cast<String>()
          .toList() ??
          [], // Handle null or empty images safely
      tags: (data['tags'] as List<dynamic>?)
          ?.map((tag) => TagModel.fromJson(tag))
          .toList() ??
          [], // Default to empty list if tags is null
    );
  }
}
