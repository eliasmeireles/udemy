import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:maximilian_schwarzmuller/data/post_api_service.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  _setupLogging();
  runApp(MainApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print("${rec.level.name}: ${rec.time}: ${rec.message}");
  });
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (context) => PostApiService.create(),
      dispose: (context, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
