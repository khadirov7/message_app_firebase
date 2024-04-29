import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_cubit/contact_cubit.dart';
import '../data/models/contact_model.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController contactId = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: ListView(
          children:  [
             Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Name',
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: lastName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                  hintText: 'Enter Last Name',
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: contactId,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact ID',
                  hintText: 'Enter Contact ID',
                ),
              ),
            ),
            TextButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                onPressed: () {
                  final newContact = ContactModel(
                    contactId: int.parse(contactId.text),
                    contactLasName: lastName.text,
                    contactName: name.text,
                    isOnline: true,
                    imageUrl: "",
                    lastOnlineTime: DateTime.now(),
                  );
                  context.read<ContactCubit>().createContact(newContact);
                  Navigator.pop(context);
            }, child: const Text("Add Contact",style: TextStyle(color: Colors.black),))
          ],
        ),
      ),
    );
  }
}
