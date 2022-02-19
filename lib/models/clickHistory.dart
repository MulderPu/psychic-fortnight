class ClickHistory {
  String? title;
  String? datetime;

  ClickHistory();

  ClickHistory.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        datetime = json['datetime'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'datetime': datetime,
      };
}
