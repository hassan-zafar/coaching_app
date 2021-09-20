import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coaching_app/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
// firebase_storage.FirebaseStorage storageRef =
//     firebase_storage.FirebaseStorage.instance;
final userRef = FirebaseFirestore.instance.collection('users');
final Reference storageRef = FirebaseStorage.instance.ref();
final calenderRef = FirebaseFirestore.instance.collection('calenderMeetings');
final appointmentsRef = FirebaseFirestore.instance.collection('appointments');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final chatRoomRef = FirebaseFirestore.instance.collection('chatRoom');
final chatListRef = FirebaseFirestore.instance.collection('chatLists');
final studentJournelRef =
    FirebaseFirestore.instance.collection('studentJournel');
final attendanceRef = FirebaseFirestore.instance.collection('attendanceRef');
final announcementsRef = FirebaseFirestore.instance.collection('announcements');

final feeRef = FirebaseFirestore.instance.collection('feeRef');

AppUserModel? currentUser;
bool? isAdmin;
bool? isTeacher;

String dateTimeScript =
    "${DateTime.now().day} : ${DateTime.now().month} : ${DateTime.now().year}";
