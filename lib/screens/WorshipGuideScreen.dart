import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/models/WorshipGuideItem.dart';
import 'package:churchapp_flutter/providers/WorshipGuideProvider.dart';
import 'package:churchapp_flutter/screens/BulletinScreen.dart';
import 'package:churchapp_flutter/screens/ConnectCardScreen.dart';
import 'package:churchapp_flutter/screens/HymnsListScreen.dart';
import 'package:churchapp_flutter/screens/WorshipGuideItemScreen.dart';
import 'package:churchapp_flutter/utils/Alerts.dart';
import 'package:churchapp_flutter/utils/img.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:provider/provider.dart';
import '../utils/TextStyles.dart';

class WorshipGuideScreen extends StatelessWidget {
  static const routeName = "/WorshipGuideScreen";
  WorshipGuideScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Worship Guide"),
      ),
      body: WorshipGuideScreenBody(),
    );
  }
}

class WorshipGuideScreenBody extends StatefulWidget {
  const WorshipGuideScreenBody({Key key}) : super(key: key);

  @override
  _WorshipGuideScreenBodyState createState() => _WorshipGuideScreenBodyState();
}

class _WorshipGuideScreenBodyState extends State<WorshipGuideScreenBody> {
  @override
  void initState() {
    super.initState();
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
        showTitle: false,
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                "assets/images/worshipguide.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                //color: Colors.black26,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            onTap: () {
              if (Provider.of<WorshipGuideProvider>(context, listen: false)
                      .worshipGuide ==
                  null) {
                Alerts.show(
                    context, "", "The item is not available at the moment");
                return;
              } else {
                WorshipGuideItem worshipGuideItem = WorshipGuideItem(
                    title: "Welcome",
                    content: Provider.of<WorshipGuideProvider>(context,
                            listen: false)
                        .worshipGuide
                        .welcome);
                Navigator.pushNamed(context, WorshipGuideItemScreen.routeName,
                    arguments: ScreenArguements(
                      position: 0,
                      items: worshipGuideItem,
                    ));
              }
            },
            leading: Icon(Icons.face),
            title: Text(
              "Welcome",
              style: TextStyles.headline(context).copyWith(
                fontWeight: FontWeight.bold,
                //fontFamily: "serif",
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              Icons.navigate_next,
              size: 28,
            ),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            onTap: () {
              Navigator.of(context).pushNamed(
                HymnsListScreen.routeName,
              );
            },
            leading: Icon(Icons.queue_music_sharp),
            title: Text(
              "Song Lyrics",
              style: TextStyles.headline(context).copyWith(
                fontWeight: FontWeight.bold,
                //fontFamily: "serif",
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              Icons.navigate_next,
              size: 28,
            ),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            onTap: () {
              Navigator.of(context).pushNamed(
                ConnectCardScreen.routeName,
              );
            },
            leading: Icon(Icons.recent_actors_rounded),
            title: Text(
              "Connection Card",
              style: TextStyles.headline(context).copyWith(
                fontWeight: FontWeight.bold,
                //fontFamily: "serif",
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              Icons.navigate_next,
              size: 28,
            ),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            onTap: () {
              if (Provider.of<WorshipGuideProvider>(context, listen: false)
                      .worshipGuide ==
                  null) {
                Alerts.show(
                    context, "", "The item is not available at the moment");
                return;
              } else {
                WorshipGuideItem worshipGuideItem = WorshipGuideItem(
                    title: "Know God",
                    content: Provider.of<WorshipGuideProvider>(context,
                            listen: false)
                        .worshipGuide
                        .knowgod);
                Navigator.pushNamed(context, WorshipGuideItemScreen.routeName,
                    arguments: ScreenArguements(
                      position: 0,
                      items: worshipGuideItem,
                    ));
              }
            },
            leading: Icon(Icons.baby_changing_station),
            title: Text(
              "Why We Exist",
              style: TextStyles.headline(context).copyWith(
                fontWeight: FontWeight.bold,
                //fontFamily: "serif",
                fontSize: 18,
              ),
            ),
            trailing: Icon(
              Icons.navigate_next,
              size: 28,
            ),
          ),
          Divider(),
          // ListTile(
          //   contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          //   onTap: () {
          //     if (Provider.of<WorshipGuideProvider>(context, listen: false)
          //             .worshipGuide ==
          //         null) {
          //       Alerts.show(
          //           context, "", "The item is not available at the moment");
          //       return;
          //     } else {
          //       WorshipGuideItem worshipGuideItem = WorshipGuideItem(
          //           title: "Media",
          //           content: Provider.of<WorshipGuideProvider>(context,
          //                   listen: false)
          //               .worshipGuide
          //               .media);
          //       Navigator.pushNamed(context, WorshipGuideItemScreen.routeName,
          //           arguments: ScreenArguements(
          //             position: 0,
          //             items: worshipGuideItem,
          //           ));
          //     }
          //   },
          //   leading: Icon(Icons.accessibility),
          //   title: Text(
          //     "Media",
          //     style: TextStyles.headline(context).copyWith(
          //       fontWeight: FontWeight.bold,
          //       //fontFamily: "serif",
          //       fontSize: 18,
          //     ),
          //   ),
          //   trailing: Icon(
          //     Icons.navigate_next,
          //     size: 28,
          //   ),
          // ),
          // Divider(),
          // ListTile(
          //   contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          //   onTap: () {
          //     if (Provider.of<WorshipGuideProvider>(context, listen: false)
          //             .worshipGuide ==
          //         null) {
          //       Alerts.show(
          //           context, "", "The item is not available at the moment");
          //       return;
          //     } else {
          //       WorshipGuideItem worshipGuideItem = WorshipGuideItem(
          //           title: "Up Next",
          //           content: Provider.of<WorshipGuideProvider>(context,
          //                   listen: false)
          //               .worshipGuide
          //               .upnext);
          //       Navigator.pushNamed(context, WorshipGuideItemScreen.routeName,
          //           arguments: ScreenArguements(
          //             position: 0,
          //             items: worshipGuideItem,
          //           ));
          //     }
          //   },
          //   leading: Icon(Icons.play_circle_fill),
          //   title: Text(
          //     "Up Next",
          //     style: TextStyles.headline(context).copyWith(
          //       fontWeight: FontWeight.bold,
          //       //fontFamily: "serif",
          //       fontSize: 18,
          //     ),
          //   ),
          //   trailing: Icon(
          //     Icons.navigate_next,
          //     size: 28,
          //   ),
          // ),
          Divider(),
          Container(height: 20),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              child: Text(
                "Follow us on",
                style: TextStyles.headline(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "serif",
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    if (Provider.of<WorshipGuideProvider>(context,
                                listen: false)
                            .worshipGuide ==
                        null) {
                      Alerts.show(context, "",
                          "The item is not available at the moment");
                      return;
                    } else {
                      openBrowserTab(Provider.of<WorshipGuideProvider>(context,
                              listen: false)
                          .worshipGuide
                          .facebook);
                    }
                  },
                  child: Container(
                    child: Image.asset(Img.get('img_social_facebook.png')),
                    width: 40,
                    height: 40,
                  ),
                ),
                // Container(width: 10),
                // InkWell(
                //   onTap: () {
                //     if (Provider.of<WorshipGuideProvider>(context,
                //                 listen: false)
                //             .worshipGuide ==
                //         null) {
                //       Alerts.show(context, "",
                //           "The item is not available at the moment");
                //       return;
                //     } else {
                //       openBrowserTab(Provider.of<WorshipGuideProvider>(context,
                //               listen: false)
                //           .worshipGuide
                //           .youtube);
                //     }
                //   },
                //   child: Container(
                //     child: Image.asset(Img.get('img_social_youtube.png')),
                //     width: 40,
                //     height: 40,
                //   ),
                // ),
                // Container(width: 10),
                // InkWell(
                //   onTap: () {
                //     if (Provider.of<WorshipGuideProvider>(context,
                //                 listen: false)
                //             .worshipGuide ==
                //         null) {
                //       Alerts.show(context, "",
                //           "The item is not available at the moment");
                //       return;
                //     } else {
                //       openBrowserTab(Provider.of<WorshipGuideProvider>(context,
                //               listen: false)
                //           .worshipGuide
                //           .twitter);
                //     }
                //   },
                //   child: Container(
                //     child: Image.asset(Img.get('img_social_twitter.png')),
                //     width: 40,
                //     height: 40,
                //   ),
                // ),
                // Container(width: 10),
                // InkWell(
                //   onTap: () {
                //     if (Provider.of<WorshipGuideProvider>(context,
                //                 listen: false)
                //             .worshipGuide ==
                //         null) {
                //       Alerts.show(context, "",
                //           "The item is not available at the moment");
                //       return;
                //     } else {
                //       openBrowserTab(Provider.of<WorshipGuideProvider>(context,
                //               listen: false)
                //           .worshipGuide
                //           .instagram);
                //     }
                //   },
                //   child: Container(
                //     child: Image.asset(Img.get('img_social_instagram.png')),
                //     width: 40,
                //     height: 40,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
