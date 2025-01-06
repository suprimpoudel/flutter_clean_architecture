import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/di/app_module.dart';
import 'package:flutter_clean_architecture/feature/home/presentation/manager/tab_bloc.dart';
import 'package:flutter_clean_architecture/feature/home/presentation/pages/home_page.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_bloc.dart';

// dart run build_runner build --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await appModuleSetup();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TabBloc>(
          create: (_) => TabBloc(),
        ),
        RepositoryProvider<UserBloc>(
          create: (_) => UserBloc(locator()),
        ),
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
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
