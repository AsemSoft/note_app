import 'package:notes/view/note_add_screen.dart';
import 'package:notes/view/note_home_Screen.dart';

class Routes {
  static const initialRoute = '/';
  static const noteAddScreen = 'noteAddScreen';
  static const noteEditScreen = 'noteEditScreen';
}

class AppRoutes {
  static final routes = {
    Routes.initialRoute: (context) => NoteHomeScreen(),
    Routes.noteAddScreen: (context) => NoteAddSceen(),
    // Routes.noteEditScreen: (context) => NoteEditScreen(),
  };
}
