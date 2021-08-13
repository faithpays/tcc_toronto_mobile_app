import 'package:churchapp_flutter/models/Ministries.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MinistryItemScreen extends StatelessWidget {
  static const routeName = "/MinistryItemScreen";
  MinistryItemScreen({this.ministries});
  final Ministries ministries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ministries.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 20.0),
                      Container(
                          width: 100.0,
                          height: 100.0,
                          child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage:
                                  NetworkImage(ministries.thumbnail))),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                              child: Text(
                                "Leader",
                                style: TextStyles.headline(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "serif",
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            
                            ministries.leader,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
      
                                fontSize: 12.0, fontWeight: FontWeight.bold),
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
                  "About " + ministries.name,
                  style: TextStyles.headline(context).copyWith(
                    fontWeight: FontWeight.bold,
                    //fontFamily: "serif",
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  ministries.description,
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
                  ministries.location,
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
                  ministries.time,
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
                        ministries.email,
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
                        ministries.phone,
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
      ),
    );
  }
}
