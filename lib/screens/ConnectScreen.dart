import 'package:churchapp_flutter/models/Connect.dart';
import 'package:churchapp_flutter/screens/BranchesScreen.dart';
import 'package:churchapp_flutter/screens/ConnectCardScreen.dart';
import 'package:churchapp_flutter/screens/GiveTestimonyScreen.dart';
import 'package:churchapp_flutter/screens/LifeGroupScreen.dart';
import 'package:churchapp_flutter/screens/MinistriesScreen.dart';
import 'package:churchapp_flutter/screens/PrayerRequestScreen.dart';
import 'package:churchapp_flutter/screens/WorshipGuideScreen.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';

import '../models/Userdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key key, this.userdata}) : super(key: key);
  final Userdata userdata;

  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  List<Connect> _conect = [
    Connect(title: "Life Group", image: "assets/images/lifegroup.jpg"),
    Connect(title: "Ministries", image: "assets/images/ministries.jpg"),
    Connect(title: "Worship Guide", image: "assets/images/worship.jpg"),
    Connect(title: "Prayer Request", image: "assets/images/prayer.jpg"),
    Connect(title: "Locations", image: "assets/images/location.jpg"),
    Connect(title: "Share Testimony", image: "assets/images/testimony.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: double.infinity,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: _conect.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(3),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.95),
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
                          color: Colors.black26,
  colorBlendMode: BlendMode.darken,
                          //colorBlendMode: BlendMode.dstIn,
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
                    Navigator.of(context).pushNamed(LifeGroupScreen.routeName);
                    break;
                  case 1:
                    Navigator.of(context).pushNamed(MinistriesScreen.routeName);
                    break;
                  case 2:
                    Navigator.of(context).pushNamed(WorshipGuideScreen.routeName);
                    break;
                  case 3:
                    Navigator.of(context)
                        .pushNamed(PrayerRequestScreen.routeName);
                    break;
                  case 4:
                    Navigator.of(context).pushNamed(BranchesScreen.routeName);
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
    );
  }
}
