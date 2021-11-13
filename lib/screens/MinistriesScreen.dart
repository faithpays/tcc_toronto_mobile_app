import 'package:churchapp_flutter/models/Ministries.dart';
import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/providers/MinistriesModel.dart';
import 'package:churchapp_flutter/screens/MinistryItemScreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../i18n/strings.g.dart';
import '../utils/TextStyles.dart';
import '../screens/NoitemScreen.dart';

class MinistriesScreen extends StatelessWidget {
  static const routeName = "/MinistriesScreen";
  MinistriesScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MinistriesModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ministries"),
        ),
        body: Stack(children: [
          /* Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/ministrybg.jpg",
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
              color: Colors.black87,
            ),
          ),*/
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: MinistriesScreenBody(),
            ),
          )
        ]),
      ),
    );
  }
}

class MinistriesScreenBody extends StatefulWidget {
  const MinistriesScreenBody({Key key}) : super(key: key);

  @override
  _MinistriesScreenBodyState createState() => _MinistriesScreenBodyState();
}

class _MinistriesScreenBodyState extends State<MinistriesScreenBody> {
  MinistriesModel ministriesModel;

  void _onRefresh() async {
    ministriesModel.loadItems();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<MinistriesModel>(context, listen: false).loadItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ministriesModel = Provider.of<MinistriesModel>(context);

    return SmartRefresher(
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
      controller: ministriesModel.refreshController,
      onRefresh: _onRefresh,
      //onLoading: lifeGroupModel.loadMoreItems(),
      child: (ministriesModel.isError == true)
          ? NoitemScreen(
              title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
          : ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) => Divider(),
              shrinkWrap: true,
              itemCount: ministriesModel.ministries.length,
              itemBuilder: (context, index) {
                Ministries groups = ministriesModel.ministries[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(MinistryItemScreen.routeName,
                            arguments: ScreenArguements(
                              position: 0,
                              items: groups,
                              itemsList: [],
                            ));
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(groups.thumbnail),
                          fit: BoxFit.fill),
                    ),
                  ),
                  title: Text(
                    groups.name,
                    style: TextStyles.headline(context).copyWith(
                      fontWeight: FontWeight.bold,
                      //fontFamily: "serif",
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            groups.location,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyles.headline(context).copyWith(
                              //fontWeight: FontWeight.bold,
                              //fontFamily: "serif",

                              fontSize: 14,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            groups.time,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: TextStyles.headline(context).copyWith(
                              //fontWeight: FontWeight.bold,
                              //fontFamily: "serif",

                              fontSize: 13,
                            ),
                          ),
                        ),
                      ]),
                  trailing: Icon(
                    Icons.navigate_next,
                    size: 28,
                  ),
                );
              },
            ),
    );
  }
}
