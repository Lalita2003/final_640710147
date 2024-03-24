class TodoItem {
  final int id;
  final String url;
  final String description;
  final String type;

  TodoItem({
    required this.id,
    required this.url,
    required this.description,
    required this.type,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: json['id'],
      url: json['url'],
      description: json['description'],
      type: json['type'],
    );
  }
}
