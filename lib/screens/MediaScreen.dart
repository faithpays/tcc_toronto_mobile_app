import 'package:churchapp_flutter/livetvplayer/LivestreamsPlayer.dart';
import 'package:churchapp_flutter/models/Connect.dart';
import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/providers/HomeProvider.dart';
import 'package:churchapp_flutter/screens/AudioScreen.dart';
import 'package:churchapp_flutter/screens/BranchesScreen.dart';
import 'package:churchapp_flutter/screens/GiveTestimonyScreen.dart';
import 'package:churchapp_flutter/screens/LifeGroupScreen.dart';
import 'package:churchapp_flutter/screens/MinistriesScreen.dart';
import 'package:churchapp_flutter/screens/PhotosScreen.dart';
import 'package:churchapp_flutter/screens/PrayerRequestScreen.dart';
import 'package:churchapp_flutter/screens/SermonsScreen.dart';
import 'package:churchapp_flutter/screens/VideoScreen.dart';
import 'package:churchapp_flutter/screens/WorshipGuideScreen.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key key}) : super(key: key);

  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  List<Connect> _conect = [
    Connect(title: "LiveStream", image: "assets/images/livestream.jpg"),
    Connect(title: "Sermon", image: "assets/images/sermon.jpg"),
    Connect(title: "Photos", image: "assets/images/photos.jpg"),
    Connect(title: "Audio", image: "assets/images/audios.jpg"),
    Connect(title: "Video", image: "assets/images/videos.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        itemCount: _conect.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(3),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 2.0,
            childAspectRatio: 2.5),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              //width: MediaQuery.of(context).size.width,

              padding: EdgeInsets.all(0),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        _conect[index].image,
                        fit: BoxFit.cover,
                        color: Colors.black26,
                        colorBlendMode: BlendMode.darken,
                        width: double.infinity,
                        height: double.infinity,
                        //color: Colors.black26,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      //color: Colors.black54,
                      margin: EdgeInsets.only(bottom: 50),
                      height: 35,
                      alignment: Alignment.center,
                      child: Text(
                        _conect[index].title,
                        style: TextStyles.caption(context).copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          //fontFamily: "serif",
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              switch (index) {
                case 0:
                  Navigator.of(context).pushNamed(LivestreamsPlayer.routeName,
                      arguments: ScreenArguements(
                        position: 0,
                        items: Provider.of<HomeProvider>(context, listen: false)
                            .data['livestream'],
                        itemsList: [],
                      ));

                  break;
                case 2:
                  Navigator.of(context).pushNamed(PhotosScreen.routeName);
                  break;
                case 1:
                  Navigator.of(context).pushNamed(SermonsScreen.routeName);
                  break;
                case 3:
                  Navigator.of(context).pushNamed(AudioScreen.routeName);
                  break;
                case 4:
                  Navigator.of(context).pushNamed(VideoScreen.routeName);
                  break;
                case 5:
                  Navigator.of(context)
                      .pushNamed(GiveTestimonyScreen.routeName);
                  break;
              }
            },
          );
        },
      ),
    );
  }
}
