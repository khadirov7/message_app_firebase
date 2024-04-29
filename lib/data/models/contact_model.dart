import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final int contactId;
  final String contactName;
  final String contactLasName;
  final bool isOnline;
  final String imageUrl;
  final DateTime lastOnlineTime;

  ContactModel({
    required this.contactId,
    required this.contactLasName,
    required this.contactName,
    required this.isOnline,
    required this.imageUrl,
    required this.lastOnlineTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'contactId': contactId,
      'contactLasName': contactLasName,
      'contactName': contactName,
      'isOnline': isOnline,
      'imageUrl': imageUrl,
      'lastOnlineTime': lastOnlineTime.toIso8601String(),
    };
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      contactId: json['contactId'],
      contactLasName: json['contactLasName'],
      contactName: json['contactName'],
      isOnline: json['isOnline'],
      imageUrl: json['imageUrl'],
      lastOnlineTime: DateTime.parse(json['lastOnlineTime']),
    );
  }
}
