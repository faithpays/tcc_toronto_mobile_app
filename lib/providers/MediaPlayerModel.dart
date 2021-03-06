import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import '../utils/Utility.dart';
import '../models/Userdata.dart';
import '../utils/ApiUrl.dart';
import '../models/Media.dart';
import '../models/CommentsArguement.dart';
import '../comments/CommentsScreen.dart';

class MediaPlayerModel with ChangeNotifier {
  int commentsCount = 0;
  int likesCount = 0;
  bool isLiked = false;
  Media currentMedia;
  Userdata userdata;

  MediaPlayerModel(Userdata userdata, Media media) {
    this.userdata = userdata;
    if (media != null) {
      setMediaLikesCommentsCount(media);
    }
  }

  setMediaLikesCommentsCount(Media media) {
    currentMedia = media;
    print("currentmedia = " + currentMedia.id.toString());
    commentsCount = media.commentsCount;
    likesCount = media.likesCount;
    isLiked = media.userLiked == null ? false : media.userLiked;
    //notifyListeners();
    updateViewsCount();
    getMediaLikesCommentsCount();
  }

  Future<void> getMediaLikesCommentsCount() async {
    try {
      var data = {
        "media": currentMedia.id,
        "email": userdata == null ? "null" : userdata.email,
      };
      final response = await Utility.getDio().post(
        ApiUrl.getmediatotallikesandcommentsviews,
        data: jsonEncode({"data": data}),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        dynamic res = jsonDecode(response.data);
        commentsCount = int.parse(res['total_comments'].toString());
        likesCount = int.parse(res['total_likes'].toString());
        isLiked = res['isLiked'] == null ? false : res['isLiked'] as bool;
        notifyListeners();
      }
    } catch (exception) {
      print(exception);
    }
  }

  Future<void> updateViewsCount() async {
    var data = {"media": currentMedia.id};
    print(data.toString());

    try {
      final response = await Utility.getDio().post(
        ApiUrl.update_media_total_views,
        data: jsonEncode({"data": data}),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        dynamic res = jsonDecode(response.data);
      }
    } catch (exception) {
      print(exception);
    }
  }

  Future<void> likePost(String action) async {
    if (userdata == null) {
      return;
    }
    if (action == "like") {
      likesCount += 1;
      isLiked = true;
      notifyListeners();
    } else {
      likesCount -= 1;
      isLiked = false;
      notifyListeners();
    }
    var data = {
      "media": currentMedia.id,
      "email": userdata.email,
      "action": action
    };
    print(data.toString());

    try {
      final response = await Utility.getDio().post(
        ApiUrl.likeunlikemedia,
        data: jsonEncode({"data": data}),
      );

      if (response.statusCode == 200) {
        print(response);
      }
    } catch (exception) {
      print(exception);
    }
  }

  navigatetoCommentsScreen(BuildContext context) async {
    var count = await Navigator.pushNamed(
      context,
      CommentsScreen.routeName,
      arguments:
          CommentsArguement(item: currentMedia, commentCount: commentsCount),
    );
    commentsCount = count;
    notifyListeners();
  }
}
