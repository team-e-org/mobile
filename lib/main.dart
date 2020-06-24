import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/bloc/simple_bloc_delegate.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mobile/view/pinterest_application.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.level = Level.verbose;
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final prefs = await AuthenticationPreferences.create();

  runApp(PinterestApplication(
    prefs: prefs,
  ));
}
