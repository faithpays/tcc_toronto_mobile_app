import 'package:cached_network_image/cached_network_image.dart';
import 'package:churchapp_flutter/models/Groups.dart';
import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/providers/LifeGroupModel.dart';
import 'package:churchapp_flutter/screens/LifeGroupItemScreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../i18n/strings.g.dart';
import '../utils/TextStyles.dart';
import '../screens/NoitemScreen.dart';

class LifeGroupScreen extends StatelessWidget {
  static const routeName = "/LifeGroupScreen";
  LifeGroupScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LifeGroupModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Life Groups"),
        ),
        body: LifeGroupBody(),
      ),
    );
  }
}

class LifeGroupBody extends StatefulWidget {
  const LifeGroupBody({Key key}) : super(key: key);

  @override
  _LifeGroupScreenState createState() => _LifeGroupScreenState();
}

class _LifeGroupScreenState extends State<LifeGroupBody> {
  LifeGroupModel lifeGroupModel;

  void _onRefresh() async {
    lifeGroupModel.loadItems();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<LifeGroupModel>(context, listen: false).loadItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    lifeGroupModel = Provider.of<LifeGroupModel>(context);

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
      controller: lifeGroupModel.refreshController,
      onRefresh: _onRefresh,
      //onLoading: lifeGroupModel.loadMoreItems(),
      child: (lifeGroupModel.isError == true)
          ? NoitemScreen(
              title: t.oops, message: t.dataloaderror, onClick: _onRefresh)
          : (lifeGroupModel.isLoading == true)
              ? Container()
              : Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          //margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.asset(
                              "assets/images/lifegroups.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              //color: Colors.black26,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                            child: Text(
                              "About Life Group",
                              style: TextStyles.headline(context).copyWith(
                                fontWeight: FontWeight.bold,
                                //fontFamily: "serif",
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                            child: Text(
                              "Life Group is a perfect place to be mentored by your peers..",
                              style: TextStyles.headline(context).copyWith(
                                //fontWeight: FontWeight.bold,
                                //fontFamily: "serif",
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 10, 0),
                            child: Text(
                              "Locate a Life Group",
                              style: TextStyles.headline(context).copyWith(
                                fontWeight: FontWeight.bold,
                                //fontFamily: "serif",
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                        lifeGroupModel.groups.length == 0
                            ? ListTile(
                                title: Text("No Current Events"),
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                                shrinkWrap: true,
                                itemCount: lifeGroupModel.groups.length,
                                itemBuilder: (context, index) {
                                  Groups groups = lifeGroupModel.groups[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          LifeGroupItemScreen.routeName,
                                          arguments: ScreenArguements(
                                            position: 0,
                                            items: groups,
                                            itemsList: [],
                                          ));
                                    },
                                    leading: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(groups.thumbnail),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    title: Text(
                                      groups.name,
                                      style:
                                          TextStyles.headline(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                        //fontFamily: "serif",
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              groups.location,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              style:
                                                  TextStyles.headline(context)
                                                      .copyWith(
                                                //fontWeight: FontWeight.bold,
                                                //fontFamily: "serif",

                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              groups.time,
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              style:
                                                  TextStyles.headline(context)
                                                      .copyWith(
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
                      ],
                    ),
                  ),
                ),
    );
  }
}
