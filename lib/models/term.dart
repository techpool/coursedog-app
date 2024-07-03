// {
//     "_id": "currentPlanningTerm",
//     "attribute": "currentPlanningTerm",
//     "id": "202408",
//     "semester": 8,
//     "termCode": "202408",
//     "year": "2025"
// }

class Term {
  int semester;
  String termCode;
  String year;
  String id;
  DateTime startDate;
  DateTime endDate;
  String displayName;

  Term(
      {required this.id,
      required this.semester,
      required this.termCode,
      required this.startDate,
      required this.endDate,
      required this.year,
      required this.displayName});

  factory Term.fromJson(Map<String, dynamic> json) {
    Term transformedTerm = Term(
      id: json['id'],
      semester: json['semester'],
      termCode: json['termCode'],
      year: json['year'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      displayName: json['displayName'],
    );

    return transformedTerm;
  }
}
