import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:webkit/helpers/localizations/app_localization_delegate.dart';
import 'package:webkit/routes.dart';

import 'helpers/localizations/language.dart';
import 'helpers/services/navigation_service.dart';
import 'helpers/storage/local_storage.dart';
import 'helpers/theme/app_notifier.dart';
import 'helpers/theme/app_style.dart';
import 'helpers/theme/theme_customizer.dart';

const firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyAZhJZTHXDPIUkSGcmrSAbpbVL9J8eC8rw",
    authDomain: "focus-security.firebaseapp.com",
    databaseURL: "https://focus-security-default-rtdb.firebaseio.com",
    projectId: "focus-security",
    storageBucket: "focus-security.appspot.com",
    messagingSenderId: "386705559202",
    appId: "1:386705559202:web:201daaead1695df3fc11fb",
    measurementId: "G-ZNENX9C5ZR"
);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(options: firebaseOptions);
  setPathUrlStrategy();

  await LocalStorage.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  // await Translator.clearTrans();
  // Translator.getUnTrans();

  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (_, notifier, ___) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: "/",
          getPages: getPageRoute(),
          // onGenerateRoute: (_) => generateRoute(context, _),
          builder: (_, child) {
            NavigationService.registerContext(_);
            return Directionality(
                textDirection: AppTheme.textDirection,
                child: child ?? Container());
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),

          // home: ButtonsPage(),
        );
      },
    );
  }
}
