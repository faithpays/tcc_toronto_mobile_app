import 'package:churchapp_flutter/models/Events.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils/ApiUrl.dart';
import '../models/Userdata.dart';

class EventsModel with ChangeNotifier {
  //List<Comments> _items = [];
  bool isError = false;
  bool isLoading = true;
  Userdata userdata;
  List<Events> currentEventsList = [];
  List<Events> upComingEventsEventsList = [];
  BuildContext context;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  EventsModel() {}

  loadItems() {
    refreshController.requestRefresh();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response = await Utility.getDio().get(
        ApiUrl.fetchEvents,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        refreshController.refreshCompleted();
        isError = false;
        isLoading = false;
        print(response.data);
        dynamic res = jsonDecode(response.data);
        currentEventsList = parseCurrentEvents(res);
        upComingEventsEventsList = parseComingEvents(res);
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

  static List<Events> parseCurrentEvents(dynamic res) {
    final parsed = res["current"].cast<Map<String, dynamic>>();
    return parsed.map<Events>((json) => Events.fromJson(json)).toList();
  }

  static List<Events> parseComingEvents(dynamic res) {
    final parsed = res["future"].cast<Map<String, dynamic>>();
    return parsed.map<Events>((json) => Events.fromJson(json)).toList();
  }

  setFetchError() {
    isError = true;
    isLoading = false;
    refreshController.refreshCompleted();
    notifyListeners();
  }
}
