import 'package:cached_network_image/cached_network_image.dart';
import 'package:churchapp_flutter/chat/photoviewer.dart';
import 'package:churchapp_flutter/models/Photos.dart';
import 'package:churchapp_flutter/models/ScreenArguements.dart';
import 'package:churchapp_flutter/providers/PhotosModel.dart';
import 'package:churchapp_flutter/screens/Imageviewer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../i18n/strings.g.dart';
import '../screens/NoitemScreen.dart';

class PhotosScreen extends StatelessWidget {
  static const routeName = "/PhotosScreen";
  PhotosScreen();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PhotosModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Photos"),
        ),
        body: PhotosScreenBody(),
      ),
    );
  }
}

class PhotosScreenBody extends StatefulWidget {
  const PhotosScreenBody({Key key}) : super(key: key);

  @override
  _PhotosScreenBodyBodyState createState() => _PhotosScreenBodyBodyState();
}

class _PhotosScreenBodyBodyState extends State<PhotosScreenBody> {
  PhotosModel photosModel;

  void _onRefresh() async {
    photosModel.loadItems();
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<PhotosModel>(context, listen: false).loadItems();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    photosModel = Provider.of<PhotosModel>(context);

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
      controller: photosModel.refreshController,
      onRefresh: _onRefresh,
      //onLoading: lifeGroupModel.loadMoreItems(),
      child: (photosModel.isError == true)
          ? NoitemScreen(
              title: t.oops,
              message: "No Photos available at the moment.",
              onClick: _onRefresh)
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: photosModel.photos.length,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(3),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 0.9),
                itemBuilder: (BuildContext context, int index) {
                  Photos photos = photosModel.photos[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Imageviewer.routeName,
                          arguments: ScreenArguements(
                            position: 0,
                            items: photos,
                            itemsList: [],
                          ));
                    },
                    child: Card(
                        margin: EdgeInsets.all(0),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          //height: 80,
                          //width: 80,
                          child: CachedNetworkImage(
                            imageUrl: photos.thumbnail,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black12, BlendMode.darken)),
                              ),
                            ),
                            placeholder: (context, url) =>
                                Center(child: CupertinoActivityIndicator()),
                            errorWidget: (context, url, error) => Center(
                                child: Icon(
                              Icons.error,
                              color: Colors.grey,
                            )),
                          ),
                        )),
                  );
                },
              ),
          ),
    );
  }
}
