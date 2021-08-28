import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/AuthenticationBloc.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/blocs/CustomerHomeBloc.dart';
import 'package:scheduler/views/mobile/HomeScreen.dart';
import 'package:scheduler/views/mobile/LandingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartBloc()),
        ChangeNotifierProvider(create: (context) => CustomerHomeBloc()),
        ChangeNotifierProvider(create: (context) => AuthenticationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scheduler',
        theme: ThemeData(
          splashFactory: InkRipple.splashFactory,
          splashColor: Colors.white24,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Color(0xffecebf1),
          // primarySwatch: createMaterialColor(Colors.blueAccent),
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationBloc>(
      builder: (context, value, child) {
        if (FirebaseAuth.instance.currentUser == null) {
          return LandingScreen();
        } else {
          return HomeScreen(adminMode: true);
        }
      },
    );
  }
}

// MaterialColor createMaterialColor(Color color) {
//   List strengths = <double>[.05];
//   Map swatch = <int, Color>{};
//   final int r = color.red, g = color.green, b = color.blue;

//   for (int i = 1; i < 10; i++) {
//     strengths.add(0.1 * i);
//   }
//   strengths.forEach((strength) {
//     final double ds = 0.5 - strength;
//     swatch[(strength * 1000).round()] = Color.fromRGBO(
//       r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//       g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//       b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//       1,
//     );
//   });
//   return MaterialColor(color.value, swatch);
// }
