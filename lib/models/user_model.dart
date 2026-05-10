import 'package:tugas_pbm/models/class_model.dart';
import 'package:tugas_pbm/models/role_model.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final RoleModel role;
  final ClassModel
  classData; // Menggunakan classData agar tidak bentrok dengan keyword 'class'

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.classData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      role: RoleModel.fromJson(json['role']),
      classData: ClassModel.fromJson(json['class']),
    );
  }
}
