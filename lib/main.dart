import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodiezone/constants/colors.dart';
import 'package:foodiezone/lanugage/languages.dart';
import 'package:foodiezone/provider/home_provider.dart';
import 'package:foodiezone/provider/theme_change_provider.dart';
import 'package:foodiezone/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeChangeProvider()),
      ],
      builder: (context, child) {
        final themeChnager = Provider.of<ThemeChangeProvider>(context);

        return GetMaterialApp(
          title: 'FoodieZone',
          debugShowCheckedModeBanner: false,
          translations: Languages(),
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          themeMode: themeChnager.themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: appcolor,
            ),
            appBarTheme: const AppBarTheme(
              color: appcolor,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xff30384C),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Color(0xff2C3448),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "DMSans Bold",
              ),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
