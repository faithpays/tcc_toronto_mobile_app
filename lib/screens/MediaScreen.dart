import 'package:churchapp_flutter/livetvplayer/LivestreamsPlayer.dart';
import 'package:churchapp_flutter/models/Connect.dart';
import 'package:churchapp_flutter/models/LiveStreams.dart';
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
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'LiveStreamPage.dart';
import 'NoStreamingScreen.dart';
import 'SearchScreen.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key key}) : super(key: key);

  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Connect> _conect = [
    Connect(title: "LiveStream", image: "assets/images/livestream.jpg"),
    Connect(title: "Sermons", image: "assets/images/sermon.jpg"),
    Connect(title: "Photos", image: "assets/images/photos.jpg"),
    Connect(title: "Audio", image: "assets/images/audios.jpg"),
    Connect(title: "Video", image: "assets/images/videos.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(scaffoldKey: scaffoldKey),
      appBar: appBarWidget(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Container(
          //color: Colors.black,
          child: GridView.builder(
            itemCount: _conect.length,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(3),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 12.0,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LivestreamPage()),
                      );
                      // Navigator.of(context)
                      //     .pushNamed(LivestreamsPlayer.routeName,
                      //         arguments: ScreenArguements(
                      //           position: 0,
                      //           items: Provider.of<HomeProvider>(context,
                      //                   listen: false)
                      //               .data['livestream'],
                      //           itemsList: [],
                      //         ));
                      // LiveStreams livestreams =
                      //     Provider.of<HomeProvider>(context, listen: false)
                      //         .data['livestream'] as LiveStreams;

                      // if (livestreams.status == 0) {
                      //   Navigator.of(context)
                      //       .pushNamed(LivestreamsPlayer.routeName,
                      //           arguments: ScreenArguements(
                      //             position: 0,
                      //             items: livestreams,
                      //             itemsList: [],
                      //           ));
                      // } else {
                      //   Navigator.of(context).pushNamed(
                      //       NoStreamingScreen.routeName,
                      //       arguments: livestreams.details);
                      //   // homeProvider.data["livestream"].toString());
                      // }

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
        ),
      ),
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Media',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      backgroundColor: MyColors.primary,

      actions: <Widget>[
        /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                child: Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Downloader.routeName,
                      arguments: ScreenArguements(
                        position: 0,
                        items: null,
                      ));
                },
              ),
            ),
          ),*/
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 5),
          child: IconButton(
              icon: Icon(Icons.search),
              onPressed: (() {
                Navigator.pushNamed(context, SearchScreen.routeName);
              })),
        )
      ],
      //tions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
    );
  }
}
