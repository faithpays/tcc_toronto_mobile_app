class Groups {
  final int id;
  final String name, leader, phone, thumbnail, location;
  final String description, time, email;

  Groups(
      {this.id,
      this.name,
      this.leader,
      this.phone,
      this.thumbnail,
      this.location,
      this.description,
      this.time,
      this.email});

  factory Groups.fromJson(Map<String, dynamic> json) {
    //print(json);
    int id = int.parse(json['id'].toString());
    return Groups(
      id: id,
      name: json['name'] as String,
      leader: json['leader'] as String,
      phone: json['phone'] as String,
      thumbnail: json['thumbnail'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      email: json['email'] as String,
    );
  }
}
