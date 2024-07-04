class FavouriteEvent {
  String id;
  String eventId;

  FavouriteEvent({required this.id, required this.eventId});

  factory FavouriteEvent.fromJson(Map<String, dynamic> json) {
    return FavouriteEvent(
      id: json['_id'],
      eventId: json['eventId'],
    );
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(FavouriteEvent model) {
    return id == model.id;
  }

  @override
  String toString() => eventId;
}
