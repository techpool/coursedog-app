// _id: Joi.any().default(token(20)),
//       studentId: Joi.string().required(),
//       type: Joi.string().valid('event', 'course').required(),
//       entityInfo: Joi.alternatives().conditional('type', {
//         switch: [
//           {
//             is: 'event',
//             then: Joi.object({
//               eventId: Joi.string().required(),
//             }),
//           },
//           {
//             is: 'course',
//             then: Joi.object({
//               courseId: Joi.string().required(),
//               sectionId: Joi.string().required(),
//               termId: Joi.string().required(),
//             }),
//           },
//         ],
//       }).required(),

class FavouriteCourse {
  String id;
  String courseId;
  String sectionId;
  String termId;

  FavouriteCourse(
      {required this.id,
      required this.courseId,
      required this.sectionId,
      required this.termId});

  factory FavouriteCourse.fromJson(Map<String, dynamic> json) {
    return FavouriteCourse(
      id: json['_id'],
      courseId: json['entityInfo']['courseId'],
      sectionId: json['entityInfo']['sectionId'],
      termId: json['entityInfo']['termId'],
    );
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(FavouriteCourse model) {
    return id == model.id;
  }

  @override
  String toString() => '$courseId $sectionId $termId';
}
