import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/bloc/simple_bloc_delegate.dart';
import 'package:mobile/view/pinterest_application.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.level = Level.verbose;
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final prefs = await SharedPreferences.getInstance();

  runApp(PinterestApplication(
    prefs: prefs,
  ));
}
