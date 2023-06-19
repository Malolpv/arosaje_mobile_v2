import 'package:arosaje_mobile/controllers/add_garden.dart';
import 'package:arosaje_mobile/controllers/list_gardens.dart';
import 'package:arosaje_mobile/screens/add_garden.dart';
import 'package:arosaje_mobile/screens/garden_details.dart';
import 'package:arosaje_mobile/screens/list_gardens.dart';
import 'package:arosaje_mobile/screens/login.dart';
import 'package:arosaje_mobile/screens/register.dart';
import 'package:arosaje_mobile/store/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/navigation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(create: (_) => NavigationController()),
        ListenableProvider(create: (_) => TokenController())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Navigator(
          pages: getPages(context),
          onPopPage: (route, result) {
            bool popStatus = route.didPop(result);
            if (popStatus == true) {
              Provider.of<NavigationController>(context, listen: false)
                  .changeScreen('/');
            }
            return popStatus;
          },
        ));
  }

  List<Page> getPages(context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context);
    List<Page> pages = [];

    String? token =
        Provider.of<TokenController>(context, listen: false).getToken();

    //not logged in
    if (token == null) {
      if (navigation.screenName == '/register') {
        pages.add(const MaterialPage(child: RegisterScreen()));
      } else {
        pages.add(const MaterialPage(child: LoginScreen()));
      }
    } else {
      pages.add(MaterialPage(child: ListGardens(ListGardensController(token))));

      switch (navigation.screenName) {
        case '/gardenDetails':
          pages.add(const MaterialPage(child: GardenDetails()));
          break;
        case '/addGarden':
          pages.add(
              MaterialPage(child: AddGardenScreen(AddGardenController(token))));
          break;
      }
    }

    return pages;
  }
}
