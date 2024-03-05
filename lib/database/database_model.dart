class DatabaseModel {
  int? id;
  String? title;

  DatabaseModel({
    this.id,
    this.title,
  });
  factory DatabaseModel.fromMap(Map<String, dynamic> data) => DatabaseModel(
        id: data["id"],
        title: data["title"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
      };
}
