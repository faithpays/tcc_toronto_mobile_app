import 'package:churchapp_flutter/models/Groups.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LifeGroupItemScreen extends StatelessWidget {
  static const routeName = "/LifeGroupItemScreen";
  LifeGroupItemScreen({this.groups});
  final Groups groups;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Life Group"),
      ),
      body: Container(
        // decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                child: Text(
                  groups.name,
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    //fontFamily: "serif",
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 20.0),
                    Container(
                        width: 120.0,
                        height: 120.0,
                        child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: NetworkImage(groups.thumbnail))),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text(
                              "Leader",
                              style: TextStyles.headline(context).copyWith(
                                fontWeight: FontWeight.bold,
                                //fontFamily: "serif",
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          groups.leader,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              title: Text(
                "About " + groups.name + " group",
                style: TextStyles.headline(context).copyWith(
                  fontWeight: FontWeight.bold,
                  //fontFamily: "serif",
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                groups.description,
                textAlign: TextAlign.start,
                style: TextStyles.headline(context).copyWith(
                  //fontWeight: FontWeight.bold,
                  //fontFamily: "serif",

                  fontSize: 16,
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              title: Text(
                "Location",
                style: TextStyles.headline(context).copyWith(
                  fontWeight: FontWeight.bold,
                  //fontFamily: "serif",
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                groups.location,
                textAlign: TextAlign.start,
                style: TextStyles.headline(context).copyWith(
                  //fontWeight: FontWeight.bold,
                  //fontFamily: "serif",

                  fontSize: 16,
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              title: Text(
                "Meeting Time",
                style: TextStyles.headline(context).copyWith(
                  fontWeight: FontWeight.bold,
                  //fontFamily: "serif",
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                groups.time,
                textAlign: TextAlign.start,
                style: TextStyles.headline(context).copyWith(
                  //fontWeight: FontWeight.bold,
                  //fontFamily: "serif",

                  fontSize: 16,
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              title: Text(
                "Get in Touch",
                style: TextStyles.headline(context).copyWith(
                  fontWeight: FontWeight.bold,
                  //fontFamily: "serif",
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      groups.email,
                      textAlign: TextAlign.start,
                      style: TextStyles.headline(context).copyWith(
                        //fontWeight: FontWeight.bold,
                        //fontFamily: "serif",

                        fontSize: 16,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      groups.phone,
                      textAlign: TextAlign.start,
                      style: TextStyles.headline(context).copyWith(
                        //fontWeight: FontWeight.bold,
                        //fontFamily: "serif",

                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
