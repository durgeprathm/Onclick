import 'package:flutter/material.dart';
import 'package:onclickproperty/Model/subscription_model.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class SubscriptionDetailPage extends StatefulWidget {
  final Subscriptions subscription;
  final String tabType;

  SubscriptionDetailPage(this.subscription, this.tabType);

  @override
  _SubscriptionDetailPageState createState() =>
      _SubscriptionDetailPageState(this.subscription, this.tabType);
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  final Subscriptions subscription;
  final String tabType;

  _SubscriptionDetailPageState(this.subscription, this.tabType);

  bool visOwnerData = false;

  @override
  void initState() {
    super.initState();
    if (tabType == 'owner') {
      setState(() {
        visOwnerData = true;
      });
    } else {
      setState(() {
        visOwnerData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Subscription Details",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
      ),
      body: Container(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text('${subscription.subscribeTitle}',
                      style: subsDetailsheadingStyle),
                  Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Text(
                            subscription.subscribeRate,
                            style: rateheadingStyle,
                          )),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: kPrimaryColor,
                        onPressed: () {},
                        child: Text(
                          'Subscribe',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Visibility(
                    visible: visOwnerData,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Extra Visibility:',
                          style: extraVisiheadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            subscription.subscribeExtraVisibility,
                            style: extraVisiDetailsheadingStyle,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Professional Assistance:',
                          style: extraVisiheadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            subscription.subscribeProfessionalAssistance,
                            style: extraVisiDetailsheadingStyle,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        SizedBox(height: SizeConfig.screenHeight * 0.05),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !visOwnerData,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Benefits:',
                          style: extraVisiheadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            subscription.subscribeBenefits,
                            style: extraVisiDetailsheadingStyle,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Unique Features:',
                          style: extraVisiheadingStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            subscription.subscribeUniqueFeatures,
                            style: extraVisiDetailsheadingStyle,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.08),
                        SizedBox(height: SizeConfig.screenHeight * 0.05),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
