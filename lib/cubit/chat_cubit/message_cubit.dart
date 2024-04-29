import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/message_model.dart';

class MessageCubit extends Cubit<List<MessageModel>> {
  final FirebaseFirestore firestore;

  MessageCubit(this.firestore) : super([]);

  void getMessages(int contactId) {
    final stream = firestore
        .collection('messages')
        .where('contactId', isEqualTo: contactId)
        .orderBy('createdTime', descending: false)
        .snapshots();

    stream.listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        return MessageModel(
          messageId: doc['messageId'],
          messageText: doc['messageText'],
          isFile: doc['isFile'],
          createdTime: doc['createdTime'],
          contactId: doc['contactId'],
          status: doc['status'],
        );
      }).toList();
      emit(messages);
    });
  }

  Future<void> sendMessage(MessageModel messageModel) async {
    try {
      await firestore.collection('messages').add({
        'messageId': messageModel.messageId,
        'messageText': messageModel.messageText,
        'isFile': messageModel.isFile,
        'createdTime': messageModel.createdTime,
        'contactId': messageModel.contactId,
        'status': messageModel.status,
      });
      state.add(messageModel);
      emit(List.from(state));
    } catch (e) {
      print('Error: $e');
    }
  }
}
