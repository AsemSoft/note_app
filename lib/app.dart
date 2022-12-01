import 'package:flutter/material.dart';

import 'config/routes/routes.dart';

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
