import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:movie_app/presentation/movie_app.dart';
import 'package:path_provider/path_provider.dart';
import 'data/tables/movie_table.dart';
import 'di/get_it.dart' as getIt;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  unawaited(getIt.inti());
  final appDocumentDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocumentDir.path;
  Hive.init(appDocPath);
  Hive.registerAdapter(MovieTableAdapter());
  runApp(const MovieApp());
}


