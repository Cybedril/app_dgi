// models/notification_model.dart
class NotificationModel {
  final int id;
  final String title;
  final String date;
  final String body;
  final String? is_send;

  NotificationModel({
    required this.id,
    required this.title,
    required this.date,
    required this.body,
    required this.is_send,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      body: json['body'] ?? '',
      is_send: json['is_send'] ?? '',
    );
  }
}
