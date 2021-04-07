import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:organize_flutter_project/src/app.dart';
import 'package:organize_flutter_project/src/business_logic/services/hive_services/hive_services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await HiveServices.init();
  runApp(BDonorApp());
}