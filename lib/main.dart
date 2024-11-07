import 'package:flutter/material.dart';
import 'package:salons_app/app.dart';
import 'package:salons_app/injection container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // /// bloc logger
  // if (kDebugMode) {
  //   Bloc.observer = LogBlocObserver();
  // }
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
