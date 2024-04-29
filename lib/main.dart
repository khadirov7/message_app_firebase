import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:message_app_solid/screens/contacts_screen.dart';
import 'package:message_app_solid/services/firebase_options.dart';
import 'cubit/chat_cubit/contact_cubit.dart';
import 'cubit/chat_cubit/message_cubit.dart';
import 'cubit/file_cubit/file_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp()); 
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactCubit>(
          create: (context) => ContactCubit(firestore),
        ),
        BlocProvider<MessageCubit>(
          create: (context) => MessageCubit(firestore),
        ),
        BlocProvider<FileManagerCubit>(
          create: (context) => FileManagerCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const ContactsScreen(),
      ),
    );
  }
}
