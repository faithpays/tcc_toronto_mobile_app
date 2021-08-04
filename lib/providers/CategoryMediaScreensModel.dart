import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import '../i18n/strings.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../database/SQLiteDbProvider.dart';
import '../utils/Utility.dart';
import '../models/Categories.dart';
import '../utils/ApiUrl.dart';
import '../models/Userdata.dart';
import '../models/Media.dart';

class CategoryMediaScreensModel with ChangeNotifier {
  //List<Comments> _items = [];
  bool isError = false;
  Userdata userdata;
  List<Media> mediaList = [];
  List<Categories> subCategoriesList = [];
  int category = 0;
  int selectedSubCategory = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 0;

  CategoryMediaScreensModel() {
    this.mediaList = [];
    getUserData();
  }

  getUserData() async {
    userdata = await SQLiteDbProvider.db.getUserData();
    print("userdata " + userdata.toString());
    notifyListeners();
  }

  loadItems(int category) {
    this.category = category;
    refreshController.requestRefresh();
    page = 0;
    fetchItems();
  }

  loadMoreItems() {
    page = page + 1;
    fetchItems();
  }

  void setItems(List<Media> item) {
    mediaList.clear();
    mediaList = item;
    refreshController.refreshCompleted();
    isError = false;
    notifyListeners();
  }

  void setMoreItems(List<Media> item) {
    mediaList.addAll(item);
    refreshController.loadComplete();
    notifyListeners();
  }

  bool isSubcategorySelected(int index) {
    Categories categories = subCategoriesList[index];
    return categories.id == selectedSubCategory;
  }

  refreshPageOnCategorySelected(int id) {
    if (id != selectedSubCategory) {
      selectedSubCategory = id;
      notifyListeners();
      loadItems(category);
    }
  }

  Future<void> fetchItems() async {
    try {
      final response = await Utility.getDio().post(
        ApiUrl.FETCH_CATEGORIES_MEDIA,
        data: jsonEncode({
          "data": {
            "email": userdata == null ? "null" : userdata.email,
            "sub": selectedSubCategory.toString(),
            "category": category.toString(),
            "version": "v2",
            "page": page.toString()
          }
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        dynamic res = jsonDecode(response.data);
        List<Media> mediaList = await compute(parseSliderMedia, res);
        if (page == 0) {
          if (subCategoriesList.length == 0) {
            subCategoriesList = await compute(parseCategories, res);
            addTopItem();
          }
          setItems(mediaList);
        } else {
          setMoreItems(mediaList);
        }
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        setFetchError();
      }
    } catch (exception) {
      print(exception);
      setFetchError();
    }
  }

  addTopItem() {
    Categories cats = new Categories(
        id: 0, title: t.allitems, mediaCount: 0, thumbnailUrl: "");
    subCategoriesList.insert(0, cats);
  }

  static List<Media> parseSliderMedia(dynamic res) {
    final parsed = res["media"].cast<Map<String, dynamic>>();
    return parsed.map<Media>((json) => Media.fromJson(json)).toList();
  }

  static List<Categories> parseCategories(dynamic res) {
    final parsed = res["subcategories"].cast<Map<String, dynamic>>();
    return parsed
        .map<Categories>((json) => Categories.fromJson2(json))
        .toList();
  }

  setFetchError() {
    if (page == 0) {
      isError = true;
      refreshController.refreshFailed();
      notifyListeners();
    } else {
      refreshController.loadFailed();
      notifyListeners();
    }
  }
}
