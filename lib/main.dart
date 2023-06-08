import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flightapp/Screens/searchBottomSheetFrom.dart';
import 'app_state.dart';
import 'Bloc/FliBloc.dart';
import 'Screens/FlightBookingPage.dart';
import 'Screens/FlightOption.dart';
import 'Screens/MyBookingScreen.dart';
import 'Screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'Theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: FlightBookingApp(),
    ),
  );
}

class FlightBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState()),
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flight Booking App',
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
