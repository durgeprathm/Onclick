import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_allcity.dart';
import 'package:onclickproperty/Model/CityList.dart';
import 'package:onclickproperty/pages/Top_property_Buy.dart';
import 'package:onclickproperty/pages/city_agentlistpage.dart';
import 'package:onclickproperty/pages/city_builderlist.dart';
import 'package:onclickproperty/pages/city_ownerlist.dart';

import '../const/const.dart';


class CityListPage extends StatefulWidget {
  final String PageCheckId;

  CityListPage(this.PageCheckId);

  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {

  AllCityList allCityList = new AllCityList();
  List<CityList> cityList = [];
  int citycount;
  bool loader = false;

  _getCityNameList() async {
    setState(() {
      loader = true;
    });
    var response = await allCityList.getallCityname("0");
    var resid = response["resid"];
    var rowcount = response["rowcount"];
    var citysd = response["topcitynameList"];

    List<CityList> cityListTemp = [];
    if(resid == 200){
      if(rowcount > 0){
        for(var n in citysd){
          CityList cityList = new CityList(n["cityid"],n["cityname"]);
          cityListTemp.add(cityList);
        }

      }
    }
    setState(() {
      cityList = cityListTemp;
      citycount = rowcount;
      loader = false;
    });
  }

  @override
  void initState() {
    _getCityNameList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Cities",style: TextStyle(fontSize: 18,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,color: primarycolor),),
      ),
      body: SafeArea(
        child: loader ? Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ) :
        citycount > 0 ?
        Container(
          child: GridView.builder(
            itemCount: cityList.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  if(widget.PageCheckId == "0"){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return CityAgentList(cityList[index].cityid,cityList[index].cityname);
                      }),
                    );
                  }else  if(widget.PageCheckId == "1"){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return CityBuilderPage(cityList[index].cityid,cityList[index].cityname);
                      }),
                    );

                  }else  if(widget.PageCheckId == "2") {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return CityOwnerListPage(cityList[index].cityid,cityList[index].cityname);
                      }),
                    );


                  }else  if(widget.PageCheckId == "3") {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return TopPropertyBuy("6","1","3","",cityList[index].cityname,"");
                      }),
                    );
                  }
                },
                child: Material(
                  elevation: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: primarycolor,
                            child: FaIcon(
                              FontAwesomeIcons.city,
                              color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              cityList[index].cityname,
                              style: TextStyle(color: Colors.brown,fontSize: 18,
                                  fontFamily: 'RobotoMono',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
          )
          )
        ): Text("Cities not available"),
      ),
    );
  }
}
