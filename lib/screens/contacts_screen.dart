import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:message_app_solid/screens/messages_screen.dart';
import 'package:message_app_solid/utils/styles/app_text_styles.dart';
import '../cubit/chat_cubit/contact_cubit.dart';
import 'add_contact_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contactsCubit = context.watch<ContactCubit>();
    contactsCubit.getAllContacts();
    final contacts = contactsCubit.state;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Conversations",
          style: AppTextStyle.interSemiBold.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactScreen()));
            },
            icon: SvgPicture.asset("assets/icons/add_char.svg"),
          ),
        ],
      ),
      body: ListView(
        children: [
          ...List.generate(contacts.length, (index) {
            final contact = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                maxRadius: 25,
                backgroundImage: contact.imageUrl.isNotEmpty
                    ? AssetImage(contact.imageUrl)
                    : null,
                child: contact.imageUrl.isEmpty
                    ? Text("(:")
                    : null,
              ),
              title: Text(
                "${contact.contactName} ${contact.contactLasName}",
                style: AppTextStyle.interSemiBold.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                "Tap to see messages",
                style: AppTextStyle.interSemiBold.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessagesScreen(contact),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
