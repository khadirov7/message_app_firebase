class MessageModel {
  final int messageId;
  final String messageText;
  final bool isFile;
  final String createdTime;
  final int contactId;
  final bool status;

  MessageModel({
    required this.createdTime,
    required this.messageText,
    required this.messageId,
    required this.isFile,
    required this.contactId,
    required this.status,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      createdTime: json['createdTime'] as String,
      messageText: json['messageText'] as String,
      messageId: json['messageId'] as int,
      isFile: json['isFile'] as bool,
      contactId: json['contactId'] as int,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdTime': createdTime,
      'messageText': messageText,
      'messageId': messageId,
      'isFile': isFile,
      'contactId': contactId,
      'status': status,
    };
  }
}
