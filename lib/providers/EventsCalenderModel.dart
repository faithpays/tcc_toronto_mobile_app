import 'package:churchapp_flutter/models/Calendar.dart';
import 'package:churchapp_flutter/models/Events.dart';
import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/screens/EventsViewerScreen.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/ApiUrl.dart';
import '../models/Userdata.dart';

class EventsCalenderModel with ChangeNotifier {
  var date = new DateTime.now();
  List<Calendar> calendars = [
    Calendar(id: 1, name: "January"),
    Calendar(id: 2, name: "February"),
    Calendar(id: 3, name: "March"),
    Calendar(id: 4, name: "April"),
    Calendar(id: 5, name: "May"),
    Calendar(id: 6, name: "June"),
    Calendar(id: 7, name: "July"),
    Calendar(id: 8, name: "August"),
    Calendar(id: 9, name: "September"),
    Calendar(id: 10, name: "October"),
    Calendar(id: 11, name: "November"),
    Calendar(id: 12, name: "December"),
  ];
  bool isError = false;
  bool isLoading = true;
  bool isLoaded = false;
  Userdata userdata;
  List<Events> currentEventsList = [];
  BuildContext context;
  List<List<ListTile>> items = [];

  EventsCalenderModel() {
    if (items.length == 0) {
      calendars.forEach((element) {
        List<ListTile> _itm = [];
        _itm.add(ListTile(
          title: Text("No Events for this month"),
        ));
        items.add(_itm);
      });
    }
  }

  setContext(BuildContext context) {
    this.context = context;
  }

  loadItems() {
    /*if (isLoaded) {
      isError = false;
      isLoading = false;
      notifyListeners();
    } else {*/
    isError = false;
    isLoading = true;
    notifyListeners();
    fetchItems();
    //}
  }

  Future<void> fetchItems() async {
    try {
      final response = await Utility.getDio().get(
        ApiUrl.eventsCalendar,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        isError = false;
        isLoading = false;
        isLoaded = true;
        print(response.data);
        dynamic res = jsonDecode(response.data);
        List<Events> eventsList = parseEvents(res);
        List<ListTile> _jan = [];
        List<ListTile> _feb = [];
        List<ListTile> _march = [];
        List<ListTile> _april = [];
        List<ListTile> _may = [];
        List<ListTile> _june = [];
        List<ListTile> _july = [];
        List<ListTile> _aug = [];
        List<ListTile> _sept = [];
        List<ListTile> _oct = [];
        List<ListTile> _nov = [];
        List<ListTile> _dec = [];
        eventsList.forEach((element) {
          switch (element.month) {
            case 1:
              _jan.add(getItem(element));
              break;
            case 2:
              _feb.add(getItem(element));
              break;
            case 3:
              _march.add(getItem(element));
              break;
            case 4:
              _april.add(getItem(element));
              break;
            case 5:
              _may.add(getItem(element));
              break;
            case 6:
              _june.add(getItem(element));
              break;
            case 7:
              _july.add(getItem(element));
              break;
            case 8:
              _aug.add(getItem(element));
              break;
            case 9:
              _sept.add(getItem(element));
              break;
            case 10:
              _oct.add(getItem(element));
              break;
            case 11:
              _nov.add(getItem(element));
              break;
            case 12:
              _dec.add(getItem(element));
              break;
          }
        });
        if (_jan.length != 0) {
          items[0] = _jan;
        }
        if (_feb.length != 0) {
          items[1] = _feb;
        }
        if (_march.length != 0) {
          items[2] = _march;
        }
        if (_april.length != 0) {
          items[3] = _april;
        }
        if (_may.length != 0) {
          items[4] = _may;
        }
        if (_june.length != 0) {
          items[5] = _june;
        }
        if (_july.length != 0) {
          items[6] = _july;
        }
        if (_aug.length != 0) {
          items[7] = _aug;
        }

        if (_sept.length != 0) {
          items[8] = _sept;
        }
        if (_oct.length != 0) {
          items[9] = _oct;
        }
        if (_nov.length != 0) {
          items[10] = _nov;
        }
        if (_dec.length != 0) {
          items[11] = _dec;
        }

        notifyListeners();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        print(response.data);
        setFetchError();
      }
    } catch (exception) {
      // I get no exception here
      print(exception);
      setFetchError();
    }
  }

  static List<Events> parseEvents(dynamic res) {
    final parsed = res["events"].cast<Map<String, dynamic>>();
    return parsed.map<Events>((json) => Events.fromJson(json)).toList();
  }

  setFetchError() {
    isError = true;
    isLoading = false;
    isLoaded = false;
    notifyListeners();
  }

  ListTile getItem(Events events) {
    DateTime date = DateTime.parse(events.date.split('/').join());
    String monthname = DateFormat('MMM').format(date);
    String dayname = DateFormat('EEEE').format(date);
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(EventsViewerScreen.routeName,
            arguments: ScreenArguements(
              position: 0,
              items: events,
              itemsList: [],
            ));
      },
      contentPadding: EdgeInsets.all(8),
      leading: Container(
        height: 100,
        width: 60,
        padding: EdgeInsets.all(8),
        color: Colors.grey[600],
        child: Column(
          children: [
            Text(
              events.day.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              monthname,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      title: Text(
        events.title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        dayname + ", " + events.time,
        style: TextStyle(fontSize: 14),
      ),
      trailing: Icon(Icons.navigate_next),
    );
  }
}
