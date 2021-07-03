import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/subscription/agent_subscription_tab_page.dart';
import 'package:onclickproperty/pages/subscription/builder_subscription_tab_page.dart';
import 'package:onclickproperty/pages/subscription/owner_subscription_tab_page.dart';

class SubscriptionHomePage extends StatefulWidget {
  @override
  _SubscriptionHomePageState createState() => _SubscriptionHomePageState();
}

class _SubscriptionHomePageState extends State<SubscriptionHomePage> {
  bool _showProgressBar = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "Subscriptions",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: primarycolor,
              ),
            ),
            bottom: TabBar(
              labelColor: primarycolor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: primarycolor,
              tabs: [
                Tab(
                  text: 'Owner ',
                ),
                Tab(text: 'Agent'),
                Tab(text: 'Builder'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OwnerSubscriptionTab(),
              AgentSubscriptionTab(),
              BuilderSubscriptionTab(),
            ],
          ),
        ));

  }
}
