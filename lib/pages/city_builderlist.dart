import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Fetch_Agent_Deatils.dart';
import 'package:onclickproperty/Adaptor/Fetch_all_List.dart';
import 'package:onclickproperty/Model/AgentList.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Top_property_Buy.dart';

class CityBuilderPage extends StatefulWidget {
  final String cityid;
  final String cityname;

  CityBuilderPage(this.cityid, this.cityname);

  @override
  _CityBuilderPageState createState() => _CityBuilderPageState();
}

class _CityBuilderPageState extends State<CityBuilderPage> {

  List<AgentList> builderNameList = [];
  FetchAllLists fetchBuilderList = new FetchAllLists();
  bool loader = false;
  int agenrowcount;


  @override
  void initState() {
    _getBuildersNameList();
  }

  _getBuildersNameList() async {
    setState(() {
      loader = true;
    });
    print(widget.cityname);
    var response = await fetchBuilderList.getallTypeList(widget.cityname,"Builder");
    var resid = response["resid"];
    var rowcount = response["rowcount"];
    var agentSD = response["usernameList"];
    List<AgentList> builderNameListTemp = [];

    if(resid == 200){
      if(rowcount>0){
        for(var n in agentSD){
          AgentList agentList = new AgentList.onlybasic(int.parse(n["agentid"]), n["agentname"]);
          builderNameListTemp.add(agentList);
        }
      }
    }
    setState(() {
      builderNameList = builderNameListTemp;
      agenrowcount = rowcount;
      loader = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Builders In ${widget.cityname} ",style: TextStyle(fontSize: 18,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,color: primarycolor),),
      ),
        body: SafeArea(
          child:
          loader ? Center(child: Container(child: CircularProgressIndicator())) :
          agenrowcount > 0 ?
          Container(
              child: GridView.builder(
                  itemCount: builderNameList.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return TopPropertyBuy("5","1","2",builderNameList[index].AgentId.toString(),widget.cityname,"Builder");
                            }),
                          );

                        },
                        child: Material(
                          elevation: 2,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: primarycolor,
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    builderNameList[index].AgentName,
                                    style: TextStyle(color: Colors.brown,fontSize: 18,
                                        fontFamily: 'RobotoMono',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    "Builder",
                                    style: TextStyle(color: Colors.grey,fontSize: 18,
                                        fontFamily: 'RobotoMono',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: Container(
                                    child: FlatButton(
                                      onPressed: () {

                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (_) {
                                            return TopPropertyBuy("5","1","2",builderNameList[index].AgentId.toString(),widget.cityname,"Builder");
                                          }),
                                        );

                                      },
                                      child: Text("View Property",  style: TextStyle(color: Colors.white,),),
                                      color: primarycolor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2)),
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
                    childAspectRatio: 1,
                  )
              )
          ) : Center(child: Container(child: Text("No builder in ${widget.cityname}"))),
        ),
    );
  }
}
