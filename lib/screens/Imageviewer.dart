import 'package:churchapp_flutter/models/Photos.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../i18n/strings.g.dart';
import 'package:flutter/cupertino.dart';

class Imageviewer extends StatelessWidget {
  static const routeName = "/Imageviewer";
  const Imageviewer({Key key, this.photos}) : super(key: key);
  final Photos photos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(t.photoviewer),
        ),
        body: Container(
            child: PhotoView(imageProvider: NetworkImage(photos.thumbnail))));
  }
}
