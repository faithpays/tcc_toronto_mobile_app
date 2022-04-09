import 'dart:convert';

import 'package:churchapp_flutter/i18n/strings.g.dart';

import 'package:churchapp_flutter/utils/ApiUrl.dart';
import 'package:churchapp_flutter/utils/StringsUtils.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'package:url_launcher/url_launcher.dart';

class GiveNowScreen extends StatefulWidget {
  static const routeName = "/givenowscreen";
  @override
  _GiveNowScreenState createState() => _GiveNowScreenState();
}

class _GiveNowScreenState extends State<GiveNowScreen> {
  bool isLoading = true;
  bool isError = false;
  String donationUrl;
 // List<GetDonationUrlModel> items = [];
  Future<void> loadItems() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Utility.getDio()
          .get(ApiUrl.GET_DONATION_URL + StringsUtils.CHURCH_ID);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        dynamic res = jsonDecode(response.data);
        print(res);
        print(res[0]["donation_link"]);
        // List<GetDonationUrlModel> _items =
        //     GetDonationUrlModel.fromJson(res).toJson();
        setState(() {
          isLoading = false;
          donationUrl = res[0]["donation_link"];
        });

        // print(items.donationLink);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setState(() {
          isLoading = false;
          isError = true;
        });
      }
    } catch (exception) {
      // I get no exception here
      print(exception);
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadItems().whenComplete(() => null);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      title: Text(
        'GIVE NOW',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22.0,
          color: MyColors.primary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,

            child: Text(
              'Your generosity matters',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: MyColors.primary,
              ),
            ),
            // child: Text(
            //   'Your Generosity Matters',
            //   style: TextStyle(fontSize: 12.0, fontStyle: FontStyle.italic,),
            //   textAlign: TextAlign.center,

            // ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            //height: 45.0,
            child: Text(
              'You are about to leave the ${t.appname} App and go to an external donation service.',
              style: TextStyle(fontSize: 14.0, color: MyColors.primary),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: MyColors.primary,
                  side: BorderSide(color: MyColors.primary, width: 2),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyColors.primary,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  _launchInBrowser(donationUrl);
                },
                child: Text('Continue'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
