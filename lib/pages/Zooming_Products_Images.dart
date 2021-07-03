import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';

class ZoomingProductsImages extends StatefulWidget {
  List<String> Imagelistzoom;
  String title;

  ZoomingProductsImages(this.Imagelistzoom, this.title);
  @override
  _ZoomingProductsImagesState createState() => _ZoomingProductsImagesState();
}
// List<String> imgList = [
//   "Images/groceryone.jpg",
//   "Images/grocery6.jpg",
//   "Images/grocery8.jpg",
//   "Images/grocery2.jpg",
//   "Images/grocery3.jpg",
// ];

class _ZoomingProductsImagesState extends State<ZoomingProductsImages> {
  String _currentImage;

  @override
  void initState() {
    setState(() {
      _currentImage = widget.Imagelistzoom[0];
    });
    print("/////Imagelistzoom////////////////${widget.Imagelistzoom.length}");
  }

  final TransformationController _controller = TransformationController();

  @override
  Widget build(BuildContext context) {
    double bottomHeight = MediaQuery.of(context).size.height * 0.15;
    double bottomwidth = MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "${widget.title}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
            color: primarycolor,
          ),
        ),
        iconTheme: IconThemeData(color: primarycolor),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InteractiveViewer(
                  maxScale: 5.0,
                  transformationController: _controller,
                  child: Image.network(_currentImage.toString()),
                ),
              ),
              Container(
                height: bottomHeight,
                width: bottomwidth,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.Imagelistzoom.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currentImage = widget.Imagelistzoom[index];
                          _controller.value = Matrix4.identity();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(2),
                        color: primarycolor,
                        child: Image.network(widget.Imagelistzoom[index]
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
