import 'package:churchapp_flutter/models/Bulletin.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../utils/ApiUrl.dart';

class BulletinModel with ChangeNotifier {
  List<Bulletin> bulletins = [];
  bool isError = false;
  bool isLoading = false;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 0;

  BulletinModel();

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

  void setItems(List<Bulletin> item) {
    bulletins.clear();
    bulletins = item;
    refreshController.refreshCompleted();
    isError = false;
    isLoading = false;
    notifyListeners();
  }

  void setMoreItems(List<Bulletin> item) {
    bulletins.addAll(item);
    refreshController.loadComplete();
    notifyListeners();
  }

  Future<void> fetchItems() async {
    try {
      final response = await Utility.getDio().get(
        ApiUrl.fetch_bulletins,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print(response.data);
        dynamic res = jsonDecode(response.data);
        List<Bulletin> grouplist = parseGroups(res);
        setItems(grouplist);
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

  static List<Bulletin> parseGroups(dynamic res) {
    final parsed = res["bulletins"].cast<Map<String, dynamic>>();
    return parsed.map<Bulletin>((json) => Bulletin.fromJson(json)).toList();
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
