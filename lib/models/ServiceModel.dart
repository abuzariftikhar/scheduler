
class ServiceItem {
  String id;
  final String name;
  final int timeRequired;
  final String type;
  final String category;
  final List<String> imageURLs;
  final String cost;
  final String detailText;

  ServiceItem({
    this.id = "",
    required this.name,
    required this.type,
    required this.category,
    required this.cost,
    required this.timeRequired,
    required this.imageURLs,
    required this.detailText,
  });

  factory ServiceItem.fromMap(Map<String, dynamic> item) {
    return ServiceItem(
      id: item["id"],
      name: item["name"],
      type: item["type"],
      category: item["category"],
      cost: item["cost"],
      timeRequired: item["timeRequired"],
      imageURLs: item["imageURLs"].cast<String>(),
      detailText: item["detailText"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "category": category,
      "cost": cost,
      "timeRequired": timeRequired,
      "imageURLs": imageURLs,
      "detailText": detailText,
    };
  }
}
