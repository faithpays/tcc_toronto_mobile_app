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
import 'package:shimmer/shimmer.dart';

enum HomeIndex { CATEGORIES, VIDEOS, AUDIOS, BIBLEBOOKS, LIVESTREAMS, RADIO }

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key key, this.userdata}) : super(key: key);
  final Userdata userdata;

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  HomeProvider homeProvider;

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      // backgroundColor: MyColors.primary,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                        // Container(
                        //   width: 48.0,
                        //   height: 48.0,
                        //   color: Colors.white,
                        // ),
                        // const Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 8.0),
                        // ),
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       Container(
                        //         width: double.infinity,
                        //         height: 8.0,
                        //         color: Colors.white,
                        //       ),
                        //       const Padding(
                        //         padding: EdgeInsets.symmetric(vertical: 2.0),
                        //       ),
                        //       Container(
                        //         width: double.infinity,
                        //         height: 8.0,
                        //         color: Colors.white,
                        //       ),
                        //       const Padding(
                        //         padding: EdgeInsets.symmetric(vertical: 2.0),
                        //       ),
                        //       Container(
                        //         width: 40.0,
                        //         height: 8.0,
                        //         color: Colors.white,
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  itemCount: 12,
                ),
              ),
            
          ],
        )
      );
    } else if (homeProvider.isError) {
      return NoitemScreen(
          title: t.oops, message: t.dataloaderror, onClick: onRetryClick);
    } else
      return SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(color: MyColors.primary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "Explore",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "serif",
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 8, right: 10, left: 10, bottom: 10),
                      width: MediaQuery.of(context).size.height,
                      height: 190,
                      color: MyColors.primary,
                      alignment: Alignment.center,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ExploreCard(
                              title: "Sermon",
                              image: "messages.jpg",
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(VideoScreen.routeName);
                              }),
                          ExploreCard(
                            title: "Events",
                            image: "events.jpg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(EventsListScreen.routeName);
                            },
                          ),
                          ExploreCard(
                            title: "Share Testimony",
                            image: "lifegroups.jpg",
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(GiveTestimonyScreen.routeName);
                            },
                          ),
                          //
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 2.0,
                    left: 3.0,
                    top: 5.0,
                  ),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      HomeCard(
                        title: "Bible",
                        image: "Bible-4.jpg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(BibleScreen.routeName);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HomeCard(
                        title: "Devotionals",
                        image: "devotionals.jpeg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(DevotionalScreen.routeName);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HomeCard(
                        title: "LiveStream",
                        image: "pexels7.jpg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(LivestreamsPlayer.routeName,
                                  arguments: ScreenArguements(
                                    position: 0,
                                    items: homeProvider.data['livestream'],
                                    itemsList: [],
                                  ));
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HomeCard(
                        title: "Prayer Request",
                        image: "pexels1.jpg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(PrayerRequestScreen.routeName);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HomeCard(
                        title: "Location",
                        image: "pexels2.jpg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(BranchesScreen.routeName);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      HomeCard(
                        title: "Worship Guide",
                        image: "pexels1.jpg",
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(WorshipGuideScreen.routeName);
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
