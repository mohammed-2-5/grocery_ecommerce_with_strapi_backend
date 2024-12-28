
import 'package:hive/hive.dart';
part 'banner_model.g.dart';
List<BannerModel> dataModelListFromJson(Map<String, dynamic> json) {
  return List<BannerModel>.from(
      json['data'].map((item) => BannerModel.fromJson(item))
  );
}
@HiveType(typeId: 1)
class BannerModel {

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String thumbnailUrl;

  BannerModel({
    required this.id,
    required this.thumbnailUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json['id'],
    thumbnailUrl: json['image']['formats']['thumbnail']['url'],
  );
}
