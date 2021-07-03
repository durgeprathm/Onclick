import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/ElectronicUpdatedDetails_User_Posted.dart';
import 'package:onclickproperty/pages/Zooming_Products_Images.dart';

class UserItemsElectronicDetailsPage extends StatefulWidget {
  @override
  final String itemsid;
  UserItemsElectronicDetailsPage(this.itemsid);
  _UserItemsElectronicDetailsPageState createState() =>
      _UserItemsElectronicDetailsPageState();
}

class _UserItemsElectronicDetailsPageState
    extends State<UserItemsElectronicDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  String title;
  List<String> tempimageList = [];
  List<String> sepratedImages = [];
  List<String> ImagesList = [];
  List<String> ImagesListAll = [];
  List<ElectronicItems> ElectronicListFetch = new List();

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    double picsize = MediaQuery.of(context).size.width / 2;
    double cardsizewidth = MediaQuery.of(context).size.width * 0.60;
    double cardsizeheight = MediaQuery.of(context).size.height * 0.40;
    double picsizeheight = MediaQuery.of(context).size.height * 0.22;
    final imageList = [
      'https://cdn.mos.cms.futurecdn.net/6t8Zh249QiFmVnkQdCCtHK.jpg',
      'https://cdn.mos.cms.futurecdn.net/k9Md6R78D8aN4tbGDRWUSE.jpg',
      'https://cdn.arstechnica.net/wp-content/uploads/2016/01/IMG_2860-980x653.jpg',
      'https://www.windowslatest.com/wp-content/uploads/2017/09/Windows-10-PC.jpg',
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title:
        showspinner ? Text("") : Text(
          "${ElectronicListFetch[0].ElectronicTitle}",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.normal,
            color: primarycolor,
          ),
        ),
        actions: [],
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) {
                                  return ZoomingProductsImages(
                                      sepratedImages, title);
                                }),
                              );
                              print(
                                  "///////sending images to zoom//////////////////////${sepratedImages}");
                            },
                            child: ClipRRect(
                              child: Container(
                                height: 200,
                                width: picsize,
                                child: new Swiper(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Image.network(
                                      sepratedImages[index],
                                      fit: BoxFit.fill,

                                      //---------------------------
                                      loadingBuilder: (BuildContext
                                      context,
                                          Widget child,
                                          ImageChunkEvent
                                          loadingProgress) {
                                        if (loadingProgress ==
                                            null) return child;
                                        return Center(
                                          child:
                                          CircularProgressIndicator(
                                            value: loadingProgress
                                                .expectedTotalBytes !=
                                                null
                                                ? loadingProgress
                                                .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },

                                      //--------------------------
                                    );
                                  },
                                  pagination: SwiperPagination(),
                                  itemCount: sepratedImages.length,
                                  itemWidth: 300.0,
                                  layout: SwiperLayout.DEFAULT,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${ElectronicListFetch[0].ElectronicDescription}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.rupeeSign,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "${ElectronicListFetch[0].ElectronicPrice}.00",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                            child: Material(
                              //borderRadius: BorderRadius.circular(10.0),
                              elevation: 2.0,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Products Details",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Condition",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch[0].ElectronicCondition}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 5.0,
                                      thickness: 1.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Brand Name",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch[0].ElectronicBrandname}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 5.0,
                                      thickness: 1.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Wattage",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch[0].ElectronicWattage}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 5.0,
                                      thickness: 1.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Model",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch[0].ElectronicModel}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 5.0,
                                      thickness: 1.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Appliances Type",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch[0].ElectronicAppliancestypename}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 5.0,
                                      thickness: 1.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Posted By",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch[0].ElectronicYouAre}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  //borderRadius: new BorderRadius.circular(10.0),
                                  ),
                              color: primarycolor,
                              //minWidth: MediaQuery.of(context).size.width/3,
                              padding:
                                  EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) {
                                    return UpdatedElectronicsPage(
                                        ElectronicListFetch[0]
                                            .Electronicid
                                            .toString());
                                  }),
                                );
                                print(
                                    "/////Sending to update/////////////////////////${ElectronicListFetch[0].Electronicid.toString()}");
                              },
                              child: Text("Update Details",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    _getElectronicProducts(widget.itemsid.toString());
    print("///////itemsid//////////////${widget.itemsid}");
  }

  void _getElectronicProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("4", "4", itemid, "");
      if (fetchelectronicproducts != null) {
        print(fetchelectronicproducts);
        var resid = fetchelectronicproducts["resid"];
        if (resid == 200) {
          var fetchelectronicprodcutssd =
              fetchelectronicproducts["electronicslist"];
          print(fetchelectronicprodcutssd.length);
          List<ElectronicItems> tempfetchelectronicprodcutslist = [];
          for (var n in fetchelectronicprodcutssd) {
            ElectronicItems pro = ElectronicItems(
              int.parse(n["id"]),
              int.parse(n["uid"]),
              int.parse(n["appliancestypeid"]),
              n["appliancestypeName"],
              n["brand"],
              n["condition"],
              n["capacity"],
              n["title"],
              n["price"],
              n["mobileno"],
              n["username"],
              n["email"],
              n["pincode"],
              n["city"],
              n["area"],
              n["yourare"],
              n["wattage"],
              n["model"],
              n["description"],
              n["date"],
              n["Firstimg"],
              n["img"],
              n["alternateno"],
              n["std"],
              n["telephoneno"],
              n["lat"],
              n["long"],
            );
            tempfetchelectronicprodcutslist.add(pro);
          }
          setState(() {
            this.ElectronicListFetch = tempfetchelectronicprodcutslist;
            print(
                "//////ElectroicProductslist/////////${ElectronicListFetch.length}");
            // var imagesHashValue = ElectronicListFetch[0].ElectronicImages;
            // print("///////imagesHashValue//////////////${imagesHashValue}");
            sepratedImages = ElectronicListFetch[0].ElectronicImages.split("#");
            print(
                "///////sepratedImages//////////////${ElectronicListFetch[0].ElectronicImages}");
          });
          setState(() {
            showspinner = false;
          });
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
    } catch (e) {
      print(e);
    }
  }
}
