import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/update_user_profile.dart';
import 'package:onclickproperty/components/custom_surfix_icon.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/helper/keyboard.dart';
import 'package:onclickproperty/pages/profile/components/profile_pic.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _showProgressBar = false;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  TextEditingController _FullNametext = TextEditingController();
  TextEditingController _UserNametext = TextEditingController();
  TextEditingController _EmailIDtext = TextEditingController();
  TextEditingController _phoneNoController = new TextEditingController();
  String fullname;
  String username;
  String email;
  String password;
  String conform_password;
  String phoneNumber;
  String descrption;

  bool checkusername = false;
  bool checkemail = false;
  String errorusername = '';
  String erroremail = '';

  String profilePic;
  String UID;
  String UserFullName;
  String UserName;
  String UserEmail;
  String UserMobile;
  File images;
  List<File> listfile = [];
  bool checkphonenumber = true;
  bool checkusername1 = true;
  bool checkemail1 = true;

  @override
  void initState() {
    getUserdata();
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

  void getUserdata() async {
    var tempprofilePic = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERPROFILEPIC);
    setState(() {
      profilePic = tempprofilePic;
    });

    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    UserFullName = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERFULLNAME);
    fullname = UserFullName;
    _FullNametext.text = UserFullName;
    print("fullname////////////////:-${fullname}");

    UserName = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERNAME);
    username = UserName;
    _UserNametext.text = UserName;
    print("_UserNametext////////////////:-${username}");
    if (UserName == Null || UserName.isEmpty) {
      checkusername1 = true;
    } else {
      checkusername1 = false;
    }

    UserEmail = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    email = UserEmail;
    _EmailIDtext.text = UserEmail;
    print("_EmailIDtext////////////////:-${email}");
    if (email == Null || email.isEmpty) {
      checkemail1 = true;
    } else {
      checkemail1 = false;
    }

    UserMobile = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    _phoneNoController.text = UserMobile;
    phoneNumber = UserMobile;
    print("phoneNumber////////////////:-${phoneNumber}");
    if (phoneNumber == Null || phoneNumber.isEmpty) {
      checkphonenumber = true;
    } else {
      checkphonenumber = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showProgressBar,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      overflow: Overflow.visible,
                      children: [
                        // CircleAvatar(
                        //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
                        // ),
                        // profilePic != null
                        //     ?
                        images != null
                            ? CircleAvatar(
                                radius: 16.0,
                                child: ClipRRect(
                                  child: Image.file(images),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                backgroundColor: Colors.grey,

                                //   Image.network(
                                //   profilePic,
                                //   // fit: BoxFit.fill,
                                //   loadingBuilder: (BuildContext context, Widget child,
                                //       ImageChunkEvent loadingProgress) {
                                //     if (loadingProgress == null) return child;
                                //     return Center(
                                //       child: CircularProgressIndicator(
                                //         value: loadingProgress.expectedTotalBytes != null
                                //             ? loadingProgress.cumulativeBytesLoaded /
                                //                 loadingProgress.expectedTotalBytes
                                //             : null,
                                //       ),
                                //     );
                                //   },
                                // )
                              )
                            : profilePic != null
                                ? CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                      profilePic,
                                    ),
                                    backgroundColor: Colors.grey,
                                  )
                                : CircleAvatar(
                                    backgroundImage: AssetImage(
                                        "assets/icons/User Icon.svg"),
                                    backgroundColor: Colors.grey),
                        Positioned(
                          right: -16,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white),
                              ),
                              color: Color(0xFFF5F6F9),
                              onPressed: () async {
                                // File result = await FilePicker.getFile(
                                //     type: FileType.image);
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
                                _showPicker(context);
                              },
                              child: SvgPicture.asset(
                                  "assets/icons/edit-icon.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildFullNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        buildUserNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        buildEmailFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        buildPhoneNumberFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        FormError(errors: errors),
                        SizedBox(height: getProportionateScreenHeight(30)),
                        SizedBox(
                          width: double.infinity,
                          height: getProportionateScreenHeight(56),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: kPrimaryColor,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                var _cdate = DateFormat('yyyy-MM-dd')
                                    .format(new DateTime.now());
                                // if all are valid then go to success screen
                                print("listfile///////////${listfile}");
                                print("fullname///////////${fullname}");
                                print("username///////////${username}");
                                print("phoneNumber///////////${phoneNumber}");
                                print("email///////////${email}");


                                KeyboardUtil.hideKeyboard(context);
                                if (listfile.length == 0) {
                                  _submitData(
                                      '1', listfile, fullname, username,phoneNumber,email);
                                } else {
                                  _submitData(
                                      '0', listfile, fullname, username,phoneNumber,email);
                                }

                                // uploadLoginData();
                                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                              } else {
                                _showProgressBar = (false);
                              }
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  // Text(
                  //   "By continuing your confirm that you agree \nwith our Term and Condition",
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.caption,
                  // ),
                ],
              ),
            ),
          ),
        ),
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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: _phoneNoController,
      enabled: checkphonenumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        phoneNumber=value;
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
      enabled: checkusername1,
      controller: _UserNametext,
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
      controller: _FullNametext,
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
      controller: _EmailIDtext,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      enabled: checkemail1,
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

  _submitData(String actionId, List images, String full_Name, String UserName,
      String phoneNumber, String email) async {
    print('full_Name:$full_Name');
    print('UserName:$UserName');
    setState(() {
      _showProgressBar = true;
    });
    try {
      UpdateUserProfile submitData = new UpdateUserProfile();

      var result = await submitData.insertUpdateUserProfile(
          actionId,
          UID,
          images,
          full_Name,
          UserName != null ? UserName : "",
          phoneNumber != null ? phoneNumber : "",
          email != null ? email : "");
      if (result != null) {
        print("property data ///${result}");
        var resid = result['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          var FullName = result["fullname"];
          var profileimg = result["profileimg"];
          var mobileno = result["mobileno"];
          var email = result["email"];
          var username = result["username"];

          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USERPROFILEPIC, profileimg);
          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USERFULLNAME, FullName);
          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERMOBNO, mobileno);
          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USEREMAILID, email);
          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERNAME, username);

          setState(() {
            _showProgressBar = false;
          });
          Fluttertoast.showToast(
              msg: "Data Successfully Save !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pop();
        } else if (resid == 204) {
          setState(() {
            _showProgressBar = false;
          });
          if (result['error'] == "username") {
            setState(() {
              checkusername = true;
              errorusername = result['message'];
            });
          } else if (result['error'] == "email") {
            setState(() {
              checkemail = true;
              erroremail = result['message'];
            });
          }
        } else {
          setState(() {
            _showProgressBar = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Plz Try Again"),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        setState(() {
          _showProgressBar = false;
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
