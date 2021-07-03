import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:onclickproperty/Adaptor/Fetch_Agent_Posted_By_User.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Model/UpdateServices.dart';
import 'package:onclickproperty/Model/UpdatedAgent.dart';
import 'package:onclickproperty/Providers/post_advertisments_provider.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Update_Advertisment_page.dart';
import 'package:onclickproperty/pages/UpdatedDetails_Loan_Page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class LoanAgentDetailsPage extends StatefulWidget {
  @override
  //String id;
  // AdvertimentDetailsPage(this.id);
   _LoanAgentDetailsPageState createState() => _LoanAgentDetailsPageState();
}

class _LoanAgentDetailsPageState extends State<LoanAgentDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  List<UpdatedAgent> FetchupdatedAgentslist = new List();
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
  List<String> LoanType = [];
  bool checkaadhar = false;
  bool checkPincode = false;
  bool checkEmail = false;

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
                          itemCount: imageList.length,
                          itemWidth: 300.0,
                          layout: SwiperLayout.DEFAULT,
                        )
                            : Text(''),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.00),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 80,
                              child: InkWell(
                                  onTap: () {
                                    // sendFavData(value, index,
                                    // value[index].Id);
                                  },
                                  child: Center(
                                    child: Container(
                                      color: FetchupdatedAgentslist[0].approve==
                                          '0'
                                          ? Colors.redAccent
                                          : Colors.green,
                                      child:
                                      new OutlineButton(
                                          child: Center(
                                            child: FetchupdatedAgentslist[0].approve ==
                                                '0'
                                                ? new Text(
                                              "Pending",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            )
                                                : new Text(
                                              "verified",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          onPressed: null,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  30.0))),
                                    ),
                                  )),
                            )
                          ],
                        ),
                        Text(
                          "Company Name",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyName != null ? FetchupdatedAgentslist[0].CompanyName : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Mobile Number:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].Companymobileno != null ? FetchupdatedAgentslist[0].Companymobileno : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Alternate Mobile Number:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyAlternetmobie != null ? FetchupdatedAgentslist[0].CompanyAlternetmobie  : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Telephone Number:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].Companytelephone != null ? FetchupdatedAgentslist[0].Companytelephone : ''}",
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
                          "${FetchupdatedAgentslist[0].CompanyEmail != null ? FetchupdatedAgentslist[0].CompanyEmail : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Location:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyLocation != null ? FetchupdatedAgentslist[0].CompanyLocation : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Address:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyAddreess != null ? FetchupdatedAgentslist[0].CompanyAddreess : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company City:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyCity != null ? FetchupdatedAgentslist[0].CompanyCity : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Pincode:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyPincode != null ? FetchupdatedAgentslist[0].CompanyPincode : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Decription:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyDescription != null ? FetchupdatedAgentslist[0].CompanyDescription : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Year OF Establishment",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].Companyyear != null ? FetchupdatedAgentslist[0].Companyyear : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Number Of Employee",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyNoEmp != null ? FetchupdatedAgentslist[0].CompanyNoEmp  : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                            height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Company Website",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].CompanyWebsite != null ? FetchupdatedAgentslist[0].CompanyWebsite  : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                            height: SizeConfig.screenHeight * 0.03),

                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].name != null ? FetchupdatedAgentslist[0].name : ''}",
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
                          "${FetchupdatedAgentslist[0].mobileno != null ? FetchupdatedAgentslist[0].mobileno : ''}",
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
                          "${FetchupdatedAgentslist[0].alternateno != null ? FetchupdatedAgentslist[0].alternateno  : ''}",
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
                          "${FetchupdatedAgentslist[0].telephoneno != null ? FetchupdatedAgentslist[0].telephoneno : ''}",
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
                          "${FetchupdatedAgentslist[0].email != null ? FetchupdatedAgentslist[0].email : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Location:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].servclocation != null ? FetchupdatedAgentslist[0].servclocation : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Address:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].address != null ? FetchupdatedAgentslist[0].address : ''}",
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
                          "${FetchupdatedAgentslist[0].city != null ? FetchupdatedAgentslist[0].city : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Pincode:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].pincode != null ? FetchupdatedAgentslist[0].pincode : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Bank Name:",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].bankname != null ? FetchupdatedAgentslist[0].bankname : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Rate Of Interest",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "${FetchupdatedAgentslist[0].rateofinterest != null ? FetchupdatedAgentslist[0].rateofinterest : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        Text(
                          "Loan Type",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        // ListView.builder(
                        //     itemCount: FetchupdatedAgentslist[0].loantype.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return const Center(
                        //           child: Text("${FetchupdatedAgentslist[index].loantype != null ? FetchupdatedAgentslist[index].loantype  : ''}"));
                        //     }),
                        Text(
                          "${FetchupdatedAgentslist[0].loantype != null ? FetchupdatedAgentslist[0].loantype  : ''}",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                            height: SizeConfig.screenHeight * 0.03),
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
                                      return UpdatedLoanAgent();
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
    _getservicesdata();

  }

  void _getservicesdata() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchUserPostedLoanAgent fetchupdatlist = new FetchUserPostedLoanAgent();
      var fetchupdatedsdata =
      await fetchupdatlist.getFetchUserPostedLoanAgentt("0","");
      if (fetchupdatedsdata != null) {
        var resid = fetchupdatedsdata["resid"];
        var rowcount = fetchupdatedsdata["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchupdatedsdatasd = fetchupdatedsdata["LoanAgent"];
            print(fetchupdatedsdatasd.length);
            List<UpdatedAgent> tempfetchupdatedlist = [];
            for (var n in fetchupdatedsdatasd) {
              UpdatedAgent pro = UpdatedAgent.Loan(
                n["id"],
                n["uid"],
                n["CompanyName"],
                n["Companymobileno"],
                n["CompanyAlternetmobie"],
                n["companystd"],
                n["Companytelephone"],
                n["CompanyEmail"],
                n["CompanyLocation"],
                n["CompanyCity"],
                n["Companylat"],
                n["Companylong"],
                n["CompanyDescription"],
                n["CompanyAddreess"],
                n["CompanyPincode"],
                n["Companyyear"],
                n["CompanyNoEmp"],
                n["CompanyWebsite"],
                n["name"],
                n["mobileno"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
                n["email"],
                n["city"],
                n["pincode"],
                n["servclocation"],
                n["lat"],
                n["long"],
                n["address"],
                n["bankname"],
                n["rateofinterest"],
                n["loantype"],
                n["date"],
                n["approve"],
                n["img"],
              );
              tempfetchupdatedlist.add(pro);
            }
            setState(() {
              this.FetchupdatedAgentslist = tempfetchupdatedlist;
              imageList = FetchupdatedAgentslist[0].Image.split("#");
              print("imageList:-${imageList}");
              LoanType=FetchupdatedAgentslist[0].loantype.split("#");
              showspinner = false;

            });

            print(
                "//////FetchupdatedAgentslist/////////${FetchupdatedAgentslist.length}");

            print(
                "//////FetchupdatedAgentslist/////////${FetchupdatedAgentslist}");
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
