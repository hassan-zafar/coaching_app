import 'dart:convert';

class AppUserModel {
  final String? id;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? timestamp;
  final bool? isAdmin;
  final String? email;
  final String? photoUrl;

  final String? androidNotificationToken;

  // final Map? sectionsAppointed;
  AppUserModel(
      {this.id,
      this.userName,
      this.firstName,
      this.lastName,
      this.password,
      this.timestamp,
      this.isAdmin,
      this.email,
      this.androidNotificationToken,
      this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'timestamp': timestamp,
      'isAdmin': isAdmin,
      'email': email,
      'androidNotificationToken': androidNotificationToken,
    };
  }

  factory AppUserModel.fromDocument(doc) {
    return AppUserModel(
        id: doc.data()["id"],
        password: doc.data()["password"],
        userName: doc.data()["userName"],
        timestamp: doc.data()["timestamp"],
        email: doc.data()["email"],
        isAdmin: doc.data()["isAdmin"],
        firstName: doc.data()["firstName"],
        lastName: doc.data()["lastName"],
        androidNotificationToken: doc.data()["androidNotificationToken"],
        photoUrl: doc.data()["photoUrl"]);
  }
  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'],
      userName: map['userName'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password'],
      timestamp: map['timestamp'],
      isAdmin: map['isAdmin'],
      email: map['email'],
      androidNotificationToken: map['androidNotificationToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source));

  AppUserModel copyWith({
    String? id,
    String? userName,
    String? firstName,
    String? lastName,
    String? password,
    String? timestamp,
    bool? isAdmin,
    String? email,
    String? androidNotificationToken,
  }) {
    return AppUserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      timestamp: timestamp ?? this.timestamp,
      isAdmin: isAdmin ?? this.isAdmin,
      email: email ?? this.email,
      androidNotificationToken:
          androidNotificationToken ?? this.androidNotificationToken,
    );
  }

  @override
  String toString() {
    return 'AppUserModel(id: $id, userName: $userName, firstName: $firstName, lastName: $lastName, password: $password, timestamp: $timestamp, isAdmin: $isAdmin, email: $email, androidNotificationToken: $androidNotificationToken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUserModel &&
        other.id == id &&
        other.userName == userName &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.password == password &&
        other.timestamp == timestamp &&
        other.isAdmin == isAdmin &&
        other.email == email &&
        other.androidNotificationToken == androidNotificationToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        password.hashCode ^
        timestamp.hashCode ^
        isAdmin.hashCode ^
        email.hashCode ^
        androidNotificationToken.hashCode;
  }
}
