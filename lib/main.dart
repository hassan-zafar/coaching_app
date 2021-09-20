import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:coaching_app/bottom_bar.dart';
import 'package:coaching_app/screens/auth/forget_password.dart';
import 'package:coaching_app/screens/auth/login.dart';
import 'package:coaching_app/screens/auth/sign_up.dart';
import 'package:coaching_app/screens/landingPage.dart';
import 'package:coaching_app/screens/main_screen.dart';
import 'package:coaching_app/screens/meeting_screen.dart';
import 'package:coaching_app/user_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
        title: 'Coaching App',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Color(0xFF07A8B2),
          accentColor: Colors.blue,
          // scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(color: Color(0xff96B7BF)),
          canvasColor: Colors.white,
        ),
        routes: {
          // '/': (ctx) => LandingPage(),
          // WebhookPaymentScreen.routeName: (ctx) =>
          //     WebhookPaymentScreen(),
          LandingPage.routeName: (ctx) => LandingPage(),

          MainScreens.routeName: (ctx) => MainScreens(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          MeetingScreen.routeName: (ctx) => MeetingScreen(),
          BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
          ForgetPassword.routeName: (ctx) => ForgetPassword(),
        },
        home: UserState()
        // ),
        );
  }
}
