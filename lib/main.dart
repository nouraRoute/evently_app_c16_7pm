import 'package:evently_app/common/theme/app_theme.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/providers/app_settings_provider.dart';
import 'package:evently_app/providers/auth_provider.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/screens/auth/login_screen.dart';
import 'package:evently_app/screens/events/new_event_screens.dart';
import 'package:evently_app/screens/auth/sign_up_screen.dart';
import 'package:evently_app/screens/home/main_layer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettingsProvider()),
        ChangeNotifierProvider(create: (context) => CurrantAuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = EventsProvider()..getAllEvents();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<AppSettingsProvider>(context).appLocalization),

      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        MainLayerScreen.routeName: (_) => ChangeNotifierProvider.value(
          value: eventsProvider,
          child: MainLayerScreen(),
        ),
        NewEventScreen.routeName: (_) => ChangeNotifierProvider.value(
          value: eventsProvider,
          child: NewEventScreen(),
        ),
      },
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<AppSettingsProvider>(context).currantThemeMode,
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? LoginScreen.routeName
          : MainLayerScreen.routeName,
    );
  }
}
