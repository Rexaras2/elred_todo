class Task {
  String id;
  String name;
  String description;
  DateTime date;

  Task(this.id, this.name, this.description, this.date);

  static Task fromMap(Map<String, dynamic> map, String id) {
    String name = map['name'];
    String description = map['description'];
    DateTime date = map['date'].toDate();

    return Task(id, name, description, date);
  }
}
