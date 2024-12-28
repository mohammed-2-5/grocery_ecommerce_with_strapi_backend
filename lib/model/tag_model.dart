import 'package:hive/hive.dart';

part 'tag_model.g.dart';

@HiveType(typeId: 4)
class TagModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  TagModel({
    required this.id,
    required this.title,
    required this.price,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      title: json['title'] ?? 'Untitled',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
