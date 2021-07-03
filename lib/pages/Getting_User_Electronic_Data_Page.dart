import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_electronic_get_owner_details_data.dart';
import 'package:onclickproperty/Adaptor/Registration_Details_Image.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Electronics_Items_Page.dart';
import 'package:onclickproperty/pages/Furniture_Details_Page.dart';
import 'package:onclickproperty/pages/Furniture_Items_Page.dart';
import 'package:onclickproperty/pages/Login_Page.dart';
import 'package:onclickproperty/Adaptor/insert_request_userdata.dart';

class GettingUserElectronicDataPage extends StatefulWidget {
  @override
  String CheckId;
  String ID;
  String mobileno;
  GettingUserElectronicDataPage(this.CheckId, this.ID,this.mobileno);
  _GettingUserElectronicDataPageState createState() =>
      _GettingUserElectronicDataPageState(this.CheckId, this.ID,this.mobileno);
}

class _GettingUserElectronicDataPageState
    extends State<GettingUserElectronicDataPage> {
  String CheckId;
  String ID;
  String mobileno;
  _GettingUserElectronicDataPageState(this.CheckId, this.ID,this.mobileno);
  List<ElectronicItems> ElectroicProductslist = new List();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showpass = true;
  bool showRepass = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final format = DateFormat("yyyy-MM-dd");
  String _selectdate;
  File images;
  List<File> listfile = [];
  bool showspinner = false;
  bool checkemail = false;
  bool checkusername = false;
  String erroremail;
  String errorusername;
  InsertUserRequest insertUserRequest = new InsertUserRequest();

  TextEditingController _FullNametext = TextEditingController();
  TextEditingController _EmailIDtext = TextEditingController();
  TextEditingController _MobileNumbertext = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();

  String FullName;
  String UserName;
  String Password;
  String RePassword;
  String EmailID;
  String MobileNumber;
  String Title;
  String Price;
  String UID;
  String UserFullName;
  String UserEmail;
  String UserMobile;

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print(UID);

    UserFullName = await SharedPreferencesConstants.instance
        .getStringValue("userfullname");
    print(UserFullName);

    UserEmail = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    print(UserEmail);

    UserMobile  = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    print(UserMobile);
  }

  @override
  void initState() {
    getUserdata();
    print("//////ID//////////////////${ID}");
    _getElectronicProducts(ID.toString());
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            "",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: primarycolor,
            ),
          )),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: FormUI(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget FormUI() {
    return ListView(
      children: <Widget>[
        SizedBox(height: 10.0),
        Center(
          child: Text(
            "Fill Contact Details",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: primarycolor,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: _FullNametext,
          style: style,
          enabled: false,
          onChanged: (value) {
            FullName = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.user,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Enter Full Name",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _title,
          obscureText: false,
          //maxLines: 2,
          style: style,
          enabled: false,
          onChanged: (value) {
            Title = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.heading,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Title",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _price,
          obscureText: false,
          //maxLines: 2,
          enabled: false,
          style: style,
          onChanged: (value) {
            Price = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.moneyCheck,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Price",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _EmailIDtext,
          obscureText: false,
          style: style,
          enabled: false,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            EmailID = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.envelope,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Enter Email",
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _MobileNumbertext,
          obscureText: false,
          enabled: false,
          style: style,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            MobileNumber = value;
          },
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
              child: FaIcon(
                FontAwesomeIcons.mobileAlt,
                color: primarycolor,
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Mobile Number",
          ),
        ),
        SizedBox(height: 10.0),
        FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          color: primarycolor,
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
          onPressed: () {
            print("UID/////////////////${UID}");
            print("FullName/////////////////${FullName}");
            print("ID/////////////////${ID}");
            print("EmailID/////////////////${EmailID}");
            print("MobileNumber/////////////////${MobileNumber}");
            print("_selectdate/////////////////${_selectdate}");
            var resid = _getRegistrationSubmitData(
                "0",UID,FullName, ID, EmailID, MobileNumber, _selectdate);
            print(resid);
          },
          child: Text("Submit",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 3.0,
        ),
      ],
    );
  }

  _getRegistrationSubmitData(String actionId,String userid,String username, String typeid, String email,
      String mobileno, String date) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertElectronicGetOwnerDetails UsertData =
          new InsertElectronicGetOwnerDetails();
      var UsertDatafetch = await UsertData.insertElectronicGetOwnerDetails(
        actionId,
        userid,
        username,
        typeid,
        email,
        mobileno,
        date,
      );
      if (UsertDatafetch != null) {
        print("User data ///${UsertDatafetch}");
        var resid = UsertDatafetch['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "You Will Get Details Soon !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return LaptopItemsPage(
                  ElectroicProductslist[0]
                      .ElectronicAppliancestypeid
                      .toString(),
                  ElectroicProductslist[0]
                      .ElectronicAppliancestypename
                      .toString());
            }),
          );
        } else if (resid == 204) {
          setState(() {
            showspinner = false;
          });
          if (UsertDatafetch['error'] == "username") {
            setState(() {
              checkusername = true;
              errorusername = UsertDatafetch['message'];
            });
          } else if (UsertDatafetch['error'] == "email") {
            setState(() {
              checkemail = true;
              erroremail = UsertDatafetch['message'];
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

  void _getElectronicProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("3", "3", itemid, "");
      if (fetchelectronicproducts != null) {
        var resid = fetchelectronicproducts["resid"];

        if (resid == 200) {
          var fetchelectronicprodcutssd =
              fetchelectronicproducts["electronicsproductlist"];
          print(fetchelectronicprodcutssd.length);
          List<ElectronicItems> tempfetchelectronicprodcutslist = [];
          for (var n in fetchelectronicprodcutssd) {
            ElectronicItems pro = ElectronicItems.OwnerDetails(
              int.parse(n["id"]),
              n["title"],
              n["price"],
              int.parse(n["appliancestypeid"]),
              n["appliancestypeName"],
            );
            tempfetchelectronicprodcutslist.add(pro);
          }
          setState(() {
            this.ElectroicProductslist = tempfetchelectronicprodcutslist;
            print(
                "//////ElectroicProductslist/////////${ElectroicProductslist.length}");
            _title.text = ElectroicProductslist[0].ElectronicTitle;
            Title = ElectroicProductslist[0].ElectronicTitle;
            _price.text = ElectroicProductslist[0].ElectronicPrice;
            Price = ElectroicProductslist[0].ElectronicPrice;
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
