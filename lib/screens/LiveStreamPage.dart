import 'dart:convert';

import 'package:churchapp_flutter/i18n/strings.g.dart';
import 'package:churchapp_flutter/models/LiveStreams.dart';
import 'package:churchapp_flutter/utils/ApiUrl.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';



class LivestreamPage extends StatefulWidget {
  const LivestreamPage({Key key}) : super(key: key);

  @override
  _LivestreamPageState createState() => _LivestreamPageState();
}

class _LivestreamPageState extends State<LivestreamPage> {
  bool isError = false;
  bool isLoading = true;
  String description = "";
  String faceBookUrl = "";
  String youtubeUrl = "";
  Future<void> _launchYoutubeVideo(String _youtubeUrl) async {
    if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
      if (await canLaunch(_youtubeUrl)) {
        final bool _nativeAppLaunchSucceeded = await launch(
          _youtubeUrl,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
        if (!_nativeAppLaunchSucceeded) {
          await launch(_youtubeUrl, forceSafariVC: true);
        }
      }
    }
  }

  LiveStreams livestreams;
  Future<void> fetchItems() async {
    try {
      final response = await Utility.getDio().get(
        ApiUrl.LIVESTREAM,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        dynamic res = jsonDecode(response.data);

        setState(() {
          isLoading = false;
          isError = false;
          description = res["livestream"]["details"] as String;
          faceBookUrl = res["livestream"]["facebook_live"];
          youtubeUrl = res["livestream"]["youtube_live"];
        });
        // print(livestreams[0].status);
        // notifyListeners();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setFetchError();
      }
    } catch (exception) {
      // I get no exception here
      print(exception);
      setFetchError();
    }
  }

  setFetchError() {
    isError = true;
    isLoading = false;
    // notifyListeners();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchItems().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Livestream"),
      ),
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : Column(
              children: <Widget>[
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/videos.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  //child: Image.asset("assets/images/videos.jpg"),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (youtubeUrl == null || youtubeUrl.isEmpty) {
                        await showDialog(
                          context: context,
                          builder: (context) => new CupertinoAlertDialog(
                            title: new Text("No Livestream"),
                            content: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: new Text(
                                "Every Sunday at 2PM",
                                style: TextStyles.medium(context)
                                    .copyWith(fontSize: 20),
                              ),
                            ),
                            actions: <Widget>[
                              new TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: new Text(t.cancel),
                              ),
                            ],
                          ),
                        );
                      } else {
                        _launchYoutubeVideo(youtubeUrl);
                      }
                    },
                    child: Container(
                      color: MyColors.primary,
                      height: 50,
                      width: 200,
                      child: Center(
                          child: Text(
                        "WATCH US LIVE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: HtmlWidget(
                    description,
                    webView: true,
                    textStyle: TextStyles.medium(context)
                        .copyWith(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
    );
  }
}
