import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/subscription/subscription_home_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Payment",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
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
                        'https://www.aaditritechnology.com/images/mobile_payment.gif',
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
                              '"Payment"',
                              style: TextStyle(
                                  color: Colors.white,
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
              Text(
                "Pay Rent With Credit Card Online",
                style: TextStyle(
                    color: primarycolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Earn money just by paying your rent!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                  color: Colors.brown,
                ),
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
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/payment-method.png'),
                            ),
                            title: Text(
                              "Earn Rewards",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              "Earn miles, get cash back and reward points on every rent payment with your card.",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                          Divider(
                            height: 5.0,
                            thickness: 1.0,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/credit-card.png'),
                            ),
                            title: Text(
                              "Pay with Credit Card",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              "We accept major cards like Visa, Mastercard and Amex so your rent payment is hassle free.",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                          Divider(
                            height: 5.0,
                            thickness: 1.0,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('images/notes.png'),
                            ),
                            title: Text(
                              "Digital Rent Receipts",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              "Generate rent receipts instantly and claim your HRA with ease. Get rent receipts sent directly to your email ID.",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.brown,
                              ),
                            ),
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
                "Process",
                style: TextStyle(
                    color: primarycolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "Follow Steps!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.0,
                  color: Colors.brown,
                ),
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
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 22.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20.0,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      color: primarycolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                            title: Text(
                              "Fill Rent Detail",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              "Provide your landlord details, and we will setup your account.",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.brown,
                              ),
                            ),
                            trailing: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('images/list_1.png'),
                            ),
                          ),
                          Divider(
                            height: 5.0,
                            thickness: 1.0,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 22.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20.0,
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      color: primarycolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                            title: Text(
                              "Make Payment",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              "Make payment through your credit card or debit card.",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.brown,
                              ),
                            ),
                            trailing: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/payment-method.png'),
                            ),
                          ),
                          Divider(
                            height: 5.0,
                            thickness: 1.0,
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: primarycolor,
                              radius: 22.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20.0,
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      color: primarycolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ),
                            ),
                            title: Text(
                              "Rent Credited!",
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            subtitle: Text(
                              "Your rent is credited to your landlord’s bank account within 2 working days!",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0,
                                color: Colors.brown,
                              ),
                            ),
                            trailing: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/transaction.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return SubscriptionHomePage();
                        }),
                      );
                    },
                    child: Text(
                      'Subscribe Now',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.white,
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
