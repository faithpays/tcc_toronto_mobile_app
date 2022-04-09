class LiveStreams {
  final int id, status;
  final String title, description, streamUrl, type, details ;

  LiveStreams( 
      {this.id, this.status, this.title, this.type, this.description, this.streamUrl, this.details,});

  factory LiveStreams.fromJson(Map<String, dynamic> json) {
    //print(json);
    if (json == null) {
      return LiveStreams(
          id: 0,
          status: 1,
          title: "Not Available",
          type: "",
          description: "",
          streamUrl: "", 
          details: "<b>LiveStream is not available</b>");
    }
    int id = int.parse(json['id'].toString());
    int status = int.parse(json['status'].toString());
    return LiveStreams(
        id: id,
        status: status,
        title: json['title'] as String,
        type: json['type'] as String,
        description: json['description'] as String,
        streamUrl: json['stream_url'] as String,
        details: json['details'] as String);
  }
}
