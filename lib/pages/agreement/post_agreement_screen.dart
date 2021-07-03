import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class PostAgreementScreen extends StatefulWidget {
  @override
  _PostAgreementScreenState createState() => _PostAgreementScreenState();
}

class _PostAgreementScreenState extends State<PostAgreementScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String PossessionDate;
  DateTime sDateTime;

  @override
  void initState() {
    final DateTime now = DateTime.now();
    sDateTime = now;
    PossessionDate = DateFormat('yyyy').format(sDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Post Agreement",
          style: appbarTitleTextStyle,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: getProportionateScreenHeight(2),
                ),
                Text(
                  'Business Details',
                  style: kTextStyle,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Company Name",
                      hintText: "Enter your Company Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(10),
                  ],
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Mobile No.",
                      hintText: "Enter Mobile No.",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Enter Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 2,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Company description",
                      hintText: "Enter your Company Description",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Company Address",
                      hintText: "Enter your Company Address",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(6),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
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
                      labelText: "Pincode",
                      hintText: "Enter Pincode",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  )),
                  child: TextFormField(
                      // validator: value.isEmpty ? 'this field is required' : null,
                      readOnly: true,
                      decoration: InputDecoration(
                          labelText: 'Company Establishment Year',
                          hintText:
                              PossessionDate != null ? PossessionDate : '',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle: TextStyle(color: Colors.black87),
                          labelStyle: TextStyle(color: Colors.black54),
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: primarycolor,
                          )),
                      onTap: () {
                        var sheetController = scaffoldKey.currentState
                            .showBottomSheet((context) =>
                                BottomSheetWidget(getEstablishDate));
                        sheetController.closed.then((value) {
                          print("closed");
                          print("$value");
                        });
                        // handleReadOnlyInputClick(context);
                      }),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "No Of Employees",
                      hintText: "Enter No Of Employees",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  keyboardType: TextInputType.url,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Website",
                      hintText: "Enter Website",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(2),
                ),
                Text(
                  'Service Details',
                  style: kTextStyle,
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Person Name",
                      hintText: "Enter Person Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(10),
                  ],
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Person Mobile No.",
                      hintText: "Enter Person Mobile No.",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(5)),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Person Email",
                      hintText: "Enter Person Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  keyboardType: TextInputType.text,
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Service Address",
                      hintText: "Enter service Address",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black87)),
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                TextFormField(
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(6),
                  ],
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  // onSaved: (newValue) => phoneNumber = newValue,
                  onChanged: (value) {
                    if (value.isNotEmpty) {}
                    return null;
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
                DropdownSearch<String>(
                  items: _category,
                  mode: Mode.MENU,
                  label: 'Property Category Type',
                  hint: "Property Category Type",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'This is required';
                    }
                  },
                  onChanged: (String value) {
                    if (value != null) {
                      print('Category: $value');
                    }
                  },
                  dropdownSearchDecoration: InputDecoration(
                    hintStyle: style,
                  ),
                ),
                DropdownSearch<String>(
                  items: _registrationType,
                  mode: Mode.MENU,
                  label: 'Property Registration Type',
                  hint: "Property Registration  Type",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'This is required';
                    }
                  },
                  onChanged: (String value) {
                    if (value != null) {
                      print('Category: $value');
                    }
                  },
                  dropdownSearchDecoration: InputDecoration(
                    hintStyle: style,
                  ),
                ),
                DropdownSearch<String>(
                  items: _provideServiceAtCustomersLocation,
                  mode: Mode.MENU,
                  label: 'Provide Service At Customers Location',
                  hint: "Provide Service At Customers Location",
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'This is required';
                    }
                  },
                  onChanged: (String value) {
                    if (value != null) {
                      print('Category: $value');
                    }
                  },
                  dropdownSearchDecoration: InputDecoration(
                    hintStyle: style,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(40)),
                SizedBox(
                  width: double.infinity,
                  height: getProportionateScreenHeight(56),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: kPrimaryColor,
                    onPressed: () {
                      // if (_formKey.currentState.validate()) {
                      //   _formKey.currentState.save();
                      //   // if all are valid then go to success screen
                      //   KeyboardUtil.hideKeyboard(context);
                      //   getOtpData();
                      //   // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                      // } else {
                      //   setLoading(false);
                      // }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(18),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _category = [
    'rent',
    'sale',
    'both',
  ];
  String _selectedCategory;

  List<String> _registrationType = [
    'online',
    'offline(registry office)',
    'both',
  ];
  String _selectedRegistrationType;

  List<String> _provideServiceAtCustomersLocation = [
    'yes',
    'no',
  ];
  String _selectedProvideServiceAtCustomersLocation;

  Padding provideServiceAtCustomersLocation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
              width: 2.0,
            ),
          ),
        ),
        hint: Text(
          'Provide Service At Customers Location',
        ),
        value: _selectedProvideServiceAtCustomersLocation,
        validator: (value) {
          if (value == null) {
            return 'This is required';
          }
        },
        onChanged: (newValue) {
          setState(
            () {
              _selectedProvideServiceAtCustomersLocation = newValue;
              print(
                  "Provide Service at customer location:-${_selectedProvideServiceAtCustomersLocation}");
            },
          );
        },
        items: _provideServiceAtCustomersLocation.map((nValue) {
          return DropdownMenuItem(
            child: new Text(
              nValue,
            ),
            value: nValue,
          );
        }).toList(),
        isExpanded: true,
      ),
    );
  }

  getEstablishDate(value) {
    setState(() {
      PossessionDate = value;
    });
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
