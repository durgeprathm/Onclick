import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/fetch_owner_subscription.dart';
import 'package:onclickproperty/Model/subscription_model.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/subscription/subscription_detail_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:onclickproperty/Adaptor/subscription_data_insert.dart';
import 'package:onclickproperty/Adaptor/fetch_pay_key.dart';

class AgentSubscriptionTab extends StatefulWidget {
  @override
  _AgentSubscriptionTabState createState() => _AgentSubscriptionTabState();
}

class _AgentSubscriptionTabState extends State<AgentSubscriptionTab> {
  FetchOwnerSubscription fetchOwnerSubscription = new FetchOwnerSubscription();
  List<Subscriptions> subscriptionList = [];
  int Rowcount;
  bool showspinner = false;
  Razorpay razorpay;
  String transicationID, orderID, Signiture;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String sProInofoId;
  String paymenttype = '';
  String payKey = '';

  getSPdata() async {
    setState(() {
      showspinner = true;
    });

    var response = await fetchOwnerSubscription.getOwnerSubscription("0");
    var resid = response["resid"];
    List<Subscriptions> templist = [];

    if (resid == 200) {
      int rowcount = response["rowcountagent"];
      if (rowcount > 0) {
        var providersd = response["agentsubscriptionlist"];
        for (var n in providersd) {
          Subscriptions subscriptionList = new Subscriptions(
              n["subscribeid"],
              n["subscribeforwhomid"],
              n["subscribeforwhomname"],
              n["subscribeTitle"],
              n["subscribeSubTitle"],
              n["subscribeRate"],
              n["subscribeExtraVisibility"],
              n["subscribeProfessionalAssistance"],
              n["subscribeBenefits"],
              n["subscribeUniqueFeatures"],
              n["subscribeStatus"]);
          templist.add(subscriptionList);
        }

        setState(() {
          subscriptionList = templist;
          Rowcount = rowcount;
          showspinner = false;
        });
      } else {
        setState(() {
          Rowcount = 0;
          showspinner = false;
        });
      }
    } else {
      setState(() {
        Rowcount = 0;
        showspinner = false;
      });
    }
  }

  @override
  void initState() {
    getSPdata();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
    setState(() {
      transicationID = response.paymentId.toString();
      orderID = response.orderId.toString();
      Signiture = response.signature.toString();
    });
    var now = new DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    if (paymenttype.isNotEmpty) {
      uploadSubscribeData("0", sProInofoId, formattedDate, formattedDateTime,
          "Success", transicationID, orderID, Signiture, paymenttype);
      paymenttype = '';
      // razorpay.clear();
    } else {
      uploadSubscribeData("0", sProInofoId, formattedDate, formattedDateTime,
          "Success", transicationID, orderID, Signiture, "");
      // razorpay.clear();
    }

    print("Payment Succesfull");
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message);

    var now = new DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String formattedDateTime = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    if (paymenttype.isNotEmpty) {
      uploadSubscribeData("0", sProInofoId, formattedDate, formattedDateTime,
          "Failure", "", "", "", paymenttype);
      paymenttype = '';
    } else {
      uploadSubscribeData("0", sProInofoId, formattedDate, formattedDateTime,
          "Failure", "", "", "", "");
      // razorpay.clear();
    }

    print("Payment Error");
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
    print("Payment Wallet");
    paymenttype = response.walletName;
    // razorpay.clear();
  }

  void openCheckout(String msg, String amt, String desp, String name,
      String contact, String email) {
    var options = {
      "key": payKey,
      "amount": num.parse(amt) * 100,
      "name": name,
      "description": msg,
      "prefill": {"contact": contact, "email": email},
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: showspinner
            ? Center(child: Container(child: CircularProgressIndicator()))
            : Rowcount > 0
                ? Container(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'Choose your subscription plan',
                            style: subscriptioheadingStyle,
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        Expanded(
                          child: Container(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: subscriptionList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return makeCard(subscriptionList[index]);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Container(
                        child: Text("Not available at your location."))),
      ),
    );
  }

  Card makeCard(Subscriptions subscription) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: makeListTile(subscription),
        ),
      );

  ListTile makeListTile(Subscriptions subscription) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          subscription.subscribeTitle,
          style: subsSubheadingStyle,
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(subscription.subscribeSubTitle,
                      style: TextStyle(color: Colors.black))),
            )
          ],
        ),
        trailing: Column(
          children: [
            Text(subscription.subscribeRate, style: rateheadingStyle),
            Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: kPrimaryColor,
                onPressed: () async {
                  var uName = await SharedPreferencesConstants.instance
                      .getStringValue(SharedPreferencesConstants.USERFULLNAME);
                  var uEmail = await SharedPreferencesConstants.instance
                      .getStringValue(SharedPreferencesConstants.USEREMAILID);
                  var uMobNo = await SharedPreferencesConstants.instance
                      .getStringValue(SharedPreferencesConstants.USERMOBNO);

                  var sTitle = subscription.subscribeSubTitle.toString();
                  var sRate = subscription.subscribeRate.toString();
                  sProInofoId = subscription.subscribeid.toString();

                  if (sRate != "Free") {
                    getKeydata(
                        "" + sTitle,
                        "" + sRate,
                        "" + sProInofoId,
                        "" + uName.toString(),
                        "" + uMobNo.toString(),
                        "" + uEmail.toString());
                  } else {
                    var now = new DateTime.now();
                    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
                    String formattedDateTime =
                        DateFormat('yyyy-MM-dd – kk:mm').format(now);
                    uploadSubscribeData("0", sProInofoId, formattedDate,
                        formattedDateTime, "", "", "", "", "");
                  }
                },
                child: Text(
                  'Subscribe',
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return SubscriptionDetailPage(subscription, 'agent');
            }),
          );
        },
      );

  void uploadSubscribeData(
      String sRate,
      String sProInofoId,
      String formattedDate,
      String formattedDateTime,
      String Status,
      String usertranscationid,
      String orderid,
      String signatureid,
      String paymenttype) async {
    setState(() {
      showspinner = true;
    });
    try {
      SubscriptionDataInsert subData = new SubscriptionDataInsert();
      var subscriptionData = await subData.getSubscriptionDataInsert(
          sRate,
          sProInofoId,
          formattedDate,
          formattedDateTime,
          Status,
          usertranscationid,
          orderid,
          signatureid,
          paymenttype);

      if (subscriptionData != null) {
        print("PropertyUser Data///${subscriptionData}");
        var resid = subscriptionData['resid'];
        var message = subscriptionData['message'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "" + message.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "" + message.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
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
      setState(() {
        showspinner = false;
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Some Technical Problem Plz Try Again Later"),
          backgroundColor: Colors.green,
        ));
      });
    }
  }

  getKeydata(String sTitle, String sRate, String sProInofoId, String uName,
      String uMobNo, String uEmail) async {
    setState(() {
      showspinner = true;
    });
    FetchPayKey fetchPayKey = FetchPayKey();
    var response = await fetchPayKey.getFetchPayKey("0");
    var resid = response["resid"];

    if (resid == 200) {
      int rowcount = response["rowcount"];
      if (rowcount > 0) {
        var providersd = response["FetchKey"];
        for (var n in providersd) {
          payKey = n['keyname'];
        }
        openCheckout(
            "" + sTitle,
            "" + sRate,
            "" + sProInofoId,
            "" + uName.toString(),
            "" + uMobNo.toString(),
            "" + uEmail.toString());

        setState(() {
          showspinner = false;
        });
      } else {
        setState(() {
          showspinner = false;
        });
      }
    } else {
      setState(() {
        showspinner = false;
      });
    }
  }
}
