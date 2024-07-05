class Meeting {
  String id;
  bool isAcademic;
  String? sectionId;
  String? courseId;
  String? year;
  int? semester;
  String? eventId;
  DateTime? startDate;
  DateTime? endDate;
  int? startTime;
  int? endTime;
  String? roomId;

  Meeting(
      {required this.id,
      required this.isAcademic,
      this.sectionId,
      this.courseId,
      this.year,
      this.semester,
      this.eventId,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.roomId});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['_id'],
      isAcademic: json['type'] == 'Academic',
      sectionId: json['eventData']['sectionInfo']?['sectionId'],
      courseId: json['eventData']['sectionInfo']?['courseId'],
      year: json['eventData']['sectionInfo']?['year'],
      semester: json['eventData']['sectionInfo']?['semester'],
      eventId: json['eventData']['_id'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      startTime: json['startTime'],
      endTime: json['endTime'],
      roomId: json['roomId'],
    );
  }

  String get startTimeIn12HrFormat {
    if (startTime == null) return '';

    String timePadded = startTime!.toString().padLeft(4, '0');
    String hour = timePadded.substring(0, 2);
    String minute = timePadded.substring(2);

    if (startTime! < 1200) {
      return '$hour:$minute AM';
    } else if (startTime! >= 1200 && startTime! < 1300) {
      return '$hour:$minute PM';
    } else {
      return '${(int.parse(hour) - 12)}:$minute PM';
    }
  }

  String get endTimeIn12HrFormat {
    if (endTime == null) return '';

    String timePadded = endTime!.toString().padLeft(4, '0');
    String hour = timePadded.substring(0, 2);
    String minute = timePadded.substring(2);

    if (endTime! < 1200) {
      return '$hour:$minute AM';
    } else if (endTime! >= 1200 && endTime! < 1300) {
      return '$hour:$minute PM';
    } else {
      return '${(int.parse(hour) - 12)}:$minute PM';
    }
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Meeting model) {
    return id == model.id;
  }

  @override
  String toString() => eventId ?? sectionId ?? courseId ?? id;
}
