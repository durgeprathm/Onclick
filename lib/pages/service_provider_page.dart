import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/Adaptor/fetch_serviceprovider.dart';
import 'package:onclickproperty/Model/serviceprovidermodel.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Homer_service_User_Data.dart';
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';

class ServiceProviderList extends StatefulWidget {
  final String serviceid;
  final String servicename;
  final String serviceIcon;

  ServiceProviderList(this.serviceid, this.servicename, this.serviceIcon);

  @override
  _ServiceProviderListState createState() => _ServiceProviderListState();
}

class _ServiceProviderListState extends State<ServiceProviderList> {
  FetchServiceProvider fetchServiceProvider = new FetchServiceProvider();
  List<ServiceProvider> serviceProvider = [];
  int Rowcount;
  bool loader = false;

  getSPdata() async {
    setState(() {
      loader = true;
    });

    var CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    var response = await fetchServiceProvider.getserviceProviders(
        "0", CITYNAME, widget.serviceid);
    print(response);
    var resid = response["resid"];
    var rowcount = response["rowcount"];
    var providersd = response["serviceproviderList"];
    List<ServiceProvider> serviceProviderTemp = [];

    if (resid == 200) {
      if (rowcount > 0) {
        for (var n in providersd) {
          ServiceProvider serviceProvider = new ServiceProvider(
              n["serviceproviderid"],
              n["servicename"],
              n["serviceprovidercity"],
              n["serviceproviderno"]);
          serviceProviderTemp.add(serviceProvider);
        }
      }
    }

    setState(() {
      serviceProvider = serviceProviderTemp;
      Rowcount = rowcount;
      loader = false;
    });
  }

  @override
  void initState() {
    getSPdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          widget.servicename,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
      ),
      body: SafeArea(
        child: loader
            ? Center(child: Container(child: CircularProgressIndicator()))
            : Rowcount > 0
                ? Container(
                    child: GridView.builder(
                        itemCount: serviceProvider.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Material(
                              elevation: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: primarycolor,
                                        backgroundImage:
                                            AssetImage(widget.serviceIcon),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: Text(
                                        widget.servicename,
                                        style: TextStyle(
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child:
                                          Text(serviceProvider[index].spname),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child:
                                          Text(serviceProvider[index].spcity),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (_) {
                                                return
                                                    // GettingUserDataScreen(
                                                    //   "5",
                                                    //   serviceProvider[index]
                                                    //       .spid
                                                    //       .toString());
                                                    HomeServiceUserDataPage(
                                                        serviceProvider[index]
                                                            .spid
                                                            .toString());
                                              }),
                                            );
                                          },
                                          child: Text(
                                            "GET DETAILS",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          color: primarycolor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                        )),
                  )
                : Center(
                    child: Container(
                        child: Text(
                            "Service Provider is not available at your location."))),
      ),
    );
  }
}
