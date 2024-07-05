class Event {
  String id;
  String name;
  String? description;
  String type;
  DateTime? startDate;
  DateTime? endDate;
  int? startTime;
  int? endTime;

  Event(
      {required this.id,
      required this.name,
      required this.description,
      required this.type,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Event model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
