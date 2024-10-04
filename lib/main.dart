import 'theme.dart';
import 'dart:async';
import 'routes.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_shop/screens/init_screen.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      runApp(const MyApp());
    },
    (error, stack) {
      debugPrint("runZonedGuarded: Caught error in my root zone. $error");
      if (!kDebugMode) {
        debugPrint("main.dart --> error $error | stack $stack");
      }
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userUid = 'unknown_uid';

  @override
  void initState() {
    FirebaseAuth.instance.currentUser?.reload();
    userUid = FirebaseAuth.instance.currentUser?.uid ?? 'unknown_uid';
    debugPrint('Sign-In Screen --> Current user uid: $userUid');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TECHSHOP',
      theme: AppTheme.lightTheme(context),
      initialRoute: userUid != 'unknown_uid' ? InitScreen.routeName : SplashScreen.routeName,
      routes: routes,
    );
  }
}
