import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import '../cubit/chat_cubit/message_cubit.dart';
import '../cubit/file_cubit/file_cubit.dart';
import '../data/models/contact_model.dart';
import '../data/models/message_model.dart';
import '../data/models/file_data_model.dart';

class MessagesScreen extends StatefulWidget {
  final ContactModel contact;

  const MessagesScreen(this.contact, {super.key});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MessageCubit>().getMessages(widget.contact.contactId); // Firestore'dan doimiy kuzatish
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.contact.contactName} ${widget.contact.contactLasName}",
        ),
      ),
      body: BlocBuilder<MessageCubit, List<MessageModel>>(
        builder: (context, messages) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isUserMessage = message.messageId == 2;
                    return Align(
                      alignment: isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isUserMessage ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: isUserMessage
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.isFile
                                    ? "File: ${message.messageText}"
                                    : message.messageText,
                                style: TextStyle(
                                  color: isUserMessage
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              if (message.isFile)
                                IconButton(
                                  icon: Icon(
                                    context.read<FileManagerCubit>().state.newFileLocation.isEmpty
                                        ? Icons.download
                                        : Icons.open_in_new,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (context.read<FileManagerCubit>().state.newFileLocation.isNotEmpty) {
                                      OpenFilex.open(
                                        context.read<FileManagerCubit>().state.newFileLocation,
                                      );
                                    } else {
                                      final fileDataModel = FileDataModel(
                                        urlFile: message.messageText,
                                      );
                                      context.read<FileManagerCubit>().downloadFile(fileDataModel);
                                    }
                                  },
                                ),
                              const SizedBox(height: 5),
                              Text(
                                "${message.createdTime}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: "Type a message",
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        if (messageController.text.isNotEmpty) {
                          final newMessage = MessageModel(
                            createdTime: DateTime.now().toString(),
                            messageText: messageController.text,
                            messageId: 2,
                            contactId: widget.contact.contactId,
                            isFile: false,
                            status: false,
                          );
                          context.read<MessageCubit>().sendMessage(newMessage);
                          messageController.clear();
                          await Future.delayed(Duration(seconds: 4));
                          final newMessage2 = MessageModel(
                            createdTime: DateTime.now().toString(),
                            messageText: "Test Salom",
                            messageId: 1,
                            contactId: widget.contact.contactId,
                            isFile: false,
                            status: false,
                          );
                          context.read<MessageCubit>().sendMessage(newMessage2);
                          messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
