import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_app/consts/colllections.dart';
import 'package:coaching_app/models/announcementsModel.dart';
import 'package:coaching_app/models/users.dart';
import 'package:coaching_app/utilities/custom_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'local_database.dart';


class DatabaseMethods {
  // Future<Stream<QuerySnapshot>> getproductData() async {
  //   return FirebaseFirestore.instance.collection(productCollection).snapshots();
  // }

  Future addUserInfoToFirebase(
      {required AppUserModel userModel,
      required String userId,
      required bool isStuTeacher,
      required email}) async {
    print("addUserInfoToFirebase");
    final Map<String, dynamic> userInfoMap = json.decode(userModel.toJson());
    return userRef.doc(userId).set(userInfoMap).then((value) {
      if (!isStuTeacher) {
        currentUser = userModel;
        UserLocalData().setUserModel(userModel.toJson());
        UserLocalData().setUserEmail(userModel.email);
        UserLocalData().setUserName(userModel.userName);
        UserLocalData().setIsAdmin(userModel.isAdmin);
      }
    }).catchError(
      (Object obj) {
        errorToast(message: obj.toString());
      },
    );
  }



  addAnnouncements(
      {required final String postId,
      required final String announcementTitle,
      required final String imageUrl,
      required final String eachUserId,
      required String eachUserToken,
      required final String description}) async {
    FirebaseFirestore.instance
        .collection("announcements")
        .doc(eachUserId)
        .collection("userAnnouncements")
        .doc(postId)
        .set({
      "announcementId": postId,
      "announcementTitle": announcementTitle,
      "description": description,
      "timestamp": DateTime.now(),
      "token": eachUserToken,
      "imageUrl": imageUrl,
      "userId": currentUser!.id
    });
  }

  Future getAnnouncements() async {
    List<AnnouncementsModel> tempAllAnnouncements = [];
    QuerySnapshot tempAnnouncementsSnapshot = await FirebaseFirestore.instance
        .collection('announcements')
        .doc(currentUser!.id)
        .collection("userAnnouncements")
        .get();
    tempAnnouncementsSnapshot.docs.forEach((element) {
      tempAllAnnouncements.add(AnnouncementsModel.fromDocument(element));
    });
    return tempAllAnnouncements;
  }

  Future fetchUserInfoFromFirebase({
    required String uid,
  }) async {
    final DocumentSnapshot _user = await userRef.doc(uid).get();
    currentUser = AppUserModel.fromDocument(_user);
    createToken(uid);
    UserLocalData().setIsAdmin(currentUser!.isAdmin);
    Map userData = json.decode(currentUser!.toJson());
    UserLocalData().setUserModel(json.encode(userData));
    var user = UserLocalData().getUserData();
    print(user);
    isAdmin = currentUser!.isAdmin;
    print(currentUser!.email);
  }

  Future fetchCalenderDataFromFirebase() async {
    final QuerySnapshot calenderMeetings = await calenderRef.get();

    return calenderMeetings;
  }

  // Future fetchPostsDataFromFirebase() async {
  //   final QuerySnapshot allPostsSnapshots = await postsRef.get();

  //   return allPostsSnapshots;
  // }

  createToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      userRef.doc(uid).update({"androidNotificationToken": token});
      UserLocalData().setToken(token!);
    });
  }

  Future fetchAppointmentDataFromFirebase({@required String? uid}) async {
    final QuerySnapshot allAppointmentsSnapshots =
        await appointmentsRef.doc(uid).collection("userAppointments").get();

    return allAppointmentsSnapshots;
  }

}
