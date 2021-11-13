import 'package:churchapp_flutter/providers/AppStateManager.dart';
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
      backgroundColor: MyColors.primary,
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
    List<String> items = [
      "Bulletins",
      "Social Media",
      "Notes",
      "Ministries",
      "Connect Card",
      "Worship Guide",
      "About Us"
    ];
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
            Container(height: 20),
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
            Container(
              child: Container(
                height: 570,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 10, 10),
                        child: Text(
                          "Explore",
                          style: TextStyles.headline(context).copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: "serif",
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ItemTile(
                              index: HomeIndex.CATEGORIES,
                              homeProvider: homeProvider,
                              title: "Sermon",
                              thumbnail: "",
                              useAssetsImage: true,
                              assetsImage: "assets/images/messages.jpg",
                            ),
                          ),
                          Expanded(
                            child: ItemTile(
                              index: HomeIndex.VIDEOS,
                              homeProvider: homeProvider,
                              title: "Videos",
                              thumbnail: homeProvider.data['image2'],
                              useAssetsImage: homeProvider.data['image2'] == "",
                              assetsImage: "assets/images/messages.jpg",
                            ),
                          ),
                          Expanded(
                            child: ItemTile(
                              index: HomeIndex.AUDIOS,
                              homeProvider: homeProvider,
                              title: "Podcast",
                              thumbnail: homeProvider.data['image2'],
                              useAssetsImage: homeProvider.data['image2'] == "",
                              assetsImage: "assets/images/sermons.jpg",
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconItems(
                                  title: "Livestream",
                                  assetsImage: "assets/images/livestream.png",
                                  callback: () {
                                    openBrowserTab(
                                        homeProvider.data['website']);
                                  }),
                              IconItems(
                                  title: "Prayer Request",
                                  assetsImage: "assets/images/prayer.png",
                                  callback: () {
                                    Navigator.of(context)
                                        .pushNamed(BranchesScreen.routeName);
                                  }),
                              IconItems(
                                  title: "Bible",
                                  assetsImage: "assets/images/bible.png",
                                  callback: () {
                                    Navigator.of(context)
                                        .pushNamed(HymnsListScreen.routeName);
                                  }),
                              IconItems(
                                  title: "Give",
                                  assetsImage: "assets/images/give.png",
                                  callback: () {
                                    Navigator.of(context)
                                        .pushNamed(BranchesScreen.routeName);
                                  }),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Divider(height: 15),
                          Container(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconItems(
                                  title: "Location",
                                  assetsImage: "assets/images/location.png",
                                  callback: () {}),
                              IconItems(
                                  title: "Events",
                                  assetsImage: "assets/images/events.png",
                                  callback: () {}),
                              IconItems(
                                  title: "Service Time",
                                  assetsImage: "assets/images/service.png",
                                  callback: () {}),
                              IconItems(
                                  title: "Media",
                                  assetsImage: "assets/images/media.png",
                                  callback: () {}),
                            ],
                          ),
                          Container(height: 25),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[200],
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
                          child: Text(
                            "Everything you need to know about us",
                            style: TextStyles.headline(context).copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "serif",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.only(top: 10.0, left: 10.0),
                        height: 45.0,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: InkWell(
                                child: Container(
                                    height: 30.0,
                                    //width: 100.0,
                                    margin: EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 3,
                                        )
                                      ],
                                    ),
                                    child: Center(child: Text(items[index]))),
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class IconItems extends StatelessWidget {
  final String title;
  final String assetsImage;
  final Function callback;

  const IconItems({
    Key key,
    @required this.title,
    @required this.assetsImage,
    @required this.callback,
  }) : super(key: key);

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
    return Column(
      children: <Widget>[
        Image.asset(
          assetsImage,
          fit: BoxFit.fill,
          width: 30,
          height: 30,
          //color: Colors.black26,
        ),
        Container(height: 5),
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: TextStyles.caption(context).copyWith(fontSize: 13),
            textAlign: TextAlign.center,
          ),
        )
      ],
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

  const ItemTile(
      {Key key,
      @required this.index,
      @required this.title,
      @required this.thumbnail,
      @required this.homeProvider,
      @required this.useAssetsImage,
      @required this.assetsImage})
      : assert(title != null),
        assert(thumbnail != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3.0, left: 3.00),
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: thumbnail,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black12, BlendMode.darken)),
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
                    style: TextStyles.caption(context).copyWith(
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
          switch (index) {
            case HomeIndex.CATEGORIES:
              Navigator.of(context).pushNamed(CategoriesScreen.routeName);
              break;
            case HomeIndex.VIDEOS:
              Navigator.of(context).pushNamed(VideoScreen.routeName);
              break;
            case HomeIndex.AUDIOS:
              Navigator.of(context).pushNamed(AudioScreen.routeName);
              break;
            case HomeIndex.BIBLEBOOKS:
              Navigator.of(context).pushNamed(BibleScreen.routeName);
              break;
            case HomeIndex.LIVESTREAMS:
              Navigator.of(context).pushNamed(LivestreamsPlayer.routeName,
                  arguments: ScreenArguements(
                    position: 0,
                    items: homeProvider.data['livestream'],
                    itemsList: [],
                  ));
              break;
            case HomeIndex.RADIO:
              Radios radios = homeProvider.data['radios'];
              Media media = new Media(
                  id: radios.id,
                  title: radios.title,
                  coverPhoto: radios.coverPhoto,
                  streamUrl: radios.streamUrl);
              Provider.of<AudioPlayerModel>(context, listen: false)
                  .prepareradioplayer(media);
              //Navigator.of(context).pushNamed(RadioPlayer.routeName);
              break;
          }
        },
      ),
    );
  }
}
