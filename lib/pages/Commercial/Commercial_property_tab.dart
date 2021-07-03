import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Model/all_dashboard_property_model.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Agreement_Page.dart';
import 'package:onclickproperty/pages/Electronics_Page.dart';
import 'package:onclickproperty/pages/HomeServices_Page.dart';
import 'package:onclickproperty/pages/Home_Loan_Page.dart';
import 'package:onclickproperty/pages/Payment_Page.dart';
import 'package:onclickproperty/pages/Top_property_Buy.dart';
import 'package:onclickproperty/pages/furnitures_Page.dart';
import 'package:onclickproperty/pages/property_details.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:provider/provider.dart';

class CommericalPropertyTab extends StatefulWidget {
  @override
  _CommericalPropertyTabState createState() => _CommericalPropertyTabState();
}

class _CommericalPropertyTabState extends State<CommericalPropertyTab> {
  @override
  Widget build(BuildContext context) {
    double shopcontainerheight = MediaQuery.of(context).size.height * 0.50;
    double shopcontainerwidth = MediaQuery.of(context).size.width * 0.40;
    double producthotoheight = MediaQuery.of(context).size.width * 0.25;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          child: ListView(children: [
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return HomeServicesPage();
                    }),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FaIcon(
                            //   Icons.home_work,
                            //   size: 30.0,
                            //   color: primarycolor,
                            // ),
                            Expanded(
                              flex: 2,
                              child: Image(
                                image: AssetImage("assets/images/service.png"),
                                width: getProportionateScreenWidth(50),
                                height: getProportionateScreenHeight(50),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Home Services",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  height: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return FurnituresPage();
                    }),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FaIcon(
                            //   FontAwesomeIcons.chair,
                            //   size: 30.0,
                            //   color: primarycolor,
                            // ),
                            Expanded(
                              flex: 3,
                              child: Image(
                                image: AssetImage(
                                    "assets/images/furnitures-icon.png"),
                                width: getProportionateScreenWidth(50),
                                height: getProportionateScreenHeight(50),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Furnitures",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return ElectronicsPage();
                    }),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FaIcon(
                            //   FontAwesomeIcons.microchip,
                            //   size: 30.0,
                            //   color: primarycolor,
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Expanded(
                              flex: 3,
                              child: Image(
                                image:
                                    AssetImage("assets/images/electronics.png"),
                                width: getProportionateScreenWidth(50),
                                height: getProportionateScreenHeight(50),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Electronics",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    height: 1.5,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return AgreeMentPage();
                    }),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FaIcon(
                            //   FontAwesomeIcons.book,
                            //   size: 30.0,
                            //   color: primarycolor,
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Expanded(
                              flex: 3,
                              child: Image(
                                image: AssetImage("assets/images/contract.png"),
                                width: getProportionateScreenWidth(50),
                                height: getProportionateScreenHeight(50),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Agreement",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(14),
                                      height: 1.5),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return HomeLoanPage();
                    }),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FaIcon(
                            //   FontAwesomeIcons.moneyBill,
                            //   size: 30.0,
                            //   color: primarycolor,
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Expanded(
                              flex: 3,
                              child: Image(
                                image: AssetImage("assets/images/loan.png"),
                                width: getProportionateScreenWidth(50),
                                height: getProportionateScreenHeight(50),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Bank Loan",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(14),
                                      height: 1.5),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return PaymentPage();
                    }),
                  );
                },
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // FaIcon(
                            //   FontAwesomeIcons.ccAmazonPay,
                            //   size: 30.0,
                            //   color: primarycolor,
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Expanded(
                              flex: 3,
                              child: Image(
                                image: AssetImage("assets/images/money.png"),
                                width: getProportionateScreenWidth(50),
                                height: getProportionateScreenHeight(50),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("Payments",
                                  style: TextStyle(
                                      fontSize: getProportionateScreenWidth(14),
                                      height: 1.5)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Divider(
          height: 2.0,
          thickness: 2.0,
          color: primarycolor,
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Properties",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return TopPropertyBuy("1", "2", "1", "", "", "");
                            }),
                          );
                        },
                        child: Text(
                          "See all",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "We are Showing You Top Property Collections",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Consumer<AllDashboardCommTopProperty>(
                    builder: (context, rentPropertyList, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        width: SizeConfig.screenWidth * 0.95,
                        height: SizeConfig.screenWidth * 0.42,
                        child: ListView.builder(
                            itemCount: rentPropertyList.itemCount,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final dashProItems =
                                  rentPropertyList.pTopProperty[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) {
                                      return PropertyDetailsPage(
                                          dashProItems.id.toString(), "2");
                                    }),
                                  );
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 1,
                                  margin: EdgeInsets.all(5),
                                  child: Container(
                                    height: shopcontainerheight,
                                    width: shopcontainerwidth,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: producthotoheight,
                                              child: Image.network(
                                                dashProItems.topimglink
                                                    .toString(),
                                                // fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
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
                                              )),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                "${dashProItems.propertytype.toString()}",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14)),
                                              ),
                                              subtitle: Text(
                                                "Price: ${dashProItems.price.toString()}",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            12)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                  );
                }),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        Divider(
          height: 2.0,
          thickness: 2.0,
          color: primarycolor,
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Properties for Sell",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return TopPropertyBuy("2", "2", "1", "", "", "");
                            }),
                          );
                        },
                        child: Text(
                          "See all",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "We are Showing You Top Sell Property Collections",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Divider(
                  height: 2.0,
                  thickness: 1.0,
                ),
                Consumer<AllDashboardCommSellProperty>(
                    builder: (context, sellPropertyList, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        width: SizeConfig.screenWidth * 0.95,
                        height: SizeConfig.screenWidth * 0.42,
                        child: ListView.builder(
                            itemCount: sellPropertyList.itemCount,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final dashProItems =
                                  sellPropertyList.pSellProperty[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) {
                                      return PropertyDetailsPage(
                                          dashProItems.id.toString(), "2");
                                    }),
                                  );
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 1,
                                  margin: EdgeInsets.all(5),
                                  child: Container(
                                    height: shopcontainerheight,
                                    width: shopcontainerwidth,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: producthotoheight,
                                              child: Image.network(
                                                dashProItems.topimglink
                                                    .toString(),
                                                // fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
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
                                              )),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                "${dashProItems.propertytype.toString()}",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14)),
                                              ),
                                              subtitle: Text(
                                                "Price: ${dashProItems.price.toString()}",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            12)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                  );
                }),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 2.0,
          thickness: 2.0,
          color: primarycolor,
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Properties for Rent",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return TopPropertyBuy("1", "2", "1", "", "", "");
                            }),
                          );
                        },
                        child: Text(
                          "See all",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.normal,
                              color: Colors.green),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "We are Showing You Top Rent Property Collections",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Consumer<AllDashboardCommRentProperty>(
                    builder: (context, rentPropertyList, child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                        width: SizeConfig.screenWidth * 0.95,
                        height: SizeConfig.screenWidth * 0.42,
                        child: ListView.builder(
                            itemCount: rentPropertyList.itemCount,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final dashProItems =
                                  rentPropertyList.pRentProperty[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) {
                                      return PropertyDetailsPage(
                                          dashProItems.id.toString(), "2");
                                    }),
                                  );
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  elevation: 1,
                                  margin: EdgeInsets.all(5),
                                  child: Container(
                                    height: shopcontainerheight,
                                    width: shopcontainerwidth,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                              height: producthotoheight,
                                              child: Image.network(
                                                dashProItems.topimglink
                                                    .toString(),
                                                // fit: BoxFit.fill,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
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
                                              )),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                "${dashProItems.propertytype.toString()}",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14)),
                                              ),
                                              subtitle: Text(
                                                "Price: ${dashProItems.price.toString()}",
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            12)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                  );
                }),
              ],
            ),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        Divider(
          height: 2.0,
          thickness: 2.0,
          color: primarycolor,
        ),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
      ])),
    );
  }
}
