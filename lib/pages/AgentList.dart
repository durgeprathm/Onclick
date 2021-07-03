import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/Fetch_Agent_Deatils.dart';
import 'package:onclickproperty/Model/AgentList.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Loan_Agent_User_Data.dart';
import 'package:onclickproperty/pages/Rental_Agent_User_Data.dart';
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';


class AgentListPage extends StatefulWidget {
  @override
  String Checkid;
  String actionid;
  String msg;
  AgentListPage(this.Checkid,this.actionid,this.msg);
  _AgentListPageState createState() => _AgentListPageState();
}

class _AgentListPageState extends State<AgentListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
bool showspinner=false;
bool showNoAgent=false;
String CITYNAME;
  List<AgentList> AgentListFetch = new List();


  getuserdata() async {
    CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    print("/////////CITYNAME/////////////////${CITYNAME}");
    _getAgentList(widget.Checkid,widget.actionid,CITYNAME);
  }


  @override
  void initState() {
    getuserdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "${widget.msg}",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
      ),
      body: SafeArea(
        child: showspinner ? Center(child: Container(child: CircularProgressIndicator())) :
        showNoAgent ?  Center(child: Container(child: Text("Agent is not available at your location.")))
         :Container(
          child: GridView.builder(
              itemCount: AgentListFetch.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Material(
                    elevation: 2,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: primarycolor,
                              backgroundImage: NetworkImage("${AgentListFetch[index].AgentImage}"),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "${AgentListFetch[index].AgentName}",
                                style: TextStyle(color: Colors.brown,),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                  "${AgentListFetch[index].AgentCity}"
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          // Expanded(
                          //   child: Center(
                          //     child: Text(
                          //         "${AgentListFetch[index].AgentAddress}"
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 2,
                          // ),
                          Expanded(
                            child: Container(
                              child: FlatButton(
                                onPressed: () {
                                  //sending to getting_loan_Agent_user_data
                                  if(widget.Checkid=="0")
                                    {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(builder: (_) {
                                      //     return GettingUserDataScreen("3",AgentListFetch[index].AgentId.toString());
                                      //   }),
                                      // );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) {
                                          return LoanAgentUserDataPage(AgentListFetch[index].AgentId.toString());
                                        }),
                                      );
                                    }
                                  //sending to getting_Rental_Agent_user_data
                                   else if(widget.Checkid=="1")
                                    {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(builder: (_) {
                                      //     return GettingUserDataScreen("4",AgentListFetch[index].AgentId.toString());
                                      //   }),
                                      // );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (_) {
                                          return RentalAgentUserDataPage("1",AgentListFetch[index].AgentId.toString());
                                        }),
                                      );
                                    }
                                },
                                child: Text("GET DETAILS",  style: TextStyle(color: Colors.white,),),
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
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              )
          ),
        ),
      ),
    );
  }


  void _getAgentList(String checkid,String actionid,String CityName) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchAgentList fetchagentlistdata =
      new FetchAgentList();
      var agentlistdata = await fetchagentlistdata
          .getFetchAgentList(checkid,actionid, CityName);
      if (agentlistdata != null) {
        var resid = agentlistdata["resid"];
        var rowcount = agentlistdata["rowcount"];

        if (resid == 200) {
          if (rowcount > 0) {
            var fetchfurnitureprodcutssd =
            agentlistdata["LoanAgent"];
            print(fetchfurnitureprodcutssd.length);
            List<AgentList> tempagentlist = [];
            for (var n in fetchfurnitureprodcutssd) {
              AgentList pro = AgentList(
                int.parse(n["id"]),
                n["name"],
                n["city"],
                n["address"],
                n["img"],
              );
              tempagentlist.add(pro);
            }
            setState(() {
              this.AgentListFetch = tempagentlist;
              showspinner = false;
            });

            print(
                "//////AgentListFetch/////////${AgentListFetch.length}");
          } else {
            setState(() {
              showNoAgent = true;
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
