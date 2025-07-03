class EventModel {
  final num? id;
  final String? title;
  final String? type;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;

  EventModel({
    this.id,
    this.title,
    this.type,
    this.description,
    this.startDate,
    this.endDate,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      description: json['description'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'description': description,
      'start_date': startDate?.toUtc().toIso8601String(),
      'end_date': endDate?.toUtc().toIso8601String(),
    };
  }
}
