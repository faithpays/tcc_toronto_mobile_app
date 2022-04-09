import 'package:carousel_slider/carousel_slider.dart';
import 'package:churchapp_flutter/i18n/strings.g.dart';
import 'package:churchapp_flutter/models/Photos.dart';
import 'package:churchapp_flutter/providers/PhotosModel.dart';
import 'package:churchapp_flutter/widgets/ImageWidget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'NoitemScreen.dart';

// class PhotosScreen extends StatelessWidget {
//   static const routeName = "/PhotosScreen";
//   PhotosScreen();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => PhotosModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Photos"),
//         ),
//         body: PortfolioGalleryDetailPage(),
//       ),
//     );
//   }
// }
class PortfolioGalleryDetailPage extends StatefulWidget {
  final List<Photos> imagePaths;
  final int currentIndex;

  PortfolioGalleryDetailPage({
    Key key,
    this.imagePaths,
    this.currentIndex,
  }) : super(key: key);

  @override
  _PortfolioGalleryDetailPageState createState() =>
      _PortfolioGalleryDetailPageState();
}

class _PortfolioGalleryDetailPageState
    extends State<PortfolioGalleryDetailPage> {
  PhotosModel photosModel;

  void _onRefresh() async {
    photosModel.loadItems();
  }

  int _currentIndex;
  PageController _pageController;
  List<Photos> photosList = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      Provider.of<PhotosModel>(context, listen: false).loadItems();
    });
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    photosModel = Provider.of<PhotosModel>(context);
    photosList = photosModel.photos;
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
      body: SmartRefresher(
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
            : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: <Widget>[
        _buildPhotoViewGallery(),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      //child: _buildDottedIndicator(),
      child: _buildImageCarouselSlider(),
    );
  }

  Widget _buildImageCarouselSlider() {
    return CarouselSlider.builder(
      // height: 100,
      // viewportFraction: 0.21,
      // enlargeCenterPage: true,
      // initialPage: _currentIndex,
      options: CarouselOptions(
        initialPage: _currentIndex ?? 0,
        height: 150,
        // height: MediaQuery.of(context).size.height,
        viewportFraction: 0.21,
        enlargeCenterPage: true,
        // autoPlay: true,
        // autoPlayInterval: Duration(seconds: 3),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        // pauseAutoPlayOnTouch: Duration(seconds: 10),
      ),
      itemCount: widget.imagePaths.length,
      // height: 100,
      // viewportFraction: 0.21,
      // enlargeCenterPage: true,
      // initialPage: _currentIndex,
      itemBuilder: (context, index, realIndex) {
        return GalleryImageWidget(
          imagePath: widget.imagePaths[index].thumbnail ??
              'https://picsum.photos/250?image=9',
          onImageTap: () => _pageController.jumpToPage(index ?? 0),
        );
      },
      
    );
  }

 

  PhotoViewGallery _buildPhotoViewGallery() {
    return PhotoViewGallery.builder(
      itemCount: widget.imagePaths.length,
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(widget.imagePaths[index].thumbnail),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 1.8,
        );
      },
      enableRotation: true,
      scrollPhysics: const BouncingScrollPhysics(),
      pageController: _pageController,
      loadingBuilder: (BuildContext context, ImageChunkEvent event) {
        return Center(child: CircularProgressIndicator());
      },
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
