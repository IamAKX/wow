import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/firebase_options.dart';
import 'package:worldsocialintegrationapp/screens/home_container/home_container.dart';
import 'package:worldsocialintegrationapp/screens/onboarding/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'providers/generic_auth_provider.dart';
import 'utils/router.dart';

bool isLoggedIn = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  isLoggedIn = GenericAuthProvider.instance.user != null;
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
        home: isLoggedIn ? const HomeContainer() : const SplashScreen(),
        navigatorKey: navigatorKey,
        onGenerateRoute: NavRoute.generatedRoute,
      ),
    );
  }
}
