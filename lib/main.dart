import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instoo/providers/user_provider.dart';
import 'package:instoo/responsive/mobile_screen_layout.dart';
import 'package:instoo/responsive/responsive_layout_screen.dart';
import 'package:instoo/responsive/web_screen_layout.dart';
import 'package:instoo/screens/login_screen.dart';
import 'package:instoo/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Instoo',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.active) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
