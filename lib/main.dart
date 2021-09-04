import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';
import 'package:yasaline/provider/get_rule.dart';
import 'package:yasaline/screens/matter_screen.dart';
import 'package:yasaline/screens/part_screen.dart';
import 'package:yasaline/screens/rules_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GetRullProvider())
      ],
      child: VRouter(
        title: 'Yasaline',
        theme: ThemeData(),
        routes: [
          VWidget(path: '/', widget: const RulesScreen()),
          ////////////////
          VPopHandler(
            onSystemPop: (v) async {
              v.to('/', isReplacement: true);
            },
            onPop: (v) async {
              v.to('/', isReplacement: true);
            },
            stackedRoutes: [
              VWidget(
                  path: '/law/:id', widget: const MatterScreen(), name: '/law'),
            ],
          ),
          /////////////////
          VPopHandler(
            onSystemPop: (v) async {
              v.to('/', isReplacement: true);
            },
            onPop: (v) async {
              var lawId = v.previousVRouterData!.pathParameters['lawId'];
              v.toNamed('/law',
                  pathParameters: {'id': lawId!}, isReplacement: true);
            },
            stackedRoutes: [
              VWidget(
                  path: '/law/:lawId/matter/:id',
                  widget: const PartScreen(),
                  name: '/matter'),
            ],
          )
        ],
      ),
    );
  }
}
