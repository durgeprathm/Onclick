import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Model/UpdateServices.dart';
import 'package:onclickproperty/Providers/post_advertisments_provider.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Update_Advertisment_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class AdvertimentDetailsPage extends StatefulWidget {
  @override
  String id;
  AdvertimentDetailsPage(this.id);
  _AdvertimentDetailsPageState createState() => _AdvertimentDetailsPageState();
}

class _AdvertimentDetailsPageState extends State<AdvertimentDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  List<Advertisements> FetchupdatedAdvertisementslist = new List();
  String ServiceID;
  String Companyname;
  String Companytype;
  String Name;
  String city;
  String Area;
  String Mobilenumber;
  String Pincode;
  String Email;
  String Companywebsite;
  String Companyemail;
  String Companytitle;
  String Companydescription;
  List<String> imageList = [];
  bool checkaadhar = false;
  bool checkPincode = false;
  bool checkEmail = false;
  String Alternate;
  String Std;
  String Telphone;
  String MainTelphone;

  @override
  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width;
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
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        ClipRRect(
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(builder: (_) {
                              //     return GalleryPage(imageList);
                              //   }),
                              // );
                            },
                            child: Container(
                              height: 200,
                              width: picsize,
                              child: imageList.length != 0
                                  ? new Swiper(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return new Image.network(
                                          imageList[index],
                                          fit: BoxFit.fill,
                                        );
                                      },
                                      pagination: SwiperPagination(),
                                      itemCount: imageList.length,
                                      itemWidth: 300.0,
                                      layout: SwiperLayout.DEFAULT,
                                    )
                                  : Text(''),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              Text(
                                "Alternate Mobile Number:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Alternate != null ? Alternate : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Telephone Number:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${MainTelphone != null ? MainTelphone : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Email:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Email != null ? Email : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Company Name:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Companyname != null ? Companyname : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Company Type:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Companytype != null ? Companytype : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Company Website:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Companywebsite != null ? Companywebsite : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Company Email:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Companyemail != null ? Companyemail : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Advertisement Title:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Companytitle != null ? Companytitle : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
                              Text(
                                "Company Description:",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "${Companydescription != null ? Companydescription : ''}",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12),
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: SizeConfig.screenHeight * 0.03),
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
                              Row(
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (_) {
                                            return UpdatedAdvertisementPage(
                                                widget.id.toString());
                                          }),
                                        );
                                      },
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(18),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
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
          await fetchupdatlist.getFetchUpdateList("1", "2", itemid);
      if (fetchupdatedsdata != null) {
        var resid = fetchupdatedsdata["resid"];
        var rowcount = fetchupdatedsdata["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchupdatedsdatasd = fetchupdatedsdata["UserAdertisementList"];
            print(fetchupdatedsdatasd.length);
            List<Advertisements> tempfetchupdatedlist = [];
            for (var n in fetchupdatedsdatasd) {
              Advertisements pro = Advertisements.Details(
                n["id"],
                n["name"],
                n["email"],
                n["mobileno"],
                n["cname"],
                n["ctype"],
                n["cweb"],
                n["cwemail"],
                n["title"],
                n["description"],
                n["city"],
                n["area"],
                n["lat"],
                n["long"],
                n["pincode"],
                n["posteddate"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
                n["img"],
              );
              tempfetchupdatedlist.add(pro);
            }
            setState(() {
              this.FetchupdatedAdvertisementslist = tempfetchupdatedlist;
              ServiceID = FetchupdatedAdvertisementslist[0].id.toString();
              Companyname =
                  FetchupdatedAdvertisementslist[0].companyname.toString();
              Companytype =
                  FetchupdatedAdvertisementslist[0].companytype.toString();
              print("Companytype:-${Companytype}");
              Companywebsite =
                  FetchupdatedAdvertisementslist[0].companywebsite.toString();
              print("Companywebsite:-${Companywebsite}");

              Companyemail =
                  FetchupdatedAdvertisementslist[0].companyemail.toString();
              print("Companyemail:-${Companyemail}");

              Companytitle =
                  FetchupdatedAdvertisementslist[0].companytitle.toString();
              print("Companytitle:-${Companytitle}");

              Companydescription = FetchupdatedAdvertisementslist[0]
                  .companydescription
                  .toString();
              print("Companydescription:-${Companydescription}");

              imageList = FetchupdatedAdvertisementslist[0].Image.split("#");
              print("imageList:-${imageList}");
              Name = FetchupdatedAdvertisementslist[0].name.toString();
              city = FetchupdatedAdvertisementslist[0].city.toString();
              Area = FetchupdatedAdvertisementslist[0].address.toString();
              Mobilenumber =
                  FetchupdatedAdvertisementslist[0].mobileno.toString();
              print("Mobilenumber:-${Mobilenumber}");
              Pincode = FetchupdatedAdvertisementslist[0].pincode.toString();
              if (Pincode == null) {
                checkPincode = false;
              } else {
                checkPincode = true;
              }
              Email = FetchupdatedAdvertisementslist[0].email.toString();
              print("Email:-${Email}");
              if (Email == null) {
                checkEmail = false;
              } else {
                checkEmail = true;
              }
              Alternate =
                  FetchupdatedAdvertisementslist[0].Alternatenumber.toString();
              print("Alternate:-${Alternate}");
              Std = FetchupdatedAdvertisementslist[0].STDCode.toString();
              print("Std:-${Std}");
              Telphone =
                  FetchupdatedAdvertisementslist[0].Telephonenumber.toString();
              print("Telphone:-${Telphone}");
              MainTelphone = Std + "-" + Telphone;
              print("MainTelphone:-${MainTelphone}");
              showspinner = false;
            });

            print(
                "//////FetchupdatedAdvertisementslist/////////${FetchupdatedAdvertisementslist.length}");

            print(
                "//////FetchupdatedAdvertisementslist/////////${FetchupdatedAdvertisementslist}");
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
