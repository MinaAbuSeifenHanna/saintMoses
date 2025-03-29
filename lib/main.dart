// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localization/flutter_localization.dart';
// import 'package:provider/provider.dart';
// import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
// import 'core/local/app_local.dart';
// import 'core/theme/provider_theme.dart';
// import 'core/theme/theme_data.dart';
// import 'features/add_famaily/presentation/views/homeVeiw.dart';
//
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterLocalization.instance.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(
//
//       MyApp()
//
//   );
// }
//
// class MyApp extends StatefulWidget {
//
//   MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final FlutterLocalization localization = FlutterLocalization.instance;
//
//   @override
//   void initState() {
//     localization.init(
//       mapLocales: [
//         const MapLocale('en', AppLocale.EN),
//         const MapLocale('ar', AppLocale.AR),
//       ],
//       initLanguageCode: 'en',
//     );
//     localization.onTranslatedLanguage = _onTranslatedLanguage;
//     super.initState();
//   }
//
//   void _onTranslatedLanguage(Locale? locale) {
//     setState(() {});
//   }
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return BlocProvider(
//       create: (context) => FamilyCubit()..getMembers(),
//       child: MaterialApp(
//         supportedLocales: localization.supportedLocales,
//         localizationsDelegates: localization.localizationsDelegates,
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         themeMode: themeProvider.themeMode,
//         theme: AppThemes.lightTheme,
//         darkTheme: AppThemes.darkTheme,
//         home:  ChangeNotifierProvider(
//             create:(context) => ThemeProvider(),
//             child: HomeScreen()),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:saint_moses_the_black_system/features/add_famaily/presentation/manager/family_cubit.dart';
import 'core/local/app_local.dart';
import 'core/theme/provider_theme.dart';
import 'core/theme/theme_data.dart';
import 'features/add_famaily/presentation/views/homeVeiw.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    localization.init(
      mapLocales: [
        const MapLocale('en', AppLocale.EN),
        const MapLocale('ar', AppLocale.AR),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = _onTranslatedLanguage;
    super.initState();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocProvider(
      create: (context) => FamilyCubit()..getMembers(),
      child: MaterialApp(
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: themeProvider.themeMode,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
