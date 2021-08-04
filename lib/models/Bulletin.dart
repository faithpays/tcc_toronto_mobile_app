class Bulletin {
  final int id;
  final String title, content;

  Bulletin({
    this.id,
    this.title,
    this.content,
  });

  factory Bulletin.fromJson(Map<String, dynamic> json) {
    //print(json);
    int id = int.parse(json['id'].toString());
    return Bulletin(
      id: id,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
