import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Registration_Details_Image.dart';
import 'package:onclickproperty/components/custom_surfix_icon.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/helper/keyboard.dart';
import 'package:onclickproperty/pages/sign_in/sign_in_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../../ElectronicUpdatedDetails_User_Posted.dart';

class CompleteProfileForm extends StatefulWidget {
  Function setLoading;
  final String mobileNo;

  CompleteProfileForm(this.setLoading, this.mobileNo);

  @override
  _CompleteProfileFormState createState() =>
      _CompleteProfileFormState(this.setLoading, this.mobileNo);
}
//choose photo

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Function setLoading;
  final String mobileNo;

  _CompleteProfileFormState(this.setLoading, this.mobileNo);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneNoController = new TextEditingController();
  TextEditingController _textLocation = new TextEditingController();
  final List<String> errors = [];
  String fullname;
  String username;
  String email;
  String password;
  String conform_password;
  String phoneNumber;
  String descrption;
  String _ServiceLat;
  String _ServiceLong;
  String _pincode;
  String _ServiceLocation;
  String _selectedCity;
  String _sessionToken;
  var uuid = new Uuid();
  List<File> listfile = [];
  List<dynamic> _placeList = [];
  File images;

  bool checkusername = false;
  bool checkemail = false;
  String errorusername = '';
  String erroremail = '';

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    // String getphoneNumber = await SharedPreferencesConstants.instance
    //     .getStringValue(SharedPreferencesConstants.USERMOBNO);
    setState(() {
      phoneNumber = mobileNo;
      _phoneNoController.text = mobileNo;
    });

    print('phoneNumber : $phoneNumber');
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUserNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          //buildAreaField(),
          ServiceLocationProvider(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildDescrptionFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: RaisedButton(
                    color: Colors.blue,
                    child: new Text(
                      "Choose Photo",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      _showPicker(context);
                      // File result =
                      //     await FilePicker.getFile(type: FileType.image);
                      // if (result != null) {
                      //   setState(() {
                      //     print("inside if in image picker");
                      //     listfile.clear();
                      //     images = result;
                      //     listfile.add(images);
                      //     print("images:-${images}");
                      //   });
                      // } else {
                      //   print("inside else in image picker");
                      // }
                      // print("Inside Pressed Button $images");
                    }),
              ),
              Expanded(
                child: Container(
                    height: getProportionateScreenHeight(100),
                    width: getProportionateScreenWidth(20),
                    child: images != null
                        ? Center(
                            child: Image.file(images),
                          )
                        : Center(
                            child: Text('No image selected.'),
                          )),
              )
            ],
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
                print("_ServiceLocation---------${_ServiceLocation}");
                print("_selectedCity---------${_selectedCity}");
                print("_ServiceLat---------${_ServiceLat}");
                print("_ServiceLong---------${_ServiceLong}");
                print("_pincode---------${_pincode}");
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  var _cdate =
                      DateFormat('yyyy-MM-dd').format(new DateTime.now());
                  // if all are valid then go to success screen
                  KeyboardUtil.hideKeyboard(context);
                  _getRegistrationSubmitData(
                      listfile,
                      fullname,
                      username,
                      _cdate,
                      email,
                      phoneNumber,
                      password,
                      descrption != null ? descrption : '',
                      _ServiceLocation != null ? _ServiceLocation : '',
                      _selectedCity != null ? _selectedCity : '',
                      _pincode != null ? _pincode : '',
                      _ServiceLat != null ? _ServiceLat : '',
                      _ServiceLong != null ? _ServiceLong : '');
                  // uploadLoginData();
                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                } else {
                  setLoading(false);
                }
              },
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildDescrptionFormField() {
    return TextFormField(
      onSaved: (newValue) => descrption = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kAddressNullError);
        // }
        // return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        //   addError(error: kAddressNullError);
        //   return "";
        // }
        // return null;
      },
      decoration: InputDecoration(
        labelText: "Descrption",
        hintText: "Enter your descrption",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  ServiceLocationProvider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _textLocation,
          decoration: InputDecoration(
            labelText: "Location",
            hintText: "Enter your Location",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon:
                CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return 'This is required';
            }
          },
          onSaved: (String value) {
            _textLocation.text = value;
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
                    _textLocation.text = _placeList[index]["description"];
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
    );
  }

  getServiceLatLong(String address) async {
    setState(() {
      final query = '$address';
      _ServiceLocation = address;
      print('_ServiceLocation $_ServiceLocation');
      double lat, long;
      print('getLatLong');
      locationFromAddress(query).then((locations) {
        final output = locations[0].toString();
        print(output);
        print(locations[0].latitude);
        print(locations[0].longitude);
        lat = locations[0].latitude;
        long = locations[0].longitude;
        _ServiceLat = lat.toString();
        _ServiceLong = long.toString();
        print('_ServiceLat $_ServiceLat');
        print('_ServiceLong $_ServiceLong');
        placemarkFromCoordinates(lat, long).then((placemarks) {
          final output = placemarks[0].toString();
          _selectedCity = placemarks[0].locality.toString();
          _pincode = placemarks[0].postalCode.toString();
          print('_selectedCity $_selectedCity');
          print('_pincode $_pincode');
        });
      });
    });
  }

  _onServiceSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getServiceSuggestionforserchloction(_textLocation.text);
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

//-----------------------------------------------------------------------------------------

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: _phoneNoController,
      enabled: false,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildUserNameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        } else if (!checkusername) {
          removeError(error: errorusername);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kUsernameNullError);
          return "";
        } else if (checkusername) {
          addError(error: errorusername);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "User Name",
        hintText: "Enter your user name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      onSaved: (newValue) => fullname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Full Name",
        hintText: "Enter your full name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 5) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        // else if (value.length < 5) {
        //   addError(error: kShortPassError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        } else if (!checkemail) {
          removeError(error: erroremail);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        } else if (checkemail) {
          addError(error: erroremail);
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    /* File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);*/
    final _picker = ImagePicker();
    PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      // _image = image;
      listfile.clear();
      listfile.add(File(image.path));
      images = File(image.path);
    });
  }

  _imgFromGallery() async {
    /* File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);*/
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    setState(() {
      listfile.clear();
      listfile.add(File(result.paths[0]));
      images = File(result.paths[0]);
    });
  }

  _getRegistrationSubmitData(
    List images,
    String full_Name,
    String UserName,
    String Date,
    String Email_ID,
    String Mobile_Number,
    String Password,
    String Description,
    String area,
    String city,
    String pincode,
    String locationlat,
    String locationlong,
  ) async {
    setState(() {
      setLoading(true);
      checkusername = false;
      checkemail = false;
    });

    FirebaseMessaging.instance.getToken().then((token) async {
      print('Token: $token');
      RegistrationImageSubmit registerSubmitData =
          new RegistrationImageSubmit();
      var registionData = await registerSubmitData.RegistrationuploadData(
        images,
        full_Name,
        UserName,
        Date,
        Email_ID,
        Mobile_Number,
        Password,
        Description,
        token,
        area,
        city,
        pincode,
        locationlat,
        locationlong,
      );
      if (registionData != null) {
        print("property data ///${registionData}");
        var resid = registionData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            setLoading(false);
          });
          Fluttertoast.showToast(
              msg: "Data Successfully Save !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return SignInScreen();
            }),
          );
        } else if (resid == 204) {
          setState(() {
            setLoading(false);
          });
          if (registionData['error'] == "username") {
            setState(() {
              checkusername = true;
              errorusername = registionData['message'];
            });
          } else if (registionData['error'] == "email") {
            setState(() {
              checkemail = true;
              erroremail = registionData['message'];
            });
          }

          Fluttertoast.showToast(
              msg: "${registionData['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          setState(() {
            setLoading(false);
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
          Fluttertoast.showToast(
              msg: "${registionData['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        setState(() {
          setLoading(false);
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Some Technical Problem Plz Try Again Later"),
          //   backgroundColor: Colors.green,
          // ));
        });
        Fluttertoast.showToast(
            msg: "Some Technical Problem Plz Try Again Later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((e) {
      print(e);
      setState(() {
        setLoading(false);
        // _scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text("Some Technical Problem Plz Try Again Later"),
        //   backgroundColor: Colors.green,
        // ));
      });
      Fluttertoast.showToast(
          msg: "Some Technical Problem Plz Try Again Later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
