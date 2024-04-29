import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/contact_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCubit extends Cubit<List<ContactModel>> {

  ContactCubit(this.firestore) : super([]);
  final FirebaseFirestore firestore;

  Future<void> createContact(ContactModel contact) async {
    await firestore.collection('contacts').doc(contact.contactId.toString()).set(contact.toJson());
  }

  Future<void> getAllContacts() async {
    final querySnapshot = await firestore.collection('contacts').get();
    final contacts = querySnapshot.docs.map((doc) => ContactModel.fromJson(doc.data()!)).toList();
    emit(contacts);
  }
}
