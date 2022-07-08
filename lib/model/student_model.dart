import 'package:hive_flutter/hive_flutter.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String batch;

  @HiveField(3)
  final int age;

  @HiveField(4)
  final int mobile;

  @HiveField(5)
  final String email;

  @HiveField(6)
  String? image;

  Student({
    required this.firstName,
    required this.lastName,
    required this.batch,
    required this.age,
    required this.mobile,
    required this.email,
    required this.image,
  });
}

const String boxName = "student";
