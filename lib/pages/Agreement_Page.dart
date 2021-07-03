import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/AgentList.dart';
import 'package:onclickproperty/pages/Register_As_Rental_Agent.dart';
import 'package:onclickproperty/pages/agreement/post_agreement_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class AgreeMentPage extends StatefulWidget {
  @override
  _AgreeMentPageState createState() => _AgreeMentPageState();
}

class _AgreeMentPageState extends State<AgreeMentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Agreement",
          style: appbarTitleTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return RegisterAsRentalAgent();
                  }),
                );
              },
              borderSide: BorderSide(
                color: primarycolor,
                style: BorderStyle.solid,
              ),
              child: Text("Post Agreement",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: getProportionateScreenWidth(10),
                      color: primarycolor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://designproficient.com/blog/wp-content/uploads/2018/04/zgxeffs69ust88rguub5.gif',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      top: 35,
                      left: 35,
                      right: 35,
                      child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              '"Search For Best Rental Agreement Service Provider Here."',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(56),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: kPrimaryColor,
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (_) {
                      //     return AgentListPage("1","1","Best Rental Agent");
                      //   }),
                      // );
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return AgentListPage("1","1","Best Rental Agent");
                        }),
                      );
                    },
                    child: Text(
                      'Get Rental Agent Details',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "How It Works",
                style: TextStyle(
                    color: primarycolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Create rental agreement online",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('images/student.png'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Either the owner or the tenant fills in the required information. An Rental agreement is created online using this information.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Register with comfort at Home",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/smartphone.png'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "An appointment for registration is scheduled. Our team visits your home on the scheduled day and the biometric registration is done at home where owner, tenant and two witnesses will be available in same place. This service is available on all days of the week and can be availed on Sundays too!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "Easy Home Delivery",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('images/home-delivery.png'),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Within 3-4 working days the hard copy of the/your e-stamped rental agreement is delivered to your doorstep. And what's more? You don't even need to step out of home!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                " Frequently Asked Question ?",
                style: TextStyle(
                    color: primarycolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(radius: 20, child: Text("1")),
                            title: Text(
                              "What Is e-registration Of Leave And License (Rent) Agreement?",
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(radius: 20, child: Text("2")),
                            title: Text(
                              "How Many Days Does It Take For Rent Agreement To Get Registered?",
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(radius: 20, child: Text("3")),
                            title: Text(
                              "How Many Witness Are Required For The Process?",
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  elevation: 5.0,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(radius: 20, child: Text("4")),
                            title: Text(
                              "What Are The Pre-Requisites To Avail E-Registration Facility?",
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
