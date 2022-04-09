import 'package:churchapp_flutter/models/LiveStreams.dart';
import 'package:churchapp_flutter/providers/AppStateManager.dart';
import 'package:churchapp_flutter/screens/GiveTestimonyScreen.dart';
import 'package:churchapp_flutter/screens/PrayerRequestScreen.dart';
import 'package:churchapp_flutter/screens/WorshipGuideScreen.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import '../screens/BibleScreen.dart';
import '../audio_player/miniPlayer.dart';
import '../models/ScreenArguements.dart';
import '../models/Userdata.dart';
import '../screens/BranchesScreen.dart';
import '../livetvplayer/LivestreamsPlayer.dart';
import '../screens/EventsListScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import '../screens/DevotionalScreen.dart';
import '../screens/VideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../providers/HomeProvider.dart';
import '../i18n/strings.g.dart';
import '../screens/NoitemScreen.dart';
import 'HomePage.dart';
import 'LiveStreamPage.dart';
import 'NoStreamingScreen.dart';
import 'SearchScreen.dart';

enum HomeIndex { CATEGORIES, VIDEOS, AUDIOS, BIBLEBOOKS, LIVESTREAMS, RADIO }

class HomeNewPage extends StatefulWidget {
  const HomeNewPage({Key key, this.userdata}) : super(key: key);
  final Userdata userdata;

  @override
  _HomeNewPageState createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage> {
  HomeProvider homeProvider;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).loadItems();
    super.initState();
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Home',
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

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      drawer: DrawerWidget(scaffoldKey: scaffoldKey),
      appBar: appBarWidget(context),
      // backgroundColor: MyColors.primary,
      body: Container(
        // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Appbar(),
            Expanded(
              child: NewHomee(
                homeProvider: homeProvider,
                key: UniqueKey(),
              ),
            ),

            MiniPlayer(),
          ],
        ),
      ),
    );
  }
}

class NewHomee extends StatelessWidget {
  const NewHomee({Key key, this.homeProvider}) : super(key: key);
  final HomeProvider homeProvider;
  onRetryClick() {
    homeProvider.loadItems();
  }

  openBrowserTab(String url) async {
    await FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        toolbarColor: MyColors.primary,
        secondaryToolbarColor: MyColors.primary,
        navigationBarColor: MyColors.primary,
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: MyColors.primary,
        preferredControlTintColor: MyColors.primary,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppStateManager>(context);
    if (homeProvider.isLoading) {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                // isPurplishMode: true,

                // Shimmer.fromColors(
                //   baseColor: Colors.grey[300],
                //   highlightColor: Colors.grey[100],
                //   enabled: true,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VideoShimmer(
                            //bgColor: Colors.pink,

                            // height: 20,
                            ),
                      ],
                    ),
                  ),
                  itemCount: 12,
                ),
              ),
            ],
          ));
    } else if (homeProvider.isError) {
      return NoitemScreen(
          title: t.oops, message: t.dataloaderror, onClick: onRetryClick);
    } else
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.black),
        child: ListView(
          scrollDirection: Axis.vertical,
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 0,
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/ministrybg.jpg"))),
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Text(
                "${t.appname}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                    fontSize: 28),
              )),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Explore",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "serif",
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExploreeCard(
                        title: "Sermons",
                        image: "messages.jpg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(VideoScreen.routeName);
                        }),
                    ExploreeCard(
                      title: "Share A Testimony",
                      image: "lifegroups.jpg",
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(GiveTestimonyScreen.routeName);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Hand Picked For You",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "serif",
                      fontSize: 24,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          // ExploreeCard(
                          // title: "Sermon",
                          // image: "messages.jpg",
                          // onTap: () {
                          //   Navigator.of(context)
                          //       .pushNamed(VideoScreen.routeName);
                          // }),
                          // ExploreeCard(
                          //   title: "Events",
                          //   image: "events.jpg",
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed(EventsListScreen.routeName);
                          //   },
                          // ),
                          // ExploreeCard(
                          //   title: "Share Testimony",
                          //   image: "lifegroups.jpg",
                          //   onTap: () {
                          //     Navigator.of(context)
                          //         .pushNamed(GiveTestimonyScreen.routeName);
                          //   },
                          // ),
                          ExploreeCard(
                            title: "Bible",
                            image: "Bible-4.jpg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(BibleScreen.routeName);
                            },
                          ),
                          ExploreeCard(
                            title: "Devotionals",
                            image: "devotionals.jpeg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(DevotionalScreen.routeName);
                            },
                          ),
                          ExploreeCard(
                            title: "LiveStream",
                            image: "pexels7.jpg",
                             onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LivestreamPage()),
                              );
                            // onTap: () {
                            //   LiveStreams livestreams = (homeProvider
                            //       .data["livestream"] as LiveStreams);

                            //   if (livestreams.status == 0) {
                            //     Navigator.of(context).pushNamed(
                            //         LivestreamsPlayer.routeName,
                            //         arguments: ScreenArguements(
                            //           position: 0,
                            //           items: homeProvider.data['livestream'],
                            //           itemsList: [],
                            //         ));
                            //   } else {
                            //     Navigator.of(context).pushNamed(
                            //         NoStreamingScreen.routeName,
                            //         arguments: livestreams.details);
                            //     // homeProvider.data["livestream"].toString());
                            //   }
                              // Navigator.of(context)
                              //     .pushNamed(LivestreamsPlayer.routeName,
                              //         arguments: ScreenArguements(
                              //           position: 0,
                              //           items: homeProvider.data['livestream'],
                              //           itemsList: [],
                              //         ));
                            },
                          ),
                          ExploreeCard(
                            title: "Prayer Request",
                            image: "pexels1.jpg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(PrayerRequestScreen.routeName);
                            },
                          ),
                          ExploreeCard(
                            title: "Location",
                            image: "pexels2.jpg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(BranchesScreen.routeName);
                            },
                          ),
                          ExploreeCard(
                            title: "Worship Guide",
                            image: "worship.jpg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(WorshipGuideScreen.routeName);
                            },
                          ),
                        ]),
                  ),
                )
              ],
            ),

            // Container(
            //     padding: EdgeInsets.only(top: 8, right: 10, left: 10),
            //     width: MediaQuery.of(context).size.height,
            //     height: 250,
            //     color: Colors.black,
            //     alignment: Alignment.center,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         ExploreeCard(
            //             title: "Sermon",
            //             image: "messages.jpg",
            //             onTap: () {
            //               Navigator.of(context)
            //                   .pushNamed(VideoScreen.routeName);
            //             }),
            //         ExploreeCard(
            //           title: "Events",
            //           image: "events.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(EventsListScreen.routeName);
            //           },
            //         ),
            //         ExploreeCard(
            //           title: "Share Testimony",
            //           image: "lifegroups.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(GiveTestimonyScreen.routeName);
            //           },
            //         ),
            //       ],
            //     )),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "Hand picked for you",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //       fontFamily: "serif",
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
            // Container(
            //     padding: EdgeInsets.only(top: 8, right: 10, left: 10),
            //     width: MediaQuery.of(context).size.height,
            //     height: 250,
            //     color: Colors.black87,
            //     alignment: Alignment.center,
            //     child: ListView(
            //       scrollDirection: Axis.horizontal,
            //       children: [
            //         ExploreeCard(
            //           title: "Bible",
            //           image: "Bible-4.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(BibleScreen.routeName);
            //           },
            //         ),
            //         ExploreeCard(
            //           title: "Devotionals",
            //           image: "devotionals.jpeg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(DevotionalScreen.routeName);
            //           },
            //         ),
            //         ExploreeCard(
            //           title: "LiveStream",
            //           image: "pexels7.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(LivestreamsPlayer.routeName,
            //                     arguments: ScreenArguements(
            //                       position: 0,
            //                       items: homeProvider.data['livestream'],
            //                       itemsList: [],
            //                     ));
            //           },
            //         ),
            //         ExploreeCard(
            //           title: "Prayer Request",
            //           image: "pexels1.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(PrayerRequestScreen.routeName);
            //           },
            //         ),
            //         ExploreeCard(
            //           title: "Location",
            //           image: "pexels2.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(BranchesScreen.routeName);
            //           },
            //         ),
            //         ExploreeCard(
            //           title: "Worship Guide",
            //           image: "worship.jpg",
            //           onTap: () {
            //             Navigator.of(context)
            //                 .pushNamed(WorshipGuideScreen.routeName);
            //           },
            //         ),
            //       ],
            //     )),
          ],
        ),
      );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({
    Key key,
    this.image,
    this.title,
    this.onTap,
  }) : super(key: key);
  final String image;
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                fit: BoxFit.cover,
                image: AssetImage("assets/images/${image}"))),
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Text(
          title,
          style: TextStyles.caption(context).copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //fontFamily: "serif",
          ),
        )),
      ),
    );
  }
}

class ExploreCard extends StatelessWidget {
  const ExploreCard({
    Key key,
    this.image,
    this.title,
    this.onTap,
  }) : super(key: key);
  final String image;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/images/${image}",
                fit: BoxFit.cover,
                height: 140,
                width: 170,

                //color: Colors.black26,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                title,
                style: TextStyles.caption(context).copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  //fontFamily: "serif",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreeCard extends StatelessWidget {
  const ExploreeCard({
    Key key,
    this.image,
    this.title,
    this.onTap,
  }) : super(key: key);
  final String image;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/${image}",
                  fit: BoxFit.cover,
                  height: 170,
                  width: 190,

                  //color: Colors.black26,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "serif",
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
