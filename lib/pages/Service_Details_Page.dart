import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Model/UpdateServices.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Updated_Service_Page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class ServiceDetailsPage extends StatefulWidget {
  @override
  String id;
  ServiceDetailsPage(this.id);
  _ServiceDetailsPageState createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  List<UpdatedService> Fetchupdatedservicelist = new List();
  String ServiceID;
  String Servicetypename;
  String Name;
  String city;
  String Area;
  String Mobilenumber;
  String Pincode;
  String Email;
  String aadharnumber;
  String Imagefront;
  String Imageback;
  String Alternatenumber;
  String Std;
  String Telephone;
  String MainTelephone;
  bool checkaadhar = false;
  bool checkPincode = false;
  bool checkEmail = false;
  bool checkImageBack =false;
  bool checkImageFront =false;
  bool checkTelephone =false;
  bool checkAltmobile =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Center(
                            child: SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                fit: StackFit.expand,
                                overflow: Overflow.visible,
                                children: [
                                  CircleAvatar(
                                      backgroundImage:
                                          AssetImage("images/musician.png"),
                                      backgroundColor: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.01),
                          Center(
                            child: Text(
                              "${Servicetypename != null ? Servicetypename : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${Name != null ? Name : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Mobile Number:",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${Mobilenumber != null ? Mobilenumber : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: checkAltmobile,
                            child: Text(
                              "Alternate Mobile Number:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkAltmobile,
                            child: Text(
                              "${Alternatenumber != null ? Alternatenumber : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkAltmobile,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: checkTelephone,
                            child: Text(
                              "Telephone Number:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkTelephone,
                            child: Text(
                              "${MainTelephone != null ? MainTelephone : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkTelephone,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: checkEmail,
                            child: Text(
                              "Email:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkEmail,
                            child: Text(
                              "${Email != null ? Email : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkEmail,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Text(
                            "City:",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${city != null ? city : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Area",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${Area != null ? Area : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: checkPincode,
                            child: Text(
                              "Pincode",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkPincode,
                            child: Text(
                              "${Pincode != null ? Pincode : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkPincode,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: checkaadhar,
                            child: Text(
                              "Addhar Card Number:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkaadhar,
                            child: Text(
                              "${aadharnumber != null ? aadharnumber : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkaadhar,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Text(
                            "Addhar Card Front Image:",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.01),
                          Imagefront != null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(Imagefront),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                          "images/frontAadharnew.jpg"),
                                    ),
                                    Text(
                                      "plz enter aadhar card by pressing on update button",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(8),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Addhar Card Back Image:",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.01),
                          Imageback != null
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(Imageback),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                          "images/backadharnew.jpg"),
                                    ),
                                    Text(
                                      "plz enter aadhar card by pressing on update button",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(8),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Row(
                            children: [
                              Expanded(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return UpdateServicePage(widget.id.toString());
                                      }),
                                    );
                                  },
                                  child: Text(
                                    'Update',
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    _getservicesdata(widget.id.toString());
  }

  void _getservicesdata(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchUpdateList fetchupdatlist = new FetchUpdateList();
      var fetchupdatedsdata =
          await fetchupdatlist.getFetchUpdateList("0", "1", itemid);
      if (fetchupdatedsdata != null) {
        var resid = fetchupdatedsdata["resid"];
        var rowcount = fetchupdatedsdata["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchupdatedsdatasd = fetchupdatedsdata["UserserviceList"];
            print(fetchupdatedsdatasd.length);
            List<UpdatedService> tempfetchupdatedlist = [];
            for (var n in fetchupdatedsdatasd) {
              UpdatedService pro = UpdatedService(
                n["id"],
                n["name"],
                n["mobileno"],
                n["city"],
                n["pincode"],
                n["area"],
                n["lat"],
                n["long"],
                n["servicetypeid"],
                n["servicetypename"],
                n["email"],
                n["adharno"],
                n["img1"],
                n["img2"],
                n["posteddate"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
              );
              tempfetchupdatedlist.add(pro);
            }
            setState(() {
              this.Fetchupdatedservicelist = tempfetchupdatedlist;
              ServiceID = Fetchupdatedservicelist[0].Serviceid.toString();
              Servicetypename =
                  Fetchupdatedservicelist[0].Servicetypename.toString();
              Name = Fetchupdatedservicelist[0].name.toString();
              city = Fetchupdatedservicelist[0].City.toString();
              Area = Fetchupdatedservicelist[0].area.toString();
              Mobilenumber = Fetchupdatedservicelist[0].Mobilenumber.toString();
              Pincode = Fetchupdatedservicelist[0].pincode.toString();
              if (Pincode == null) {
                checkPincode = false;
              } else {
                checkPincode = true;
              }
              print("///Pincode/////${Pincode}");
              Email = Fetchupdatedservicelist[0].Email.toString();
              if (Email == null) {
                checkEmail = false;
              } else {
                checkEmail = true;
              }
              print("///Email/////${Email}");
              aadharnumber =
                  Fetchupdatedservicelist[0].addharcardnumber.toString();
              if (aadharnumber == null) {
                checkaadhar = false;
              } else {
                checkaadhar = true;
              }
              Imagefront = Fetchupdatedservicelist[0].imgfront.toString();
              if(Imagefront==null)
                {
                  checkImageFront=false;
                }else
                  {
                    checkImageFront=true;
                  }
              print("///Imagefront/////${Imagefront}");
              Imageback = Fetchupdatedservicelist[0].imgback.toString();
              if(Imageback==null)
              {
                checkImageBack=false;
              }else
              {
                checkImageBack=true;
              }
              Alternatenumber= Fetchupdatedservicelist[0].Alternatenumber.toString();
              if (Alternatenumber == null) {
                checkAltmobile = false;
              } else {
                checkAltmobile = true;
              }
              Std= Fetchupdatedservicelist[0].StdCode.toString();
              Telephone=Fetchupdatedservicelist[0].Telephone.toString();
              if (Alternatenumber == null) {
                checkAltmobile = false;
              } else {
                checkAltmobile = true;
              }
              MainTelephone=Std+'-'+Telephone;
              if (MainTelephone == null) {
                checkTelephone = false;
              } else {
                checkTelephone = true;
              }


              print("///Imageback/////${Imageback}");
              showspinner = false;
            });

            print(
                "//////Fetchupdatedservicelist/////////${Fetchupdatedservicelist.length}");
          } else {
            setState(() {
              //showNoProduct = true;
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
