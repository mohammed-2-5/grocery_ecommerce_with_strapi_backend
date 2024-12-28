import 'package:hive/hive.dart';
part 'category_model.g.dart';
List<CategoryModel> popularCategoryListFromJson(Map<String, dynamic> json) =>
    List<CategoryModel>.from(json['data']
        .map((category) => CategoryModel.popularCategoryFromJson(category)));

List<CategoryModel> categoryListFromJson(Map<String, dynamic> json) =>
    List<CategoryModel>.from(json['data']
        .map((category) => CategoryModel.categoryFromJson(category)));

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  // For parsing popular category JSON
  factory CategoryModel.popularCategoryFromJson(Map<String, dynamic> data) =>
      CategoryModel(
        id: data['category']['id'],
        name: data['category']['name'],
        image: data['category']['image']['formats']['thumbnail']['url'],
      );

  // For parsing general category JSON
  factory CategoryModel.categoryFromJson(Map<String, dynamic> data) =>
      CategoryModel(
        id: data['id'],
        name: data['name'],
        image: data['image']['formats']['thumbnail']['url'],
      );
}
