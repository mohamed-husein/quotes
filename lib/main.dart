import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/app.dart';
import 'package:quotes/bloc_observer.dart';
import 'package:quotes/core/services/service_locator.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(const RandomQuotes());
}
