class NotificationHistory {
  final int id;
  final String user;
  final int mood;
  final String date;

  NotificationHistory({this.id, this.user, this.mood, this.date});

  factory NotificationHistory.fromJson(Map<String, dynamic> json) {
    return NotificationHistory(
        id: json['id'],
        user: json['user'],
        mood: json['mood'],
        date: json['date']);
  }
}
