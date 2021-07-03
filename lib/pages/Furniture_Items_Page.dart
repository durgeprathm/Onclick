import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Electronic_Details_Page.dart';
import 'package:onclickproperty/pages/Furniture_Details_Page.dart';

class FurnitureItemsPage extends StatefulWidget {
  @override
  String itemID;
  String itemName;
  FurnitureItemsPage(this.itemID, this.itemName);
  _FurnitureItemsPageState createState() =>
      _FurnitureItemsPageState(this.itemID, this.itemName);
}

class _FurnitureItemsPageState extends State<FurnitureItemsPage> {
  @override
  _FurnitureItemsPageState(this.itemID, this.itemName);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String itemID;
  String itemName;
  bool showNoProduct = false;
  bool showspinner = false;
  String Getimage;
  List<FurnitureProducts> FurnitureProductslist = new List();

  Widget build(BuildContext context) {
    double listHeight = MediaQuery.of(context).size.height * 0.72;
    double chipContainerW = MediaQuery.of(context).size.width * 0.95;
    double chipContainerH = MediaQuery.of(context).size.height * 0.05;
    double picsize = MediaQuery.of(context).size.width / 2;

    final imageList = [
      'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'https://thearchitectsdiary.com/wp-content/uploads/2020/04/pexels-photo-186077.jpeg',
      'https://i.pinimg.com/originals/3a/a2/5f/3aa25f3b5a2b72908ac7956cadc29da0.jpg',
      'https://i.pinimg.com/originals/06/6e/61/066e61a913b0b0d0623bb9013c0c4f4f.jpg',
    ];
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            "${itemName}",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: primarycolor,
            ),
          )),
      // flexibleSpace: SomeWidget(),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : showNoProduct
              ? Center(
                  child: Image.asset(
                    "images/noproductsfound.jpg",
                  ),
                )
              : SafeArea(
                  key: _scaffoldKey,
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20.0, left: 12.0, right: 12.0),
                          child: Container(
                            child: TextField(
                              //  controller: SerachController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primarycolor, width: 2.0),
                                    // borderRadius:
                                    // BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primarycolor, width: 2.0),
                                    // borderRadius:
                                    // BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  hintText: "Items Search..",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                    ),
                                    color: primarycolor,
                                    onPressed: () {},
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: FurnitureProductslist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 6.0),
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 2.0,
                                      child: ListTile(
                                        leading: Image.network(
                                          "${FurnitureProductslist[index].FurniturnFirstImage}",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                        ),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                              return FurnitureDetailsPage(
                                                  FurnitureProductslist[index].Furnitureid);
                                            }),
                                          );
                                        },
                                        title: Text(
                                          "${FurnitureProductslist[index].FurniturnTitle}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${FurnitureProductslist[index].FurniturnDescription}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                        trailing: Text(
                                          "${FurnitureProductslist[index].FurniturnPrice}.00",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
    );
  }

  @override
  void initState() {
    _getFurnitureProducts(itemID);
  }

  void _getFurnitureProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureProducts fetchfurnitureproductsdata =
          new FetchFurnitureProducts();
      var fetchfurnitureproducts = await fetchfurnitureproductsdata
          .getFetchFurnitureProducts("1", "0", itemid, "");
      if (fetchfurnitureproducts != null) {
        var resid = fetchfurnitureproducts["resid"];
        var rowcount = fetchfurnitureproducts["rowcount"];

        if (resid == 200) {
          if (rowcount > 0) {
            var fetchfurnitureprodcutssd =
                fetchfurnitureproducts["furnitureproductlist"];
            print(fetchfurnitureprodcutssd.length);
            List<FurnitureProducts> tempfetchfurnitureprodcutslist = [];
            for (var n in fetchfurnitureprodcutssd) {
              FurnitureProducts pro = FurnitureProducts(
                int.parse(n["id"]),
                int.parse(n["uid"]),
                int.parse(n["furnituretypeID"]),
                n["furniturename"],
                n["furnituresubtype"],
                n["condition"],
                n["brand"],
                n["title"],
                n["price"],
                n["mobileno"],
                n["username"],
                n["email"],
                n["pincode"],
                n["city"],
                n["area"],
                n["yourare"],
                n["furniturematerial"],
                n["model"],
                n["quality"],
                n["description"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
                n["date"],
                n["lat"],
                n["long"],
                n["Firstimg"],
                n["img"],
              );
              tempfetchfurnitureprodcutslist.add(pro);
            }
            setState(() {
              this.FurnitureProductslist = tempfetchfurnitureprodcutslist;
              showspinner = false;
            });

            print(
                "//////FurnitureProductslist/////////${FurnitureProductslist.length}");
          } else {
            setState(() {
              showNoProduct = true;
              showspinner = false;
            });
          }
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
