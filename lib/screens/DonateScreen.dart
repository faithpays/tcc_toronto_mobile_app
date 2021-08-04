import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import '../models/Userdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/TextStyles.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({Key key, this.userdata}) : super(key: key);
  final Userdata userdata;

  @override
  _DonateScreenState createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 420,
              //padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/images/donate.jpeg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  //color: Colors.black26,
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                  child: Text(
                    "Make donations, give tithes and offerings",
                    style: TextStyles.headline(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              child: TextButton(
                child: Text(
                  "Give Now",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20)),
                ),
                onPressed: () {
                  openBrowserTab("https://donation.faithpays.org/demo/");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
