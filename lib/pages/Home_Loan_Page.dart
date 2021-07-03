import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_bank_branch.dart';
import 'package:onclickproperty/Model/bank_branch.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Contact_Bank_Page.dart';
import 'package:onclickproperty/pages/AgentList.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/numerictextinputformatter.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class HomeLoanPage extends StatefulWidget {
  @override
  _HomeLoanPageState createState() => _HomeLoanPageState();
}

class _HomeLoanPageState extends State<HomeLoanPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<BankBranch> bankBranchList = [];
  String bankBranchId;
  bool showspinner = false;

  final _texthomeLoanAmount = TextEditingController();
  final _textNetIncomePerMonth = TextEditingController();
  final _textexistingLoan = TextEditingController();
  final _textloanTenure = TextEditingController();
  final _textrateOfInterst = TextEditingController();

  bool _homeLoanAmountValidator = false;
  bool _NetIncomePerMonthValidator = false;
  bool _loanTenureValidator = false;
  bool _rateOfInterstValidator = false;

  String _homeLoanAmount;
  String _netIncomePerMonth;
  String _texistingLoan;
  String _loanTenure;
  String _rateOfInterst;
  String _emiResult = "";
  String _emiResult1 = "";
  String _eligibilityText = '';
  var incomereq;
  bool visLoanText = false;

  @override
  void initState() {
    super.initState();
    _getFetchingBankBranch('0');
  }

  @override
  Widget build(BuildContext context) {
    final FirstField = TextField(
      controller: _texthomeLoanAmount,
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: [NumericTextFormatter()],
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.rupeeSign,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Home Loan Amount",
        errorText: _homeLoanAmountValidator ? 'Value Can\'t Be Empty' : null,
      ),
      onChanged: (value) {
        _homeLoanAmount = value;
      },
    );
    final SecondField = TextField(
      controller: _textNetIncomePerMonth,
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: [NumericTextFormatter()],
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.rupeeSign,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Net income per month",
        errorText: _NetIncomePerMonthValidator ? 'Value Can\'t Be Empty' : null,
      ),
      onChanged: (value) {
        _netIncomePerMonth = value;
      },
    );
    final ThirdField = TextField(
      controller: _textexistingLoan,
      obscureText: false,
      keyboardType: TextInputType.number,
      inputFormatters: [NumericTextFormatter()],
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.rupeeSign,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Existing loan commitments",
      ),
      onChanged: (value) {
        _texistingLoan = value;
      },
    );
    final FourthField = TextField(
      controller: _textloanTenure,
      keyboardType: TextInputType.number,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.clock,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Loan Tenure (in years)",
        errorText: _loanTenureValidator ? 'Value Can\'t Be Empty' : null,
      ),
      onChanged: (value) {
        _loanTenure = value;
      },
    );
    final FifithField = TextField(
      controller: _textrateOfInterst,
      keyboardType: TextInputType.number,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.percentage,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Rate Of Interest",
        errorText: _rateOfInterstValidator ? 'Value Can\'t Be Empty' : null,
      ),
      onChanged: (value) {
        _rateOfInterst = value;
      },
    );
    final CheckButon = FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      color: primarycolor,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      onPressed: () {
        setState(() {
          _texthomeLoanAmount.text.isNotEmpty
              ? _homeLoanAmountValidator = false
              : _homeLoanAmountValidator = true;
          _textNetIncomePerMonth.text.isNotEmpty
              ? _NetIncomePerMonthValidator = false
              : _NetIncomePerMonthValidator = true;

          _textloanTenure.text.isNotEmpty
              ? _loanTenureValidator = false
              : _loanTenureValidator = true;
          _textrateOfInterst.text.isNotEmpty
              ? _rateOfInterstValidator = false
              : _rateOfInterstValidator = true;
          bool error = (!_homeLoanAmountValidator &&
              !_homeLoanAmountValidator &&
              !_loanTenureValidator &&
              !_loanTenureValidator);

          if (error) {
            _handleCalculation();
          }
        });
      },
      child: Text("Check Eligibility",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    );
    final LoanAgentButon = FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      color: primarycolor,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) {
            return AgentListPage("0", "0", "Best Loan Agent");
          }),
        );
      },
      child: Text("Get Loan Agent Details",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    );
    final DropDownBankButon = DropdownSearch<BankBranch>(
      items: bankBranchList,
      showClearButton: true,
      showSearchBox: true,
      label: 'Bank',
      hint: "Select Bank",
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return 'This is required';
        }
      },
      dropdownSearchDecoration: InputDecoration(
        hintStyle: style,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.list,
            color: primarycolor,
          ),
        ),
        //border: OutlineInputBorder(),
      ),
      onChanged: (newValue) {
        if (newValue != null) {
          bankBranchId = newValue.bankid.toString();
          _textrateOfInterst.text = newValue.rateinterest.toString();
          _rateOfInterst = newValue.rateinterest.toString();
        } else {
          bankBranchId = null;
          _textrateOfInterst.text = '';
          _rateOfInterst = null;
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "Home Loan",
              style: appbarTitleTextStyle,
            ),
          ],
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
                    return ContactBankPage();
                  }),
                );
              },
              borderSide: BorderSide(
                color: primarycolor,
                style: BorderStyle.solid,
              ),
              child: Text("Contact To Bank",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 10.0,
                      color: primarycolor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(
                          'https://finance.advids.co/wp-content/uploads//2017/03/home-loan.gif',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 35,
                        left: 35,
                        right: 35,
                        top: 35,
                        child: Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                '"Lets find you the best bank loan deal."',
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
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: LoanAgentButon,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Calculate EMI for the loan amount you require",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: primarycolor),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Calculate your loan EMI instantly by submitting your details below",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                    color: Colors.brown,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 18.0),
                      FirstField,
                      SizedBox(height: 15.0),
                      SecondField,
                      SizedBox(height: 15.0),
                      ThirdField,
                      SizedBox(height: 15.0),
                      FourthField,
                      SizedBox(height: 15.0),
                      DropDownBankButon,
                      SizedBox(height: 15.0),
                      FifithField,
                      SizedBox(height: 15.0),
                      emiResultsWidget(_emiResult),
                      SizedBox(height: 15.0),
                      CheckButon,
                      SizedBox(
                        height: 3.0,
                      ),
                      // SizedBox(height: 15.0),
                      // ResgisterButon,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _getFetchingBankBranch(String actionid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchBankBranch fetchpropertytypedata = new FetchBankBranch();
      var fetchpropertytype =
          await fetchpropertytypedata.getFetchBankBranch(actionid);
      if (fetchpropertytype != null) {
        var resid = fetchpropertytype["resid"];
        if (resid == 200) {
          var fetchpropertytypesd = fetchpropertytype["BankList"];
          print(fetchpropertytypesd);
          print(fetchpropertytypesd.length);
          List<BankBranch> tempslist = [];
          for (var n in fetchpropertytypesd) {
            BankBranch pro = BankBranch(
              (n["bankid"]),
              n["bankname"],
              (n["rateinterest"]),
              n["processingfees"],
              (n["emi"]),
              n["date"],
            );
            tempslist.add(pro);
          }
          setState(() {
            showspinner = false;
            bankBranchList = tempslist;
          });
        } else {
          setState(() {
            showspinner = false;
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
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

  void _handleCalculation() {
    _emiResult = null;
    incomereq = null;
    _emiResult1 = null;
    //  Amortization
    //  A = Payemtn amount per period
    //  P = Initial Printical (loan amount)
    //  r = interest rate
    //  n = total number of payments or periods

    double A = 0.0;
    double A1 = 0.0;
    int P = int.tryParse(_texthomeLoanAmount.text
            .toString()
            .replaceAll(new RegExp(','), '')) ??
        0;
    double r = int.parse(_textrateOfInterst.text.toString()) / 12 / 100;
    int n = int.parse(_textloanTenure.text.toString()) * 12;
    A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));
    print('emi A: $A');
    _emiResult = A.toStringAsFixed(2);
    int existing = int.tryParse(_textexistingLoan.text
            .toString()
            .replaceAll(new RegExp(','), '')) ??
        0;
    double existingLoan = (existing - (existing * 60 / 100));
    print('existingLoan $existingLoan');

    var income1 = int.tryParse(_textNetIncomePerMonth.text
            .toString()
            .replaceAll(new RegExp(','), '')) ??
        0;
    var incomere;
    if (income1 != 0) {
      if (income1 <= 14999) {
        incomere = ((income1) * 40 / 100) - existingLoan;
      } else if (income1 <= 29999) {
        incomere = ((income1) * 45 / 100) - existingLoan;
      } else if (income1 >= 30000) {
        incomere = ((income1) * 50 / 100) - existingLoan;
      }
    }

    if (incomere != null) {
      incomereq = (incomere / A * P).floor();
    }

    print('incomereq: $incomereq');

    A1 = (incomereq * r * pow((1 + r), n) / (pow((1 + r), n) - 1));
    if (incomereq > P) {
      setState(() {
        _emiResult1 = A1.toStringAsFixed(2);
        _eligibilityText = 'You Are Eligible For This Loan';
        visLoanText = true;
      });
    } else {
      setState(() {
        _eligibilityText = 'You Are Not Eligible For This Loan';
        visLoanText = false;
      });
    }
    // _emiResult = A.toStringAsFixed(2);

    setState(() {});
  }

  Widget emiResultsWidget(emiResult) {
    bool canShow = false;
    String _emiResult = emiResult;

    if (_emiResult.length > 0) {
      canShow = true;
    }
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: canShow
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(_eligibilityText,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold)),
                    visLoanText
                        ? Container(
                            child: Text(
                                '₹ ${_texthomeLoanAmount.text.toString()} at EMI ₹ $_emiResult',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor)))
                        : Container(
                            child: Text(
                                '₹ ${_texthomeLoanAmount.text.toString()}',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(15),
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor))),
                    SizedBox(
                      height: 5,
                    ),
                    visLoanText
                        ? Container(
                            child: Text(
                                'You Are Eligible For a Maximum Loan Of',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.normal)))
                        : Container(),
                    visLoanText
                        ? Container(
                            child: Text('₹ ${incomereq} at EMI ₹ $_emiResult1',
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.normal)))
                        : Container(),
                  ])
            : Container());
  }
}
