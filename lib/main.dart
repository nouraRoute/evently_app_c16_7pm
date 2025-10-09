import 'package:evently_app/common/theme/app_theme.dart';
import 'package:evently_app/screens/auth/login_screen.dart';
import 'package:evently_app/screens/events/new_event_screens.dart';
import 'package:evently_app/screens/auth/sign_up_screen.dart';
import 'package:evently_app/screens/home/main_layer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        MainLayerScreen.routeName: (_) => MainLayerScreen(),
        NewEventScreen.routeName: (_) => NewEventScreen(),
      },
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? LoginScreen.routeName
          : MainLayerScreen.routeName,
    );
  }
}
