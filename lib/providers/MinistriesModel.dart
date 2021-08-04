import 'package:churchapp_flutter/models/Ministries.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils/ApiUrl.dart';

class MinistriesModel with ChangeNotifier {
  List<Ministries> ministries = [];
  bool isError = false;
  bool isLoading = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 0;

  MinistriesModel();

  loadItems() {
    refreshController.requestRefresh();
    page = 0;
    isLoading = true;
    isError = false;
    notifyListeners();
    fetchItems();
  }

  loadMoreItems() {
    page = page + 1;
    fetchItems();
  }

  void setItems(List<Ministries> item) {
    ministries.clear();
    ministries = item;
    refreshController.refreshCompleted();
    isError = false;
    isLoading = false;
    notifyListeners();
  }

  void setMoreItems(List<Ministries> item) {
    ministries.addAll(item);
    refreshController.loadComplete();
    notifyListeners();
  }

  Future<void> fetchItems() async {
    try {
      final response = await Utility.getDio().post(
        ApiUrl.fetch_ministries,
        data: jsonEncode({
          "data": {
            "page": page.toString(),
          }
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.data);
        dynamic res = jsonDecode(response.data);
        List<Ministries> grouplist = parseMinistries(res);
        if (page == 0) {
          setItems(grouplist);
        } else {
          setMoreItems(grouplist);
        }
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

  static List<Ministries> parseMinistries(dynamic res) {
    final parsed = res["ministries"].cast<Map<String, dynamic>>();
    return parsed.map<Ministries>((json) => Ministries.fromJson(json)).toList();
  }

  setFetchError() {
    if (page == 0) {
      isError = true;
      isLoading = false;
      refreshController.refreshFailed();
      notifyListeners();
    } else {
      refreshController.loadFailed();
      notifyListeners();
    }
  }
}
