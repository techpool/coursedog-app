import 'package:coursedog_app/models/section.dart';

class Course {
  String id;
  String courseNumber;
  String name;
  List<Section> sections = [];

  Course(
      {required this.id,
      required this.courseNumber,
      required this.name,
      required this.sections});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      courseNumber: json['courseNumber'],
      name: json['name'],
      sections:
          List<Section>.from(json['sections']?.values.toList().map((section) {
                return Section.fromJson(section);
              }) ??
              []),
    );
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Course model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
