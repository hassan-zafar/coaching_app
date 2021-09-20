import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:coaching_app/consts/theme_data.dart';
import 'package:coaching_app/screens/auth/login.dart';
import 'package:coaching_app/screens/landingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'consts/colllections.dart';
import 'consts/constants.dart';
import 'database/local_database.dart';
import 'models/users.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notifications",
  "This channel is used for important notifications",
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    UserLocalData().setNotLoggedIn();
    String? currentuserString = UserLocalData().getUserData();
    print(currentuserString);
    if (currentuserString.isNotEmpty &&
        currentuserString != "" &&
        currentuserString != "USERMODELSTRING") {
      currentUser = AppUserModel.fromMap(json.decode(currentuserString));
      isAdmin = UserLocalData().getIsAdmin();
    }

    return GetMaterialApp(
      title: 'TCoaching App',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(color: Color(0xff96B7BF)),
        canvasColor: Colors.transparent,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 160,
        splash: Hero(
            tag: "logo",
            child: Image.asset(
              logo,
              height: 160,
            )),
        animationDuration: Duration(seconds: 1),
        centered: true,
        backgroundColor: Colors.white,
        //Color(0xff387A53),

        nextScreen: currentUser != null ? LandingPage() : LoginScreen(),
        duration: 1,
        splashTransition: SplashTransition.fadeTransition,
      ),
      // ),
    );
  }
}
