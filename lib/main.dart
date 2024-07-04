import 'package:coursedog_app/models/user.dart';
import 'package:coursedog_app/notifiers/favourites.dart';
import 'package:coursedog_app/notifiers/term.dart';
import 'package:coursedog_app/notifiers/user.dart';
import 'package:coursedog_app/pages/login.dart';
import 'package:coursedog_app/pages/magic_link.dart';
import 'package:coursedog_app/pages/home.dart';
import 'package:coursedog_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;
  runApp(Coursedog(user: user));
}

class Coursedog extends StatelessWidget {
  final User? user;
  const Coursedog({super.key, this.user});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserNotifier(user)),
          ChangeNotifierProvider(create: (context) => TermNotifier()),
          ChangeNotifierProvider(create: (context) => FavouritesNotifier()),
        ],
        child: GetMaterialApp(
          title: 'Coursedog',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF4e80ff)),
            useMaterial3: true,
          ),
          home: user != null ? const Home() : const LoginPage(),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => const LoginPage(),
            '/magic-link': (BuildContext context) => const MagicLink(),
            '/home': (BuildContext context) => const Home(),
          },
        ));
  }
}
