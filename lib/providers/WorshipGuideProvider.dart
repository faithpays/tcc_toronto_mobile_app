import 'dart:convert';

import 'package:churchapp_flutter/i18n/strings.g.dart';
import 'package:churchapp_flutter/models/WorshipGuide.dart';
import 'package:churchapp_flutter/utils/Alerts.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:flutter/material.dart';
import '../utils/ApiUrl.dart';

class WorshipGuideProvider with ChangeNotifier {
  int lyrics = 0;
  WorshipGuide worshipGuide;
  bool showloader = false;
  BuildContext context;

  WorshipGuideProvider();

  setContext(BuildContext context) {
    this.context = context;
  }

  showLoaderIcon(bool show) {
    this.showloader = show;
  }

  Future<void> getWorshipGuide() async {
    if (showloader) {
      Alerts.showProgressDialog(context, t.processingpleasewait);
    }
    try {
      final response = await Utility.getDio().get(
        ApiUrl.getWorshipGuide,
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        print("worship guide");
        print(response.data);
        dynamic res = jsonDecode(response.data);
        worshipGuide = WorshipGuide.fromJson(res['worshipguide']);
        print(worshipGuide);
        lyrics = int.parse(res['lyrics'] as String);
        notifyListeners();
        if (showloader) {
          Navigator.of(context).pop();
          showloader = false;
        }
      } else {
        if (showloader) {
          Navigator.of(context).pop();
          showloader = false;
        }
      }
    } catch (exception) {
      // I get no exception here
      print(exception);
      if (showloader) {
        Navigator.of(context).pop();
        showloader = false;
      }
    }
  }
}
