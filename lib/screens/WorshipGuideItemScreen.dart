import 'package:churchapp_flutter/models/WorshipGuideItem.dart';
import 'package:churchapp_flutter/providers/WorshipGuideProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../utils/TextStyles.dart';

class WorshipGuideItemScreen extends StatefulWidget {
  static const routeName = "/WorshipGuideItemScreen";
  const WorshipGuideItemScreen({Key key, this.worshipGuideItem})
      : super(key: key);
  final WorshipGuideItem worshipGuideItem;

  @override
  _WorshipGuideItemScreennState createState() =>
      _WorshipGuideItemScreennState();
}

class _WorshipGuideItemScreennState extends State<WorshipGuideItemScreen> {
  WorshipGuideProvider worshipGuideProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    worshipGuideProvider = Provider.of<WorshipGuideProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.worshipGuideItem.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: HtmlWidget(
            widget.worshipGuideItem.content,
            webView: false,
            textStyle: TextStyles.medium(context).copyWith(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
