class WorshipGuide {
  final String welcome, knowgod;
  final String media, upnext, facebook;
  final String youtube, twitter, instagram;

  WorshipGuide(
      {this.welcome,
      this.knowgod,
      this.media,
      this.upnext,
      this.facebook,
      this.youtube,
      this.twitter,
      this.instagram});

  factory WorshipGuide.fromJson(Map<String, dynamic> json) {
    return WorshipGuide(
      welcome: json['welcome'] as String,
      knowgod: json['knowgod'] as String,
      media: json['media'] as String,
      upnext: json['upnext'] as String,
      facebook: json['facebook_page'] as String,
      youtube: json['youtube_page'] as String,
      twitter: json['twitter_page'] as String,
      instagram: json['instagram_page'] as String,
    );
  }
}
