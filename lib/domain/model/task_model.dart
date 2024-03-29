class Task {
  final String id;
  final String title;

  Task({required this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
