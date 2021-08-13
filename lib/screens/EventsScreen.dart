import 'package:cached_network_image/cached_network_image.dart';
import 'package:churchapp_flutter/models/Events.dart';
import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/providers/AppStateManager.dart';
import 'package:churchapp_flutter/providers/EventsModel.dart';
import 'package:churchapp_flutter/screens/EventsCalenderScreen.dart';
import 'package:churchapp_flutter/screens/EventsViewerScreen.dart';
import 'package:churchapp_flutter/screens/GiveTestimonyScreen.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../audio_player/miniPlayer.dart';
import '../models/Userdata.dart';
import '../screens/EventsListScreen.dart';
import 'package:provider/provider.dart';
import '../screens/VideoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../i18n/strings.g.dart';
import '../utils/TextStyles.dart';
import '../screens/NoitemScreen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key key, this.userdata}) : super(key: key);
  final Userdata userdata;

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventsModel eventsModel;

  void _onRefresh() async {
    eventsModel.loadItems();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<EventsModel>(context, listen: false).loadItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventsModel = Provider.of<EventsModel>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text(t.pulluploadmore);
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text(t.loadfailedretry);
            } else if (mode == LoadStatus.canLoading) {
              body = Text(t.releaseloadmore);
            } else {
              body = Text(t.nomoredata);
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: eventsModel.refreshController,
        onRefresh: _onRefresh,
        child: (eventsModel.isError == true)
            ? NoitemScreen(
                title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
            : (eventsModel.isLoading == true)
                ? Container()
                : Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 10,
                          ),
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                ),
                                Text(
                                  "Calender",
                                  style: TextStyles.headline(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "serif",
                                    fontSize: 20,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, EventsCalenderScreen.routeName);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      "View",
                                      style:
                                          TextStyles.headline(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: "serif",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/events.jpg",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                //color: Colors.black26,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                              child: Text(
                                "Current Events",
                                style: TextStyles.headline(context).copyWith(
                                  fontWeight: FontWeight.bold,
                                  //fontFamily: "serif",
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Divider(),
                          eventsModel.currentEventsList.length == 0
                              ? ListTile(
                                  title: Text("No Current Events"),
                                )
                              : ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(),
                                  shrinkWrap: true,
                                  itemCount: eventsModel.currentEventsList.length,
                                  itemBuilder: (context, index) {
                                    Events events =
                                        eventsModel.currentEventsList[index];
                                    return ListTile(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            EventsViewerScreen.routeName,
                                            arguments: ScreenArguements(
                                              position: 0,
                                              items: events,
                                              itemsList: [],
                                            ));
                                      },
                                      leading: Icon(Icons.event_available),
                                      title: Text(
                                        events.title,
                                        style:
                                            TextStyles.headline(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                          //fontFamily: "serif",
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Text(
                                        events.time,
                                        style:
                                            TextStyles.headline(context).copyWith(
                                          //fontWeight: FontWeight.bold,
                                          //fontFamily: "serif",
                                          fontSize: 12,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.navigate_next,
                                        size: 28,
                                      ),
                                    );
                                  },
                                ),
                          Divider(),
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                ),
                                Text(
                                  "UpComing Events",
                                  style: TextStyles.headline(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "serif",
                                    fontSize: 20,
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, EventsCalenderScreen.routeName);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(
                                      "View all",
                                      style:
                                          TextStyles.headline(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: "serif",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 12,
                          ),
                          eventsModel.upComingEventsEventsList.length == 0
                              ? ListTile(
                                  title: Text("No UpComing Events"),
                                )
                              : Container(
                                  height: 250,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: eventsModel
                                        .upComingEventsEventsList.length,
                                    shrinkWrap: false,
                                    itemBuilder: (context, index) {
                                      Events events = eventsModel
                                          .upComingEventsEventsList[index];
                                      return Container(
                                        //height: 100,
                                        width: 250,
                                        padding: const EdgeInsets.only(
                                            right: 3.0, left: 3.00),
                                        child: InkWell(
                                          child: Container(
                                            width: 250,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  height: 200,
                                                  //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    child: CachedNetworkImage(
                                                      imageUrl: events.thumbnail,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                              colorFilter:
                                                                  ColorFilter.mode(
                                                                      Colors
                                                                          .black12,
                                                                      BlendMode
                                                                          .darken)),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CupertinoActivityIndicator()),
                                                      errorWidget: (context, url,
                                                              error) =>
                                                          Center(
                                                              child: Image.asset(
                                                        "assets/images/events.jpg",
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
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                      //color: Colors.black54,
                                                      height: 35,
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            events.title,
                                                            style: TextStyles
                                                                    .caption(
                                                                        context)
                                                                .copyWith(
                                                                  color: Colors.black,
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              //color: Colors.white,
                                                            ),
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                    'EEE, MMM d, yyyy')
                                                                .format(new DateFormat(
                                                                        "yyyy-MM-dd")
                                                                    .parse(events
                                                                        .date)),
                                                            style: TextStyles
                                                                    .caption(
                                                                        context)
                                                                .copyWith(
                                                                  fontWeight: FontWeight.normal,
                                                                  color: Colors.black,
                                                              fontSize: 13.0,
                                                            ),
                                                            maxLines: 1,
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                EventsViewerScreen.routeName,
                                                arguments: ScreenArguements(
                                                  position: 0,
                                                  items: events,
                                                  itemsList: [],
                                                ));
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
