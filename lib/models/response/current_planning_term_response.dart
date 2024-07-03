class CurrentPlanningTermResponse {
  final String id;
  final int semester;
  final String termCode;
  final String year;

  const CurrentPlanningTermResponse(
      {required this.id,
      required this.semester,
      required this.termCode,
      required this.year});

  factory CurrentPlanningTermResponse.fromJson(Map<String, dynamic> json) {
    return CurrentPlanningTermResponse(
      id: json['id'],
      semester: json['semester'],
      termCode: json['termCode'],
      year: json['year'],
    );
  }
}
