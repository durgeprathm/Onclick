import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Fetch_all_List.dart';

import '../Adaptor/Fetch_Agent_Deatils.dart';
import '../Model/AgentList.dart';
import '../const/const.dart';
import 'Top_property_Buy.dart';


class CityAgentList extends StatefulWidget {
  final String cityid;
  final String cityname;

  CityAgentList(this.cityid, this.cityname);

  @override
  _CityAgentListState createState() => _CityAgentListState();
}

class _CityAgentListState extends State<CityAgentList> {

  List<AgentList> agentNameList = [];
  FetchAllLists fetchAgentList = new FetchAllLists();
  bool loader = false;
  int agenrowcount;

  @override
  void initState() {
    _getAgentNameList();
  }

  _getAgentNameList() async {
    setState(() {
      loader = true;
    });
    print(widget.cityname);
    var response = await fetchAgentList.getallTypeList(widget.cityname,"Agent");
    var resid = response["resid"];
    var rowcount = response["rowcount"];
    var agentSD = response["usernameList"];
    List<AgentList> agentNameListTemp = [];

    if(resid == 200){
      if(rowcount>0){
        for(var n in agentSD){
          AgentList agentList = new AgentList.onlybasic(int.parse(n["agentid"]), n["agentname"]);
          agentNameListTemp.add(agentList);
        }
      }
    }

    setState(() {
      agentNameList = agentNameListTemp;
      agenrowcount = rowcount;
      loader = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Agent In ${widget.cityname} ",style: TextStyle(fontSize: 18,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,color: primarycolor),),
      ),
      body: SafeArea(
        child:
        loader ? Center(child: Container(child: CircularProgressIndicator())) :
        agenrowcount > 0 ?
        Container(
            child: GridView.builder(
                itemCount: agentNameList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return TopPropertyBuy("5","1","2",agentNameList[index].AgentId.toString(),widget.cityname,"Agent");
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
                                  agentNameList[index].AgentName,
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
                                  "Agent",
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
                                          return TopPropertyBuy("5","1","2",agentNameList[index].AgentId.toString(),widget.cityname,"Agent");
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
        ) : Center(child: Container(child: Text("No agent in ${widget.cityname}"))),
      ),


    );
  }
}
