import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Electronic_Details_Page.dart';

class LaptopItemsPage extends StatefulWidget {
  @override
  String itemID;
  String itemName;
  LaptopItemsPage(this.itemID, this.itemName);
  _LaptopItemsPageState createState() =>
      _LaptopItemsPageState(this.itemID, this.itemName);
}

class _LaptopItemsPageState extends State<LaptopItemsPage> {
  @override
  _LaptopItemsPageState(this.itemID, this.itemName);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String itemID;
  String itemName;
  bool showspinner = false;
  String Getimage;
  List<ElectronicItems> ElectronicProductslist = new List();
  bool showNoProduct = false;

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
                  child: Image.asset("images/noproductsfound.jpg",
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
                            itemCount: ElectronicProductslist.length,
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
                                          "${ElectronicProductslist[index].ElectronicFirstImage}",
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
                                              return ElectronicDetailsPage(
                                                  ElectronicProductslist[index].Electronicid.toString());
                                            }),
                                          );
                                        },
                                        title: Text(
                                          "${ElectronicProductslist[index].ElectronicTitle}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${ElectronicProductslist[index].ElectronicDescription}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        ),
                                        trailing: Text(
                                          "${ElectronicProductslist[index].ElectronicPrice}.00",
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
    _getElectronicProducts(itemID);
  }

  void _getElectronicProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("1", "0", itemid, "");
      if (fetchelectronicproducts != null) {
        var resid = fetchelectronicproducts["resid"];
        var rowcount = fetchelectronicproducts["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchelectronicprodcutssd =
                fetchelectronicproducts["electronicsproductlist"];
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
              this.ElectronicProductslist = tempfetchelectronicprodcutslist;
              showspinner = false;
            });

            print(
                "//////ElectronicProductslist/////////${ElectronicProductslist.length}");
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
