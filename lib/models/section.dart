class Section {
  String id;
  String sectionName;

  Section({required this.id, required this.sectionName});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['_id'],
      sectionName: json['sectionName'],
    );
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Section model) {
    return id == model.id;
  }

  @override
  String toString() => sectionName;
}
