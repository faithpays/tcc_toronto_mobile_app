import 'package:churchapp_flutter/screens/AudioSermonsScreen.dart';
import 'package:churchapp_flutter/screens/VideoSermonsScreen.dart';
import 'package:churchapp_flutter/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SermonsScreen extends StatefulWidget {
  static const routeName = "/SermonsScreen";
  SermonsScreen();

  @override
  _SermonsScreenState createState() => _SermonsScreenState();
}

class _SermonsScreenState extends State<SermonsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sermon"),
      ),
      body: DefaultTabController(
        length: 2, // length of tabs
        initialIndex: 0,
        child: Container(
            // decoration: BoxDecoration(color: Colors.white),
            height: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 20,
                ),
                Container(
                  child: TabBar(
                    indicatorColor: MyColors.primary,
                    labelColor: MyColors.primary,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(text: "Videos"),
                      Tab(text: "Audios"),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(0),
                    child: TabBarView(
                        children: [VideoSermonsScreen(), AudioSermonsScreen()]),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
