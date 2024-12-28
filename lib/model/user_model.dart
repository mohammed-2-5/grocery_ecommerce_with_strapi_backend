import 'dart:convert';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

// Converts the JSON string to a User object
User userFromJson(Map<String, dynamic> data) => User.fromJson(data);

@HiveType(typeId: 5)
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final DateTime? birthDay;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.image,
    this.birthDay,
  });

  // Factory constructor to parse JSON
  factory User.fromJson(Map<String, dynamic> data) => User(
    id: data['id'].toString(), // Parsing ID as string
    fullName: data['FullName'] ?? '', // Handle missing FullName with a default
    email: data['email'] ?? '', // Handle missing email with a default
    image: data['image']['formats']['thumbnail']['url'], // Safely access nested fields
    birthDay: data['birthDay'] != null
        ? DateTime.parse(data['birthDay'])
        : null, // Handle nullable date parsing
  );

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'FullName': fullName,
    'email': email,
    'image': image,
    'birthDay': birthDay?.toIso8601String(),
  };
}
