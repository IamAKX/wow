import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worldsocialintegrationapp/firebase_options.dart';
import 'package:worldsocialintegrationapp/providers/api_call_provider.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'providers/generic_auth_provider.dart';
import 'services/fcm_service.dart';
import 'utils/generic_api_calls.dart';
import 'utils/router.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMService.instance.initializeFCM();

  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => GenericAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => ApiCallProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Wow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: Colors.black,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          useMaterial3: false,
        ),
        supportedLocales: const [
          Locale('en'),
        ],
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: isUserLoggedIn() ? const HomeContainer() : const SplashScreen(),
        navigatorKey: navigatorKey,
        onGenerateRoute: NavRoute.generatedRoute,
      ),
    );
  }

  bool isUserLoggedIn() {
    bool res = prefs.containsKey(PrefsKey.loginProvider);
    if (res) {
      getDailyReward();
    }
    return res;
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const HomeContainer();
        } else {
          return const SplashScreen();
        }
      },
    );
  }
}
