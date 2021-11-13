import 'package:churchapp_flutter/providers/EventsCalenderModel.dart';
import 'package:churchapp_flutter/screens/NoitemScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:expandable_group/expandable_group_widget.dart';

class EventsCalenderScreen extends StatelessWidget {
  static const routeName = "/EventsCalenderScreen";
  EventsCalenderScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventsCalenderModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Events Calender"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 12),
          child: EventsCalenderBody(),
        ),
      ),
    );
  }
}

class EventsCalenderBody extends StatefulWidget {
  const EventsCalenderBody({Key key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsCalenderBody> {
  EventsCalenderModel eventsCalenderModel;

  Widget _header(String name) => Text(name,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ));

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<EventsCalenderModel>(context, listen: false)
          .setContext(context);
      Provider.of<EventsCalenderModel>(context, listen: false).fetchItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventsCalenderModel = Provider.of<EventsCalenderModel>(context);
    return Container(
      height: double.infinity,
      child: eventsCalenderModel.isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : eventsCalenderModel.isError
              ? Center(
                  child: NoitemScreen(
                      title: "",
                      message: "Error loading Events Calender",
                      onClick: () {
                        eventsCalenderModel.loadItems();
                      }))
              : ListView.separated(
                  //physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(),
                  shrinkWrap: true,
                  itemCount: eventsCalenderModel.calendars.length,
                  itemBuilder: (context, index) {
                    return ExpandableGroup(
                      isExpanded: eventsCalenderModel.calendars[index].id ==
                          eventsCalenderModel.date.month,
                      collapsedIcon: Icon(Icons.expand_less),
                      headerBackgroundColor: Colors.white,
                      header: _header(
                          eventsCalenderModel.calendars[index].name +
                              " " +
                              eventsCalenderModel.date.year.toString()),
                      items: eventsCalenderModel.items.length == 0
                          ? []
                          : eventsCalenderModel.items[index],
                      headerEdgeInsets:
                          EdgeInsets.only(left: 16.0, right: 16.0),
                    );
                  },
                ),
    );
  }
}
