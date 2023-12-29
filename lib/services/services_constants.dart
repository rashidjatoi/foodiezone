import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firebaseAuth = FirebaseAuth.instance;
final user = firebaseAuth.currentUser;
final firebaseDatabase = FirebaseDatabase.instance.ref('users');
final orderDatabase = FirebaseDatabase.instance.ref('orders');
final foodProviderDatabase = FirebaseDatabase.instance.ref('foodprovider');
final foodDriverDatabase = FirebaseDatabase.instance.ref('fooddriver');

final databaseRef = FirebaseDatabase.instance.ref(user.toString());
final hostelDatabase = FirebaseDatabase.instance.ref('Hostel');

final uid = user!.uid;

final helpdeskDatabase = FirebaseDatabase.instance.ref('helpdesk');

final storage = FirebaseStorage.instance;
