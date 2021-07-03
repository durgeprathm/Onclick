import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String profilePic;

  @override
  void initState() {
    super.initState();
    getUserdata();
  }

  getUserdata() async {
    var tempprofilePic = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERPROFILEPIC);
    setState(() {
      profilePic = tempprofilePic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
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
          profilePic != null
              ? CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                    profilePic,
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
              : CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/User Icon.svg"),
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
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/edit-icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
