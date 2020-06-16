import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mobile/bloc/simple_bloc_delegate.dart';
import 'package:mobile/view/pinterest_application.dart';

void main() {
  Logger.level = Level.verbose;
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(PinterestApplication());
}
