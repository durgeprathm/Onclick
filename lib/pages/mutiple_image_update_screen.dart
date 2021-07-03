import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:onclickproperty/Adaptor/update_posted_property_image.dart';

class MultipleImageUpload extends StatefulWidget {
  final List<String> previmagesList;
  final String PropertyID;

  MultipleImageUpload(this.previmagesList, this.PropertyID);

  @override
  _MultipleImageUploadState createState() {
    return _MultipleImageUploadState(this.previmagesList, this.PropertyID);
  }
}

class _MultipleImageUploadState extends State<MultipleImageUpload> {
  final List<String> previmagesList;
  final String PropertyID;

  _MultipleImageUploadState(this.previmagesList, this.PropertyID);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  // File _imageFile;

  List<File> imageslistfile = [];
  List<String> oldPropertyImgList = [];
  bool showspinner = false;
  String previewImages = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      previmagesList.forEach((element) {
        oldPropertyImgList.add(element);
      });
      images.add("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text("", style: appbarTitleTextStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (_) {
                //     return PostServiceAdvertisementPage();
                //   }),
                // );
                print(
                    "imageslistfile////////////////////////////${imageslistfile}");
                print(
                    "previewImages////////////////////////////${previewImages}");
                print("PropertyID////////////////////////////${PropertyID}");
                uploadImageData();
                imageslistfile.forEach((element) {
                  print(element);
                });
              },
              borderSide: BorderSide(
                color: primarycolor,
                style: BorderStyle.solid,
              ),
              child: Text("Update",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: getProportionateScreenWidth(12),
                      color: primarycolor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body:  showspinner
          ? Center(child: CircularProgressIndicator())
          :  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Previous Property Photos:',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              previmagesList.length != 0
                  ? Visibility(
                      visible: oldPropertyImgList.length != 0 ? true : false,
                      child: buildNetworkImageGridView())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'No Previous Property Photos',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
              Divider(),
              Text(
                'Add More Property Photos:',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              buildImagePickerGridView(),
            ],
          ),
        ),
    );
  }

  Widget buildNetworkImageGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(oldPropertyImgList.length, (index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Image.network(
                oldPropertyImgList[index],
                width: getProportionateScreenWidth(300),
                height: getProportionateScreenHeight(300),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  child: Icon(
                    Icons.remove_circle,
                    size: getProportionateScreenWidth(20),
                    color: Colors.red,
                  ),
                  onTap: () {
                    setState(() {
                      // images.replaceRange(index, index + 1, ['']);
                      oldPropertyImgList.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildImagePickerGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenHeight(300),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: getProportionateScreenWidth(20),
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        // images.replaceRange(index, index + 1, ['']);
                        images.removeAt(index);
                        imageslistfile.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // _onAddImageClick(index);
                _showPicker(context, index);
              },
            ),
          );
        }
      }),
    );
  }

  void _showPicker(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromGallery(index) async {
    _onAddImageClick(0, index);
  }

  _imgFromCamera(index) async {
    _onAddImageClick(1, index);
  }

  Future _onAddImageClick(int chooseType, int index) async {
    // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() async {
      if (chooseType == 0) {
        FilePickerResult result =
            await FilePicker.platform.pickFiles(type: FileType.image);
        _imageFile = Future<File>.value(File(result.paths[0]));

        //_imageFile = ImagePicker.(source: ImageSource.gallery);
      } else {
        final _picker = ImagePicker();
        PickedFile image = await _picker.getImage(
            source: ImageSource.camera, imageQuality: 50);
        _imageFile = Future<File>.value(File(image.path));
        //_imageFile = ImagePicker.pickImage(source: ImageSource.camera);
      }
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //  var dir = await path_provider.getTemporaryDirectory();
    _imageFile.then((file) async {
      if (file != null) {
        setState(() {
          ImageUploadModel imageUpload = new ImageUploadModel();
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = file;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          images.add("");
          imageslistfile.add(file);
        });
        // print(images);
        // print(_imageFile);
        // print(imageslistfile);
      }
    });
  }

  uploadImageData() async {
    setState(() {
      showspinner = true;
    });
    if (oldPropertyImgList.length != 0) {
      previewImages = oldPropertyImgList.join('#');
    }
    print(previewImages);
    UpdatePostedPropertyImage propertySubmitData =
        new UpdatePostedPropertyImage();
    var propertydata = await propertySubmitData.PostedPropertyData(
        imageslistfile.length == 0 ? '1' : '0',
        imageslistfile,
        PropertyID,
        previewImages != null ? previewImages : "");
    if (propertydata != null) {
      print("property data ///${propertydata}");
      var resid = propertydata['resid'];
      print("response from server ${resid}");
      if (resid == 200) {
        setState(() {
          showspinner = false;
        });
        Fluttertoast.showToast(
            msg: "Data Successfully Save !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
      } else {
        setState(() {
          showspinner = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Plz Try Again"),
          backgroundColor: Colors.green,
        ));
      }
    } else {
      setState(() {
        showspinner = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Some Technical Problem Plz Try Again Later"),
          backgroundColor: Colors.green,
        ));
      });
    }
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
