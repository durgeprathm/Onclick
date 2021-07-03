import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPage extends StatefulWidget {
  @override
  List<String> imageList = [];
  GalleryPage(this.imageList);
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    int firstPage = 1;
    int _currentIndex = 0;
    PageController _pageController = PageController(initialPage: firstPage);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Container(
          child: Center(
            child: Text(
              '${widget.imageList.length}/${_currentIndex}',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.normal,
                color: primarycolor,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  String myImg = widget.imageList[index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(myImg),
                    initialScale: PhotoViewComputedScale.contained * 0.9,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.imageList[index]),
                  );
                },
                itemCount: widget.imageList.length,
                loadingBuilder: (context, event) => Center(
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          value: event == null
                              ? 0
                              : event.cumulativeBytesLoaded /
                                  event.expectedTotalBytes,
                        ),
                      ),
                    ),
                //backgroundDecoration: Colors.white,
                pageController: _pageController,
                onPageChanged: (int index) {
                  print(index);
                  setState(() {
                    _currentIndex = index + 1;
                  });
                })),
      ),
    );
    ;
  }

  Gridview() {
    Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(widget.imageList.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Container(
              child: Image.network(widget.imageList[index]),
            ),
          );
        }),
      ),
    );
  }
}
