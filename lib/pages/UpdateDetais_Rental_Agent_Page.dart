import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Fetch_Agent_Posted_By_User.dart';
import 'package:onclickproperty/Adaptor/Register_As_Rental_Agent_Data_Update.dart';
import 'package:onclickproperty/Model/UpdatedAgent.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class UpdatedRentalAgentDetails extends StatefulWidget {
  @override
  _UpdatedRentalAgentDetailsState createState() =>
      _UpdatedRentalAgentDetailsState();
}

final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

String _CompanyName;
String _CompanyMobNo;
String _CompanyEmail;
String _CompanyAddress;
String _CompanyPincode;
String _CompanyNoEmps;
String _CompanyWebSite;
String _Companylat;
String _Companylong;
String _CompanyCity;
String _CompanyDescription;

String _WorkEmail;
String _DescriptionOfYourAd;
String _Name;
String _address;
String _pincode;
String _MobileNo;
String _CompanyLocation;
String _ServiceLocation;
String _Servicelat;
String _Servicelong;
File images;
List<File> listfile = [];
bool showspinner = false;
String _selectdate;
String UID;
var uuid = new Uuid();
String _sessionToken;
List<dynamic> _placeList = [];
String lat;
String long;
bool showPlaceList = false;
List<String> LoanList = [];
String CompanyAlternatNumber;
String CompanyStdCode;
String CompanyTelephoneNumber;
String AlternatNumber;
String StdCode;
String TelephoneNumber;
String imageslink;
bool checkserverimage = false;

List<String> _city = [
  'Mumbai',
  'Thane',
  'Nagpur',
  'Navi Mumbai',
  'Aurangabad',
];
String _selectedCity;
List<String> _Category = [
  'Rent',
  'Sell',
  'Both',
];
String _selectedCategory;

List<String> _RegistrationType = [
  'Online',
  'Offline (Registry Office)',
  'Both',
];
String _selectedRegistrationType;

List<String> _ProvideService = ['Yes', 'No'];
String _selectedProvideService;

TextEditingController _textCompanyName = TextEditingController();
TextEditingController _textCompanyMobNo = TextEditingController();
TextEditingController _textCompanyEmail = TextEditingController();
TextEditingController _textCompanyLocation = TextEditingController();
TextEditingController _textCompanyDescriptionOfYourAd = TextEditingController();
TextEditingController _textCompanyAddress = TextEditingController();
TextEditingController _textCompanyPincode = TextEditingController();
TextEditingController _textCompanyNoEmp = TextEditingController();
TextEditingController _textCompanyWebSite = TextEditingController();
TextEditingController _textDescriptionOfYourAd = TextEditingController();
TextEditingController _textName = TextEditingController();
TextEditingController _textServiceAddress = TextEditingController();
TextEditingController _textServicePincode = TextEditingController();
TextEditingController _textMobileNo = TextEditingController();
TextEditingController _textServiceLocation = TextEditingController();
TextEditingController _textWorkEmail = TextEditingController();
TextEditingController _textCompanyAlternatenumber = TextEditingController();
TextEditingController _textCompanyStdCode = TextEditingController();
TextEditingController _textCompanyTelephonenumber = TextEditingController();
TextEditingController _textAlternatenumber = TextEditingController();
TextEditingController _textStdCode = TextEditingController();
TextEditingController _textTelephonenumber = TextEditingController();
TextEditingController _textCategory = TextEditingController();
TextEditingController _textRegistrationtype = TextEditingController();
TextEditingController _textprovidecustomer = TextEditingController();

class _UpdatedRentalAgentDetailsState extends State<UpdatedRentalAgentDetails> {
  @override
  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("User ID:- ${UID}");
  }

  String PossessionDate;
  DateTime sDateTime;
  List<UpdatedAgent> FetchupdatedAgentslist = new List();
  @override
  void initState() {
    getUserdata();
    _getservicesdata();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    print("Date:-${_selectdate}");
    final DateTime now = DateTime.now();
    sDateTime = now;
    PossessionDate = DateFormat('yyyy').format(sDateTime);
  }

  Widget build(BuildContext context) {
    final List<CoolStep> steps = [
      CoolStep(
        title: "Agreement",
        subtitle: "Business Information",
        content: Form(
          key: _formKey2,
          child: Column(
            children: <Widget>[
              companyName(),
              companyMobileNo(),
              companyAlternateNo(),
              companyTelephoneNo(),
              companyEmail(),
              CompanyLocation(),
              companydescription(),
              companyAddress(),
              Companypincode(),
              CompanyEstabilishDate(),
              companyNoOfEmployees(),
              companyWebsite(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey2.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
      CoolStep(
        title: "Agreement",
        subtitle: "Service Provider Details",
        content: Form(
          key: _formKey1,
          child: Column(
            children: <Widget>[
              name(),
              mobileNo(),
              AlternateNo(),
              TelephoneNo(),
              workEmail(),
              description(),
              ServiceLocationProvider(),
              serviceaddress(),
              pincode(),
              Category(),
              RegistrationType(),
              ProvideService(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey1.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
      CoolStep(
        title: "Agreement",
        subtitle: "Company Image",
        content: Form(
          key: _formKey3,
          child: Column(
            children: <Widget>[CompanyIMage()],
          ),
        ),
        validation: () {
          if (!_formKey3.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
    ];

    final stepper = CoolStepper(
      onCompleted: () {
        print("_CompanyName:-${_CompanyName}");
        print("_CompanyMobNo:-${_CompanyMobNo}");
        print("_CompanyEmail:-${_CompanyEmail}");
        print("_CompanyAddress:-${_CompanyAddress}");
        print("_CompanyPincode:-${_CompanyPincode}");
        print("_CompanyNoEmps:-${_CompanyNoEmps}");
        print("_CompanyWebSite:-${_CompanyWebSite}");
        print("_CompanyLocation:-${_CompanyLocation}");
        print("_Companylat:-${_Companylat}");
        print("_Companylong:-${_Companylong}");
        print("_CompanyCity:-${_CompanyCity}");
        print("_CompanyDescription:-${_CompanyDescription}");
        print("_CompanyYear:-${PossessionDate}");

        print("Your Name:-${_Name}");
        print("Mobile No:-${_MobileNo}");
        print("Work Email:-${_WorkEmail}");
        print("City:-${_selectedCity}");
        print("Description:-${_DescriptionOfYourAd}");
        print("Service Location:-${_ServiceLocation}");
        print("_Servicelat:-${_Servicelat}");
        print("_Servicelong:-${_Servicelong}");
        print("Address:-${_address}");
        print("_pincode:-${_pincode}");
        print("Category:-${_selectedCategory}");
        print("Registration Type:-${_selectedRegistrationType}");
        print("Provide Service:-${_selectedProvideService}");
        print("images:-${listfile}");
        print("User ID:- ${UID}");
        print("Date:-${_selectdate}");
        print("CompanyAlternatNumber:-${CompanyAlternatNumber}");
        print("CompanyStdCode:- ${CompanyStdCode}");
        print("CompanyTelephoneNumber:-${CompanyTelephoneNumber}");

        print("AlternatNumber:-${AlternatNumber}");
        print("StdCode:- ${StdCode}");
        print("TelephoneNumber:-${TelephoneNumber}");
        print("===============imageslink======================");
        print(imageslink);

        _getRegisterAsRentalAgentData(
            checkserverimage == null ? '0' : '1',
            listfile,
            checkserverimage == null ? '' : imageslink,
            UID,
            _Name,
            _MobileNo,
            _WorkEmail,
            _selectedCity,
            _ServiceLocation,
            _CompanyName,
            _address,
            _DescriptionOfYourAd,
            _selectedCategory,
            _selectedRegistrationType,
            _selectedProvideService,
            _selectdate,
            _CompanyName,
            _CompanyMobNo,
            _CompanyEmail,
            _CompanyLocation,
            _CompanyCity,
            _Companylat,
            _Companylong,
            _CompanyDescription,
            _CompanyAddress,
            _CompanyPincode,
            PossessionDate,
            _CompanyNoEmps,
            _CompanyWebSite != null ? _CompanyWebSite.toString() : '',
            _Servicelat != null ? _Servicelat.toString() : '',
            _Servicelong != null ? _Servicelong.toString() : '',
            _pincode != null ? _pincode.toString() : '',
            CompanyAlternatNumber != null
                ? CompanyAlternatNumber.toString()
                : '',
            CompanyStdCode != null ? CompanyStdCode.toString() : '',
            CompanyTelephoneNumber != null
                ? CompanyTelephoneNumber.toString()
                : '',
            AlternatNumber != null ? AlternatNumber.toString() : '',
            StdCode != null ? StdCode.toString() : '',
            TelephoneNumber != null ? TelephoneNumber.toString() : '');

        print("Steps completed!");
      },
      steps: steps,
      config: CoolStepperConfig(
        backText: "PREV",
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Post Agreement"),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: stepper,
            ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: TextFormField(
              controller: _textName,
              keyboardType: TextInputType.text,
              validator: fullNameValidate,
              onSaved: (String value) {
                _textName.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Name = newValue;
                  print("Your Name:-${_Name}");
                });
              },
              decoration: InputDecoration(
                  labelText: "Full Name",
                  hintText: "Enter Full Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          )
        ],
      ),
    );
  }

  Padding mobileNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: TextFormField(
              controller: _textMobileNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(10),
              ],
              validator: validateMobile,
              onSaved: (String value) {
                _textMobileNo.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _MobileNo = newValue;
                  print("Mobile No:-${_MobileNo}");
                });
              },
              decoration: InputDecoration(
                  labelText: "Mobile No.",
                  hintText: "Enter Mobile No.",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          )
        ],
      ),
    );
  }

  Padding workEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: TextFormField(
              controller: _textWorkEmail,
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
              onSaved: (String value) {
                _textWorkEmail.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _WorkEmail = newValue;
                  print("Work Email:-${_WorkEmail}");
                });
              },
              decoration: InputDecoration(
                  labelText: "Work Email",
                  hintText: "Enter Work Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          )
        ],
      ),
    );
  }

  Padding serviceaddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'City',
          //       style: style,
          //     ),
          //     value: _selectedCity,
          //     decoration: InputDecoration(
          //       prefixIcon: Padding(
          //         padding:
          //             const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.list,
          //           color: primarycolor,
          //         ),
          //       ),
          //     ),
          //     validator: (value) {
          //       if (value == null) {
          //         return 'This is required';
          //       }
          //     },
          //     onChanged: (newValue) {
          //       setState(
          //         () {
          //           _selectedCity = newValue;
          //           print("City:-${_selectedCity}");
          //         },
          //       );
          //     },
          //     items: _city.map((face) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           face,
          //           style: kTextStyleForContent,
          //         ),
          //         value: face,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),

          TextFormField(
            controller: _textServiceAddress,
            keyboardType: TextInputType.text,
            maxLines: 2,
            onSaved: (String value) {
              _address = value;
            },
            validator: (String value) {
              if (value.isEmpty) {
                return 'This is required';
              }
            },
            onChanged: (newValue) {
              setState(() {
                _address = newValue;
              });
            },
            decoration: InputDecoration(
                labelText: "Service Address",
                hintText: "Enter service Address",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Padding pincode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textServicePincode,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              new LengthLimitingTextInputFormatter(6),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            onSaved: (String value) {
              _pincode = value;
            },
            onChanged: (newValue) {
              setState(() {
                _pincode = newValue;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Pincode";
              } else if (value.length > 6) {
                return "Enter valide Pincode";
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "Service Address Pincode",
                hintText: "Enter Service Address Pincode",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Padding companydescription() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: TextFormField(
          //     controller: _textCompanyDescriptionOfYourAd,
          //     keyboardType: TextInputType.multiline,
          //     maxLength: 1000,
          //     maxLines: 3,
          //     decoration: InputDecoration(
          //       prefixIcon: Padding(
          //         padding:
          //             const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.audioDescription,
          //           color: primarycolor,
          //         ),
          //       ),
          //       hintText: 'Description',
          //       hintStyle: style,
          //     ),
          //     validator: (String value) {
          //       if (value.isEmpty) {
          //         return 'This is required';
          //       }
          //     },
          //     onSaved: (String value) {
          //       _textCompanyDescriptionOfYourAd.text = value;
          //     },
          //     onChanged: (newValue) {
          //       setState(() {
          //         _DescriptionOfYourAd = newValue;
          //         print("Description of your ad:-${_DescriptionOfYourAd}");
          //       });
          //     },
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyDescriptionOfYourAd,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textCompanyDescriptionOfYourAd.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _CompanyDescription = newValue;
                  print("Description of your ad:-${_CompanyDescription}");
                });
              },
              decoration: InputDecoration(
                  labelText: "Company description",
                  hintText: "Enter your Company Description",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          )
        ],
      ),
    );
  }

  Padding description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: TextFormField(
          //     controller: _textCompanyDescriptionOfYourAd,
          //     keyboardType: TextInputType.multiline,
          //     maxLength: 1000,
          //     maxLines: 3,
          //     decoration: InputDecoration(
          //       prefixIcon: Padding(
          //         padding:
          //             const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.audioDescription,
          //           color: primarycolor,
          //         ),
          //       ),
          //       hintText: 'Description',
          //       hintStyle: style,
          //     ),
          //     validator: (String value) {
          //       if (value.isEmpty) {
          //         return 'This is required';
          //       }
          //     },
          //     onSaved: (String value) {
          //       _textCompanyDescriptionOfYourAd.text = value;
          //     },
          //     onChanged: (newValue) {
          //       setState(() {
          //         _DescriptionOfYourAd = newValue;
          //         print("Description of your ad:-${_DescriptionOfYourAd}");
          //       });
          //     },
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textDescriptionOfYourAd,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textDescriptionOfYourAd.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _DescriptionOfYourAd = newValue;
                  print("Description of your ad:-${_DescriptionOfYourAd}");
                });
              },
              decoration: InputDecoration(
                  labelText: "description",
                  hintText: "Description",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          )
        ],
      ),
    );
  }

  Padding companyAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textCompanyAddress,
            keyboardType: TextInputType.text,
            maxLines: 2,
            validator: (String value) {
              if (value.isEmpty) {
                return 'This is required';
              }
            },
            onSaved: (newValue) => _CompanyAddress = newValue,
            onChanged: (value) {
              setState(() {
                _CompanyAddress = value;
              });
            },
            decoration: InputDecoration(
                labelText: "Company Address",
                hintText: "Enter Company Address",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Padding Companypincode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textCompanyPincode,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              new LengthLimitingTextInputFormatter(6),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            onSaved: (newValue) => _CompanyPincode = newValue,
            onChanged: (value) {
              setState(() {
                _CompanyPincode = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Pincode";
              } else if (value.length > 6) {
                return "Enter valide Pincode";
              }
              return null;
            },
            decoration: InputDecoration(
                labelText: "Company Address Pincode",
                hintText: "Enter Company Address Pincode",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Padding CompanyEstabilishDate() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        )),
        child: TextFormField(
            // validator: (String value) {
            //   if (value.isEmpty) {
            //     return 'This is required';
            //   }
            // },
            readOnly: true,
            decoration: InputDecoration(
                labelText: 'Company Establishment Year',
                hintText: PossessionDate != null ? PossessionDate : '',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.black87),
                labelStyle: TextStyle(color: Colors.black54),
                suffixIcon: Icon(
                  Icons.calendar_today,
                  color: primarycolor,
                )),
            onTap: () {
              var sheetController = _scaffoldKey.currentState.showBottomSheet(
                  (context) => BottomSheetWidget(getEstablishDate));
              sheetController.closed.then((value) {
                print("closed");
                print("$value");
              });
              // handleReadOnlyInputClick(context);
            }),
      ),
    );
  }

  Padding companyNoOfEmployees() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textCompanyNoEmp,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              new LengthLimitingTextInputFormatter(10),
            ],
            keyboardType: TextInputType.numberWithOptions(decimal: false),
            validator: (String value) {
              if (value.isEmpty) {
                return 'This is required';
              }
            },
            onSaved: (newValue) => _CompanyNoEmps = newValue,
            onChanged: (value) {
              setState(() {
                _CompanyNoEmps = value;
              });
            },
            decoration: InputDecoration(
                labelText: "No Of Employees",
                hintText: "Enter No Of Employees",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Padding companyWebsite() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textCompanyWebSite,
            keyboardType: TextInputType.url,
            onSaved: (newValue) => _CompanyWebSite = newValue,
            onChanged: (value) {
              setState(() {
                _CompanyWebSite = value;
              });
            },
            decoration: InputDecoration(
                labelText: "Website",
                hintText: "Enter Website",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Padding companyName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: TextFormField(
          //     controller: _textCompanyName,
          //     keyboardType: TextInputType.text,
          //     decoration: InputDecoration(
          //       prefixIcon: Padding(
          //         padding:
          //             const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.industry,
          //           color: primarycolor,
          //         ),
          //       ),
          //       hintText: 'Company Name',
          //       hintStyle: style,
          //     ),
          //     validator: (String value) {
          //       if (value.isEmpty) {
          //         return 'This is required';
          //       }
          //     },
          //     onSaved: (String value) {
          //       _textCompanyName.text = value;
          //     },
          //     onChanged: (newValue) {
          //       setState(() {
          //         _CompanyName = newValue;
          //         print("Company Name:-${_CompanyName}");
          //       });
          //     },
          //   ),
          // ),

          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Company Name",
                  hintText: "Enter Company Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textCompanyName.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _CompanyName = newValue;
                  print("Company Name:-${_CompanyName}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding companyMobileNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyMobNo,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(10),
              ],
              onSaved: (newValue) => _CompanyMobNo = newValue,
              onChanged: (value) {
                setState(() {
                  _CompanyMobNo = value;
                });
              },
              decoration: InputDecoration(
                  labelText: "Mobile No.",
                  hintText: "Enter Mobile No.",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }

  Padding companyAlternateNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyAlternatenumber,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(10),
              ],
              onSaved: (newValue) => CompanyAlternatNumber = newValue,
              onChanged: (value) {
                setState(() {
                  CompanyAlternatNumber = value;
                });
              },
              decoration: InputDecoration(
                  labelText: "Alternate Mobile No.",
                  hintText: "Alternate Mobile No.",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }

  Padding companyTelephoneNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _textCompanyStdCode,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    onSaved: (newValue) => CompanyStdCode = newValue,
                    onChanged: (value) {
                      setState(() {
                        CompanyStdCode = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "STD Code",
                        hintText: "STD Code",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.black87)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 25,
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _textCompanyTelephonenumber,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    onSaved: (newValue) => CompanyTelephoneNumber = newValue,
                    onChanged: (value) {
                      setState(() {
                        CompanyTelephoneNumber = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Telephone No.",
                        hintText: "Telephone No.",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.black87)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding AlternateNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textAlternatenumber,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                new LengthLimitingTextInputFormatter(10),
              ],
              onSaved: (newValue) => AlternatNumber = newValue,
              onChanged: (value) {
                setState(() {
                  AlternatNumber = value;
                });
              },
              decoration: InputDecoration(
                  labelText: "Alternate Mobile No.",
                  hintText: "Alternate Mobile No.",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }

  Padding TelephoneNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _textStdCode,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    onSaved: (newValue) => StdCode = newValue,
                    onChanged: (value) {
                      setState(() {
                        StdCode = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "STD Code",
                        hintText: "STD Code",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.black87)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 25,
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    controller: _textTelephonenumber,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      new LengthLimitingTextInputFormatter(10),
                    ],
                    onSaved: (newValue) => TelephoneNumber = newValue,
                    onChanged: (value) {
                      setState(() {
                        TelephoneNumber = value;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: "Telephone No.",
                        hintText: "Telephone No.",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.black87)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding companyEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: TextFormField(
                controller: _textCompanyEmail,
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => _CompanyEmail = newValue,
                onChanged: (value) {
                  setState(() {
                    _CompanyEmail = value;
                    print("Company Name:-${_CompanyName}");
                  });
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black87)),
              )),
        ],
      ),
    );
  }

  Padding CompanyIMage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Company Logo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        RaisedButton(
                            color: Colors.blue,
                            child: new Text(
                              "Choose Logo",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                             /* File result = await FilePicker.getFile(
                                  type: FileType.image);*/
                              FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
                              if (result != null) {
                                setState(() {
                                  print("inside if in image picker");
                                  listfile.clear();
                                  images = File(result.paths[0]);
                                  listfile.add(images);
                                  print(
                                      "inside////listfile/////////////////${listfile}");
                                  print("inside////images///////////${images}");
                                });
                              } else {
                                print("inside else in image picker");
                              }
                              // print("Inside Pressed Button $images");
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    child: checkserverimage != null
                        ? Stack(
                            children: [
                              Center(
                                child: Image.network(imageslink !=null ? imageslink : ""),
                              ),
                              Positioned(
                                right: 20,
                                top: 5,
                                child: InkWell(
                                  child: Icon(
                                    Icons.delete,
                                    size: getProportionateScreenWidth(20),
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      checkserverimage = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        : images != null
                            ? Stack(
                                children: [
                                  Center(
                                    child: Image.file(images),
                                  ),
                                  Positioned(
                                    right: 20,
                                    top: 5,
                                    child: InkWell(
                                      child: Icon(
                                        Icons.delete,
                                        size: getProportionateScreenWidth(20),
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        setState(() {
                                          listfile.clear();
                                          images = null;
                                          print(
                                              "listfile/////////////////${listfile}");
                                          print("images///////////${images}");
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text('No image selected.'),
                              ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding CompanyLocation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textCompanyLocation,
            decoration: InputDecoration(
                hintText: 'Company Location',
                labelText: 'Company Location',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: TextStyle(color: Colors.grey),
                labelStyle: TextStyle(color: Colors.black87)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'This is required';
              }
            },
            onSaved: (String value) {
              _textCompanyLocation.text = value;
            },
            onChanged: (value) {
              setState(() {
                showPlaceList = true;
              });
              _onSearchlocation();
            },
          ),
          Visibility(
            visible: showPlaceList,
            child: Container(
              height: 100,
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics()
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placeList[index]["description"]),
                    onTap: () {
                      _textCompanyLocation.text =
                          _placeList[index]["description"];

                      var placeId = _placeList[index]["place_id"];
                      var address = _placeList[index]["description"];
                      print('${_placeList[index]}');
                      getLatLong(address);
                      // lat = detail.result.geometry.location.lat;
                      // long = detail.result.geometry.location.lng;
                      setState(() {
                        _placeList.clear();
                        showPlaceList = false;
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

//------------------------------------For Location--------------------------------------------------
  //for getting lat Long
  getLatLong(String address) async {
    // From a query
    // final query = '$address';
    // _CompanyLocation = address;
    // print('getLatLong');
    // List<Placemark> placemark = await Geolocator().placemarkFromAddress(query);
    // print(placemark[0].position.latitude);
    // lat = placemark[0].position.latitude.toString();
    // print(placemark[0].position.longitude);
    // long = placemark[0].position.longitude.toString();
    final query = '$address';
    _CompanyLocation = address;
    double lat, long;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      print(locations[0].latitude);
      print(locations[0].longitude);
      lat = locations[0].latitude;
      long = locations[0].longitude;
      _Companylat = lat.toString();
      _Companylong = long.toString();
      placemarkFromCoordinates(lat, long).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        _CompanyCity = placemarks[0].locality.toString();
      });
    });
  }

  _onSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestionforserchloction(_textCompanyLocation.text);
  }

  void getSuggestionforserchloction(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var uri = Uri.parse(request);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

//------------------------------------------------------------------------------------------

  Padding ServiceLocationProvider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _textServiceLocation,
            decoration: InputDecoration(
              hintText: 'Service Location Provider',
              labelText: 'Service Location Provider',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(color: Colors.grey),
              labelStyle: TextStyle(color: Colors.black87),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'This is required';
              }
            },
            onSaved: (String value) {
              _textServiceLocation.text = value;
            },
            onChanged: (value) {
              setState(() {
                showPlaceList = true;
              });
              _onServiceSearchlocation();
            },
          ),
          Visibility(
            visible: showPlaceList,
            child: Container(
              height: 100,
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics()
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placeList[index]["description"]),
                    onTap: () {
                      _textServiceLocation.text =
                          _placeList[index]["description"];

                      var placeId = _placeList[index]["place_id"];
                      var address = _placeList[index]["description"];
                      print('${_placeList[index]}');
                      getServiceLatLong(address);
                      setState(() {
                        _placeList.clear();
                        showPlaceList = false;
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  //------------------------------------For Service Location--------------------------------------------------
  //for getting lat Long
  getServiceLatLong(String address) async {
    // From a query
    // final query = '$address';
    // _ServiceLocation = address;
    // print('getLatLong');
    // List<Placemark> placemark = await Geolocator().placemarkFromAddress(query);
    // print(placemark[0].position.latitude);
    // lat = placemark[0].position.latitude.toString();
    // print(placemark[0].position.longitude);
    // long = placemark[0].position.longitude.toString();

    final query = '$address';
    _ServiceLocation = address;
    double lat, long;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      print(locations[0].latitude);
      print(locations[0].longitude);
      lat = locations[0].latitude;
      long = locations[0].longitude;
      _Servicelat = lat.toString();
      _Servicelong = long.toString();
      placemarkFromCoordinates(lat, long).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        _selectedCity = placemarks[0].locality.toString();
      });
    });
  }

  _onServiceSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getServiceSuggestionforserchloction(_textServiceLocation.text);
  }

  void getServiceSuggestionforserchloction(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var uri = Uri.parse(request);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

//------------------------------------------------------------------------------------------

  Column Category() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5.0, right: 5.0),
          child: DropdownSearch<String>(
            items: _Category,
            showClearButton: true,
            showSearchBox: true,
            hint: _textCategory != null
                ? "${_textCategory.text.toString()}"
                : 'Property Category Type',
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (_textCategory.text.isEmpty) {
                if (value == null) {
                  return 'This is required';
                }
              }
            },
            onSaved: (String value) {
              _textCategory.text = value.toString();
            },
            dropdownSearchDecoration: InputDecoration(
              hintStyle: style,
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                child: FaIcon(
                  FontAwesomeIcons.list,
                  color: primarycolor,
                ),
              ),
            ),
            onChanged: (newValue) {
              setState(
                () {
                  _selectedCategory = newValue;
                  print("Category:-${_selectedCategory}");
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Column RegistrationType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownSearch<String>(
          items: _RegistrationType,
          showClearButton: true,
          showSearchBox: true,
          hint: _textRegistrationtype != null
              ? "${_textRegistrationtype.text.toString()}"
              : 'Property Registration Type',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (_textRegistrationtype.text.isEmpty) {
              if (value == null) {
                return 'This is required';
              }
            }
          },
          onSaved: (String value) {
            _textRegistrationtype.text = value.toString();
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
          ),
          onChanged: (newValue) {
            setState(
              () {
                _selectedRegistrationType = newValue;
                print("Registration Type:-${_selectedRegistrationType}");
              },
            );
          },
        ),
      ],
    );
  }

  Column ProvideService() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DropdownSearch<String>(
          items: _ProvideService,
          showClearButton: true,
          showSearchBox: true,
          hint: _textprovidecustomer != null
              ? "${_textprovidecustomer.text.toString()}"
              : 'Provide Service At Customers Location',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (_textprovidecustomer.text.isEmpty) {
              if (value == null) {
                return 'This is required';
              }
            }
          },
          onSaved: (String value) {
            _textprovidecustomer.text = value.toString();
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
          ),
          onChanged: (newValue) {
            setState(
              () {
                _selectedProvideService = newValue;
                print("Provide Service:-${_selectedProvideService}");
              },
            );
          },
        ),
      ],
    );
  }

  //validation for full name
  String fullNameValidate(String value) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(patttern);

    if (value.isEmpty || value == null) {
      return 'Please Enter Full Name';
    } else {
      if (!regExp.hasMatch(value)) {
        return 'Please enter valid full name';
      } else {
        return null;
      }
    }
  }

  // validation for mobile Number
  String validateMobile(String value) {
    Pattern pattern = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
    RegExp regex = new RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please Enter Mobile Number';
    } else {
      if (!regex.hasMatch(value) && value.length != 10)
        return 'Mobile Number must be of 10 digit';
      else
        return null;
    }
  }

  //validation for email id
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value == null || value == null) {
      return 'Please Enter Email';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }
  }

  Future<String> _getRegisterAsRentalAgentData(
      String ActionID,
      List images,
      String imageslink,
      String u_id,
      String Full_name,
      String mobile_no,
      String email,
      String company_city,
      String service_location,
      String company_name,
      String address,
      String description,
      String category,
      String register_type,
      String provdcustomrlocat,
      String date,
      String CompanyName,
      String CompanyMobileNo,
      String CompanyEmail,
      String CompanyLocation,
      String CompanyCity,
      String CompanyLat,
      String CompanyLong,
      String CompanyDescription,
      String companyAddress,
      String CompanyPincode,
      String CompanyYear,
      String CompanyNoEmp,
      String CompanyWebsite,
      String lat,
      String long,
      String pincode,
      String companyalternateno,
      String companystdcode,
      String companytel,
      String alternateno,
      String stdcode,
      String telphoneno) async {
    setState(() {
      showspinner = true;
    });
    try {
      RegisterAsRentalAgentImageDataUpdate registerasrentalagentupdatedata =
          new RegisterAsRentalAgentImageDataUpdate();
      var rentalagentData =
          await registerasrentalagentupdatedata.RegisterAsRentalAgentDataUpload(
              ActionID,
              images,
              imageslink,
              u_id,
              Full_name,
              mobile_no,
              email,
              company_city,
              service_location,
              company_name,
              address,
              description,
              category,
              register_type,
              provdcustomrlocat,
              date,
              CompanyName,
              CompanyMobileNo,
              CompanyEmail,
              CompanyLocation,
              CompanyCity,
              CompanyLat,
              CompanyLong,
              CompanyDescription,
              companyAddress,
              CompanyPincode,
              CompanyYear,
              CompanyNoEmp,
              CompanyWebsite,
              lat,
              long,
              pincode,
              companyalternateno,
              companystdcode,
              companytel,
              alternateno,
              stdcode,
              telphoneno);
      if (rentalagentData != null) {
        print("Update Rental data ///${rentalagentData}");
        var resid = rentalagentData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "Data Updated Successfully !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          _textCompanyName.clear();
          _textCompanyMobNo.clear();
          _textCompanyEmail.clear();
          _textCompanyLocation.clear();
          _textCompanyDescriptionOfYourAd.clear();
          _textCompanyAddress.clear();
          _textCompanyPincode.clear();
          _textCompanyNoEmp.clear();
          _textCompanyWebSite.clear();
          _textDescriptionOfYourAd.clear();
          _textName.clear();
          _textServiceAddress.clear();
          _textServicePincode.clear();
          _textMobileNo.clear();
          _textServiceLocation.clear();
          _textWorkEmail.clear();
          _textCompanyAlternatenumber.clear();
          _textCompanyStdCode.clear();
          _textCompanyTelephonenumber.clear();
          _textAlternatenumber.clear();
          _textStdCode.clear();
          _textTelephonenumber.clear();

          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return HomePage();
            }),
          );
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

  getEstablishDate(value) {
    setState(() {
      PossessionDate = value;
    });
  }

  void _getservicesdata() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchUserPostedLoanAgent fetchupdatlist = new FetchUserPostedLoanAgent();
      var fetchupdatedsdata =
          await fetchupdatlist.getFetchUserPostedLoanAgentt("1","");
      if (fetchupdatedsdata != null) {
        var resid = fetchupdatedsdata["resid"];
        var rowcount = fetchupdatedsdata["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchupdatedsdatasd = fetchupdatedsdata["RentAgent"];
            print(fetchupdatedsdatasd.length);
            List<UpdatedAgent> tempfetchupdatedlist = [];
            for (var n in fetchupdatedsdatasd) {
              UpdatedAgent pro = UpdatedAgent.Rent(
                n["id"],
                n["uid"],
                n["CompanyName"],
                n["Companymobileno"],
                n["CompanyAlternetmobie"],
                n["Companystd"],
                n["Companytelephone"],
                n["CompanyEmail"],
                n["CompanyLocation"],
                n["CompanyCity"],
                n["Companylat"],
                n["Companylong"],
                n["CompanyDescription"],
                n["CompanyAddreess"],
                n["CompanyPincode"],
                n["Companyyear"],
                n["CompanyNoEmp"],
                n["CompanyWebsite"],
                n["name"],
                n["mobileno"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
                n["email"],
                n["city"],
                n["pincode"],
                n["servclocation"],
                n["lat"],
                n["long"],
                n["address"],
                n["description"],
                n["category"],
                n["registertype"],
                n["provdcustomrlocat"],
                n["date"],
                n["approve"],
                n["img"],
              );
              tempfetchupdatedlist.add(pro);
            }
            setState(() {
              this.FetchupdatedAgentslist = tempfetchupdatedlist;

              _Name = FetchupdatedAgentslist[0].name;
              _MobileNo = FetchupdatedAgentslist[0].mobileno;
              _WorkEmail = FetchupdatedAgentslist[0].email;
              _selectedCity = FetchupdatedAgentslist[0].city;
              _ServiceLocation = FetchupdatedAgentslist[0].servclocation;
              _CompanyName = FetchupdatedAgentslist[0].CompanyName;
              _address = FetchupdatedAgentslist[0].address;
              _DescriptionOfYourAd = FetchupdatedAgentslist[0].Description;
              _selectedCategory = FetchupdatedAgentslist[0].category;
              _selectedRegistrationType =
                  FetchupdatedAgentslist[0].registertype;
              _selectedProvideService =
                  FetchupdatedAgentslist[0].provdcustomrlocat;
              _CompanyName = FetchupdatedAgentslist[0].CompanyName;
              _CompanyMobNo = FetchupdatedAgentslist[0].Companymobileno;
              _CompanyEmail = FetchupdatedAgentslist[0].CompanyEmail;
              _CompanyLocation = FetchupdatedAgentslist[0].CompanyLocation;
              _CompanyCity = FetchupdatedAgentslist[0].CompanyCity;
              _Companylat = FetchupdatedAgentslist[0].Companylat;
              lat = FetchupdatedAgentslist[0].lat;
              long = FetchupdatedAgentslist[0].long;
              _Companylong = FetchupdatedAgentslist[0].Companylong;
              _CompanyDescription =
                  FetchupdatedAgentslist[0].CompanyDescription;
              _CompanyAddress = FetchupdatedAgentslist[0].CompanyAddreess;
              _CompanyPincode = FetchupdatedAgentslist[0].CompanyPincode;
              PossessionDate = FetchupdatedAgentslist[0].Companyyear;
              _CompanyNoEmps = FetchupdatedAgentslist[0].CompanyNoEmp;
              _CompanyWebSite = FetchupdatedAgentslist[0].CompanyWebsite;
              _Servicelat = FetchupdatedAgentslist[0].lat;
              _Servicelong = FetchupdatedAgentslist[0].long;
              _pincode = FetchupdatedAgentslist[0].pincode;
              CompanyAlternatNumber =
                  FetchupdatedAgentslist[0].CompanyAlternetmobie;
              CompanyStdCode = FetchupdatedAgentslist[0].CompanyStd;
              CompanyTelephoneNumber =
                  FetchupdatedAgentslist[0].Companytelephone;
              AlternatNumber = FetchupdatedAgentslist[0].alternateno;
              StdCode = FetchupdatedAgentslist[0].std;
              TelephoneNumber = FetchupdatedAgentslist[0].telephoneno;

              _textCompanyName.text = FetchupdatedAgentslist[0].CompanyName;
              _textCompanyMobNo.text =
                  FetchupdatedAgentslist[0].Companymobileno;
              _textCompanyEmail.text = FetchupdatedAgentslist[0].CompanyEmail;
              _textCompanyLocation.text =
                  FetchupdatedAgentslist[0].CompanyLocation;
              _textCompanyDescriptionOfYourAd.text =
                  FetchupdatedAgentslist[0].CompanyDescription;
              _textCompanyAddress.text =
                  FetchupdatedAgentslist[0].CompanyAddreess;
              _textCompanyPincode.text =
                  FetchupdatedAgentslist[0].CompanyPincode;
              _textCompanyNoEmp.text = FetchupdatedAgentslist[0].CompanyNoEmp;
              _textCompanyWebSite.text =
                  FetchupdatedAgentslist[0].CompanyWebsite;
              _textDescriptionOfYourAd.text =
                  FetchupdatedAgentslist[0].Description;
              _textName.text = FetchupdatedAgentslist[0].name;
              _textServiceAddress.text = FetchupdatedAgentslist[0].address;
              _textServicePincode.text = FetchupdatedAgentslist[0].pincode;
              _textMobileNo.text = FetchupdatedAgentslist[0].mobileno;
              _textServiceLocation.text =
                  FetchupdatedAgentslist[0].servclocation;
              _textWorkEmail.text = FetchupdatedAgentslist[0].email;
              _textCompanyAlternatenumber.text =
                  FetchupdatedAgentslist[0].CompanyAlternetmobie;
              _textCompanyStdCode.text = FetchupdatedAgentslist[0].CompanyStd;
              _textCompanyTelephonenumber.text =
                  FetchupdatedAgentslist[0].Companytelephone;
              _textAlternatenumber.text = FetchupdatedAgentslist[0].alternateno;
              _textStdCode.text = FetchupdatedAgentslist[0].std;
              _textTelephonenumber.text = FetchupdatedAgentslist[0].telephoneno;
              _textCategory.text = FetchupdatedAgentslist[0].category;
              _textRegistrationtype.text =
                  FetchupdatedAgentslist[0].registertype;
              _textprovidecustomer.text =
                  FetchupdatedAgentslist[0].provdcustomrlocat;
              imageslink = FetchupdatedAgentslist[0].Image;
            });

            print(
                "//////FetchupdatedAgentslist/////////${FetchupdatedAgentslist.length}");

            print(
                "//////FetchupdatedAgentslist/////////${FetchupdatedAgentslist}");
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

class BottomSheetWidget extends StatefulWidget {
  Function getEstablishDate;

  BottomSheetWidget(this.getEstablishDate);

  // const BottomSheetWidget({Key key},this.PossessionDate) : super(key: key);

  @override
  _BottomSheetWidgetState createState() =>
      _BottomSheetWidgetState(this.getEstablishDate);
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  Function getEstablishDate;

  _BottomSheetWidgetState(this.getEstablishDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: YearPicker(
        selectedDate: DateTime.now(),
        firstDate: DateTime(1995),
        lastDate: DateTime.now(),
        onChanged: (val) {
          print(val);
          var value = DateFormat('yyyy').format(val);
          getEstablishDate(value);
          print("PossessionDate $value");
          Navigator.pop(context);
        },
      ),
    );
  }
}
