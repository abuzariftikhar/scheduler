
class Timeline {
  String id;
  final DateTime date;
  final List<int> timelineSpan;

  Timeline({
    this.id = "",
    required this.date,
    required this.timelineSpan,
  });

  factory Timeline.fromMap(Map<String, dynamic> item) {
    return Timeline(
      id: item["id"],
      date: item["date"],
      timelineSpan: item["timelineSpan"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "timelineSpan": timelineSpan.cast<int>(),
    };
  }
}
