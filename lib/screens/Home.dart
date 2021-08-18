import 'package:churchapp_flutter/providers/AppStateManager.dart';
import 'package:churchapp_flutter/screens/GiveNowScreen.dart';
import 'package:churchapp_flutter/screens/GiveTestimonyScreen.dart';
import 'package:churchapp_flutter/screens/PrayerRequestScreen.dart';
import 'package:churchapp_flutter/screens/WorshipGuideScreen.dart';
import '../screens/BibleScreen.dart';
import '../providers/AudioPlayerModel.dart';
import '../audio_player/miniPlayer.dart';
import '../models/ScreenArguements.dart';
import '../models/Userdata.dart';
import '../screens/BranchesScreen.dart';
import '../livetvplayer/LivestreamsPlayer.dart';
import '../screens/EventsListScreen.dart';
import '../screens/InboxListScreen.dart';
import '../screens/HymnsListScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../screens/CategoriesScreen.dart';
import '../screens/DevotionalScreen.dart';
import '../screens/VideoScreen.dart';
import '../screens/AudioScreen.dart';
import '../notes/NotesListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../providers/HomeProvider.dart';
import '../utils/img.dart';
import '../models/Media.dart';
import '../models/Radios.dart';
import '../i18n/strings.g.dart';
import '../utils/TextStyles.dart';
import '../screens/HomeSlider.dart';
import '../screens/NoitemScreen.dart';
import '../utils/ApiUrl.dart';
import 'package:shimmer/shimmer.dart';

enum HomeIndex { CATEGORIES, VIDEOS, AUDIOS, BIBLEBOOKS, LIVESTREAMS, RADIO }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.userdata}) : super(key: key);
  final Userdata userdata;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              child: HomePageBody(
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

class HomePageBody extends StatelessWidget {
  const HomePageBody({
    Key key,
    @required this.homeProvider,
  }) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: true,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 12,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (homeProvider.isError) {
      return NoitemScreen(
          title: t.oops, message: t.dataloaderror, onClick: onRetryClick);
    } else
      return SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                child: Text(
                  "Explore",
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "serif",
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Container(
              height: 280,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                      child: Container(
                        //width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: double.infinity,
                              padding: EdgeInsets.all(3),
                              //margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/pexels6.jpg",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  //color: Colors.black26,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                //color: Colors.black54,
                                margin: EdgeInsets.only(bottom: 12),
                                height: 50,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                //color: Colors.black54,
                                margin: EdgeInsets.only(bottom: 20),
                                height: 35,
                                alignment: Alignment.center,
                                child: Text(
                                  "Sermon",
                                  style: TextStyles.caption(context).copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontFamily: "serif",
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(0, 1),
                                            blurRadius: 5),
                                      ]),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(VideoScreen.routeName);
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Container(
                              //width: MediaQuery.of(context).size.width,

                              padding: EdgeInsets.all(4),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: double.infinity,
                                    //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "assets/images/pexels4.jpg",
                                        fit: BoxFit.cover,
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
                                      margin: EdgeInsets.only(bottom: 12),
                                      height: 35,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Events",
                                        style: TextStyles.caption(context)
                                            .copyWith(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                fontFamily: "serif",
                                                shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  offset: Offset(0, 1),
                                                  blurRadius: 5),
                                            ]),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(EventsListScreen.routeName);
                            },
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Container(
                              //width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(4),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: double.infinity,
                                    //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "assets/images/pexels3.jpg",
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
                                      margin: EdgeInsets.only(bottom: 12),
                                      height: 35,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Share Testimony",
                                        style: TextStyles.caption(context)
                                            .copyWith(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                fontFamily: "serif",
                                                shadows: [
                                              Shadow(
                                                  color: Colors.black
                                                      .withOpacity(1.0),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 5),
                                            ]),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(GiveTestimonyScreen.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 10, 10),
                child: Text(
                  "Hand Picked For You",
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "serif",
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  children: [
                    ItemTile(
                      index: HomeIndex.CATEGORIES,
                      homeProvider: homeProvider,
                      title: "Bible",
                      thumbnail: "",
                      useAssetsImage: true,
                      assetsImage: "assets/images/Bible-4.jpg",
                      callback: () {
                        Navigator.of(context).pushNamed(BibleScreen.routeName);
                      },
                    ),
                    // ItemTile(
                    //   index: HomeIndex.CATEGORIES,
                    //   homeProvider: homeProvider,
                    //   title: "Give Now",
                    //   thumbnail: "",
                    //   useAssetsImage: true,
                    //   assetsImage: "assets/images/donate.jpeg",
                    //   callback: () {
                    //     Navigator.of(context).pushNamed(GiveNowScreen.routeName);
                    //   },
                    // ),
                    ItemTile(
                      index: HomeIndex.CATEGORIES,
                      homeProvider: homeProvider,
                      title: "Devotionals",
                      thumbnail: "",
                      useAssetsImage: true,
                      assetsImage: "assets/images/devotionals.jpeg",
                      callback: () {
                        Navigator.of(context)
                            .pushNamed(DevotionalScreen.routeName);
                      },
                    ),
                    ItemTile(
                      index: HomeIndex.CATEGORIES,
                      homeProvider: homeProvider,
                      title: "LiveStream",
                      thumbnail: "",
                      useAssetsImage: true,
                      assetsImage: "assets/images/pexels7.jpg",
                      callback: () {
                        Navigator.of(context)
                            .pushNamed(LivestreamsPlayer.routeName,
                                arguments: ScreenArguements(
                                  position: 0,
                                  items: homeProvider.data['livestream'],
                                  itemsList: [],
                                ));
                      },
                    ),
                    ItemTile(
                      index: HomeIndex.CATEGORIES,
                      homeProvider: homeProvider,
                      title: "Prayer Request",
                      thumbnail: "",
                      useAssetsImage: true,
                      assetsImage: "assets/images/pexels1.jpg",
                      callback: () {
                        Navigator.of(context)
                            .pushNamed(PrayerRequestScreen.routeName);
                      },
                    ),
                    ItemTile(
                      index: HomeIndex.CATEGORIES,
                      homeProvider: homeProvider,
                      title: "Location",
                      thumbnail: "",
                      useAssetsImage: true,
                      assetsImage: "assets/images/pexels2.jpg",
                      callback: () {
                        Navigator.of(context)
                            .pushNamed(BranchesScreen.routeName);
                      },
                    ),
                    ItemTile(
                      index: HomeIndex.CATEGORIES,
                      homeProvider: homeProvider,
                      title: "Worship Guide",
                      thumbnail: "",
                      useAssetsImage: true,
                      assetsImage: "assets/images/pexels5.jpg",
                      callback: () {
                        Navigator.of(context)
                            .pushNamed(WorshipGuideScreen.routeName);
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                child: Text(
                  t.suggestedforyou,
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "serif",
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            HomeSlider(homeProvider.data['sliders']),
          ],
        ),
      );
  }
}

class ItemTile extends StatelessWidget {
  final String title;
  final String thumbnail;
  final bool useAssetsImage;
  final String assetsImage;
  final HomeIndex index;
  final HomeProvider homeProvider;
  final Function callback;

  const ItemTile(
      {Key key,
      @required this.index,
      @required this.title,
      @required this.thumbnail,
      @required this.homeProvider,
      @required this.useAssetsImage,
      @required this.callback,
      @required this.assetsImage})
      : assert(title != null),
        assert(thumbnail != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      width: 170,
      padding: const EdgeInsets.only(right: 3.0, left: 3.00),
      child: InkWell(
        child: Container(
          width: 170,
          child: Column(
            children: <Widget>[
              Container(
                height: 124,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 5.0,
                      spreadRadius: -2.0,
                      offset:
                          Offset(6.0, 6.0), // shadow direction: bottom right
                    )
                  ],
                ),
                //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    color: Colors.black26,
                    colorBlendMode: BlendMode.darken,
                    imageUrl: thumbnail,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CupertinoActivityIndicator()),
                    errorWidget: (context, url, error) => Center(
                        child: Image.asset(
                      assetsImage,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black26,
                        colorBlendMode: BlendMode.darken,
                      //color: Colors.black26,
                    )),
                  ),
                ),
              ),
              SizedBox(height: 0.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //color: Colors.black54,
                  height: 35,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyles.body2(context).copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      //color: Colors.white,
                      fontFamily: "serif",
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
          callback();
        },
      ),
    );
  }
}
