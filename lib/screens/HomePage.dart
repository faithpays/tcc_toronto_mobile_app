import 'package:churchapp_flutter/providers/EventsModel.dart';
import 'package:churchapp_flutter/providers/WorshipGuideProvider.dart';
import 'package:churchapp_flutter/screens/MediaScreen.dart';
import 'package:churchapp_flutter/screens/ConnectScreen.dart';
import 'package:churchapp_flutter/screens/DonateScreen.dart';
import 'package:churchapp_flutter/screens/EventsScreen.dart';
import 'package:churchapp_flutter/utils/img.dart';
import 'package:flutter/material.dart';
import '../providers/HomeProvider.dart';
import '../screens/DrawerScreen.dart';
import '../screens/SearchScreen.dart';
import '../models/ScreenArguements.dart';
import '../screens/Downloader.dart';
import 'GiveNowScreen.dart';
import 'Home.dart';
import '../utils/my_colors.dart';
import 'package:provider/provider.dart';
import '../i18n/strings.g.dart';
import '../providers/AudioPlayerModel.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  static const routeName = "/homescreen";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePageItem();
  }
}

class HomePageItem extends StatefulWidget {
  HomePageItem({
    Key key,
  }) : super(key: key);

  @override
  _HomePageItemState createState() => _HomePageItemState();
}

class _HomePageItemState extends State<HomePageItem> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        title: Text("Home")),
    BottomNavigationBarItem(
        icon: Icon(Icons.video_camera_back_outlined), title: Text("Media")),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), title: Text("Give")),
    BottomNavigationBarItem(
        icon: Icon(Icons.connect_without_contact), title: Text("Connect")),
    BottomNavigationBarItem(
        icon: Icon(Icons.event_available_outlined), title: Text("Events"))
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<WorshipGuideProvider>(context, listen: false)
          .setContext(context);
      Provider.of<WorshipGuideProvider>(context, listen: false)
          .getWorshipGuide();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Provider.of<AudioPlayerModel>(context, listen: false)
                .currentMedia !=
            null) {
          return (await showDialog(
                context: context,
                builder: (context) => new CupertinoAlertDialog(
                  title: new Text(t.quitapp),
                  content: new Text(t.quitappaudiowarning),
                  actions: <Widget>[
                    new TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text(t.cancel),
                    ),
                    new TextButton(
                      onPressed: () {
                        Provider.of<AudioPlayerModel>(context, listen: false)
                            .cleanUpResources();
                        Navigator.of(context).pop(true);
                      },
                      child: new Text(t.ok),
                    ),
                  ],
                ),
              )) ??
              false;
        } else {
          return (await showDialog(
                context: context,
                builder: (context) => new CupertinoAlertDialog(
                  title: new Text(t.quitapp),
                  content: new Text(t.quitappwarning),
                  actions: <Widget>[
                    new TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: new Text(t.cancel),
                    ),
                    new TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: new Text(t.ok),
                    ),
                  ],
                ),
              )) ??
              false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 100.0,
          title:

              //Text("TCC TORONTO", style: TextStyle(fontWeight: FontWeight.bold),),

              Padding(
                padding: const EdgeInsets.only(left: 68.0),
                child: Center(
                  child: new Image(
                      image: new ExactAssetImage(Img.get("TCC-whitetxt-Logo.png")),
                      height: 80.0,
                      width: 200.0,
                      alignment: FractionalOffset.center),
                ),
              ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(90.0),
              bottomRight: Radius.circular(90.0),
            ),
          ),
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
              padding: const EdgeInsets.only(right: 35.0, top: 15),
              child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (() {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  })),
            )
          ],
        ),
        body: buildPageBody(currentIndex),
        // drawer: Container(
        //   color: MyColors.grey_95,
        //   width: 300,
        //   child: Drawer(
        //     key: scaffoldKey,
        //     child: DrawerScreen(),
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blueGrey[900],
          selectedItemColor: MyColors.white,
          unselectedItemColor: MyColors.grey_40,
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: navigationItems.toList(),
        ),
      ),
    );
  }

  Widget buildPageBody(int currentIndex) {
    if (currentIndex == 0) {
      return MyHomePage();
      /*ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        child: MyHomePage(),
      );*/
    }

    if (currentIndex == 1) {
      return MediaScreen();
    }

    if (currentIndex == 2) {
      return GiveNowScreen();
    }

    if (currentIndex == 3) {
      return ConnectScreen();
    }
    if (currentIndex == 4) {
      return ChangeNotifierProvider(
        create: (context) => EventsModel(),
        child: EventsScreen(),
      );
    }

    return Container();
  }
}
