import 'theme.dart';
import 'dart:async';
import 'routes.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/splash/splash_screen.dart';
import 'components/config_easy_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_shop/screens/init_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      /// Set theme for EasyLoader indicator
      ConfigEasyLoader.darkTheme();

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
      builder: (context, child) {
        child = EasyLoading.init()(context, child);
        return ScrollConfiguration(
          behavior: AppBehavior(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'TECHSHOP',
      theme: AppTheme.lightTheme(context),
      initialRoute: userUid != 'unknown_uid' ? InitScreen.routeName : SplashScreen.routeName,
      routes: routes,
    );
  }
}

/// To remove scroll glow
class AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
