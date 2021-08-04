class Events {
  final int id, day, month, year;
  final String title, thumbnail, location, enquiry;
  final String details, time, date;

  Events({
    this.id,
    this.title,
    this.thumbnail,
    this.details,
    this.time,
    this.day,
    this.month,
    this.year,
    this.date,
    this.location,
    this.enquiry,
  });

  factory Events.fromJson(Map<String, dynamic> json) {
    //print(json);
    int id = int.parse(json['id'].toString());
    return Events(
      id: id,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      details: json['details'] as String,
      time: json['time'] as String,
      date: json['date'] as String,
      day: int.parse(json['day'].toString()),
      month: int.parse(json['month'].toString()),
      year: int.parse(json['year'].toString()),
      location: json['location'] as String,
      enquiry: json['enquiry'] as String,
    );
  }
}
