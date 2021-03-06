import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/bloc/simple_bloc_delegate.dart';
import 'package:mobile/config.dart';
import 'package:mobile/data/authentication_preferences.dart';
import 'package:mobile/view/pinterest_application.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.level = Level.verbose;
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final config = await readConfig();
  final prefs = await AuthenticationPreferences.create();

  runApp(PinterestApplication(
    config: config,
    prefs: prefs,
  ));
}
