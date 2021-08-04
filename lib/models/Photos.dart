class Photos {
  final int id;
  final String thumbnail;

  Photos({this.id, this.thumbnail, l});

  factory Photos.fromJson(Map<String, dynamic> json) {
    //print(json);
    int id = int.parse(json['id'].toString());
    return Photos(
      id: id,
      thumbnail: json['thumbnail'] as String,
    );
  }
}
