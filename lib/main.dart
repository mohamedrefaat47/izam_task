import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:izam_task/providers/user_provider.dart';
import 'package:izam_task/utils/routes.dart';
import 'package:izam_task/theme/styles.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    run();
  });
}

void run() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Styles.backgroundColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          locale: const Locale('en'),
          routes: routes,
        ));
  }
}
