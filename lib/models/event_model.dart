class EventModel {
  String title;
  String description;
  String date;
  bool isFav;
  String? id;
  int categoryId;
  EventModel({
    required this.title,
    required this.date,
    required this.description,
    required this.isFav,
    this.id,
    required this.categoryId,
  });
  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'],
      date: json['date'],
      description: json['description'],
      isFav: json['isFav'],
      id: json['id'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'isFav': isFav,
      'id': id,
      'description': description,
      'categoryId': categoryId,
    };
  }
}
