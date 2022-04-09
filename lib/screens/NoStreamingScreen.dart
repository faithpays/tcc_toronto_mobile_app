import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../utils/TextStyles.dart';

class NoStreamingScreen extends StatelessWidget {
  static const routeName = "/NoStreamingScreen";
  final String details;

  const NoStreamingScreen({Key key, this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: HtmlWidget(
                    details,
                    webView: true,
                    textStyle:
                        TextStyles.medium(context).copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
