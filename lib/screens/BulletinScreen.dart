import 'package:churchapp_flutter/models/Bulletin.dart';
import 'package:churchapp_flutter/providers/BulletinModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../i18n/strings.g.dart';
import '../utils/TextStyles.dart';
import '../screens/NoitemScreen.dart';

class BulletinScreen extends StatelessWidget {
  static const routeName = "/BulletinScreen";
  BulletinScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BulletinModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bulletin"),
        ),
        body: BulletinScreenBody(),
      ),
    );
  }
}

class BulletinScreenBody extends StatefulWidget {
  const BulletinScreenBody({Key key}) : super(key: key);

  @override
  _BulletinScreenBodyState createState() => _BulletinScreenBodyState();
}

class _BulletinScreenBodyState extends State<BulletinScreenBody> {
  BulletinModel bulletinModel;

  void _onRefresh() async {
    bulletinModel.loadItems();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<BulletinModel>(context, listen: false).loadItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bulletinModel = Provider.of<BulletinModel>(context);

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
      controller: bulletinModel.refreshController,
      onRefresh: _onRefresh,
      //onLoading: lifeGroupModel.loadMoreItems(),
      child: (bulletinModel.isError == true)
          ? NoitemScreen(
              title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
          : (bulletinModel.isLoading == true)
              ? Container()
              : Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          child: Stack(children: [
                            Container(
                              height: 200,
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: Image.asset(
                                  "assets/images/ourbulletin.jpg",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  //color: Colors.black26,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 20, 10, 0),
                                child: Text(
                                  "Our Bulletin",
                                  style: TextStyles.headline(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    //fontFamily: "serif",
                                    color: Colors.white,
                                    fontSize: 28,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          height: 20,
                        ),
                        bulletinModel.bulletins.length == 0
                            ? ListTile(
                                title: Text("No Bulletin"),
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                shrinkWrap: true,
                                itemCount: bulletinModel.bulletins.length,
                                itemBuilder: (context, index) {
                                  Bulletin bulletin =
                                      bulletinModel.bulletins[index];
                                  return ListTile(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(15, 5, 15, 0),
                                    onTap: () {
                                      /*Navigator.of(context).pushNamed(
                                            EventsViewerScreen.routeName,
                                            arguments: ScreenArguements(
                                              position: 0,
                                              items: events,
                                              itemsList: [],
                                            ));*/
                                    },
                                    title: Text(
                                      bulletin.title,
                                      style:
                                          TextStyles.headline(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: "serif",
                                        fontSize: 22,
                                      ),
                                    ),
                                    subtitle: Text(
                                      bulletin.content,
                                      textAlign: TextAlign.start,
                                      style:
                                          TextStyles.headline(context).copyWith(
                                        //fontWeight: FontWeight.bold,
                                        //fontFamily: "serif",

                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
