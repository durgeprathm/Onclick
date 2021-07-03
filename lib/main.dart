import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onclickproperty/Model/all_dashboard_property_model.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/material_color_generator.dart';
import 'package:onclickproperty/pages/splash_Screen_Page.dart';
import 'package:onclickproperty/utilities/theme.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

handleNotifications() async {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound:
          true); //presentation options for Apple notifications when received in the foreground.

  FirebaseMessaging.onMessage.listen((message) async {
    print('Got a message whilst in the FOREGROUND!');

    return;
  }).onData((data) {
    print('Got a DATA message whilst in the FOREGROUND!');
    print('data from stream: ${data.data}');
  });

  FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    print('NOTIFICATION MESSAGE TAPPED');
    return;
  }).onData((data) {
    print('NOTIFICATION MESSAGE TAPPED');
    print('data from stream: ${data.data}');
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.getInitialMessage().then(
      (value) => value != null ? _firebaseMessagingBackgroundHandler : false);

  return;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  handleNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor primarySwatch = generateMaterialColor(primarycolor);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AllDashboardResTopProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardResRentProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardResSellProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardCommRentProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardCommSellProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardProjectTopProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardProjectSellProperty()),
        ChangeNotifierProvider(
            create: (context) => AllDashboardCommTopProperty()),
      ],
      child: MaterialApp(
        title: 'OnClick Property',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        // home: IntroductionPage()
        home: SplashScreen(),
      ),
    );
  }
}
