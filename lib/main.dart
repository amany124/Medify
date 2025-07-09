import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/core/routing/app_router.dart';
import 'package:provider/provider.dart';

import 'core/di/di.dart';
import 'core/helpers/cache_manager.dart';
import 'core/helpers/local_data.dart';
import 'core/helpers/tapProvider.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    LocalData.init(),
  ]);

  await CacheManager.init();
  runApp(
    // this multi privider for bottom nav bar to work
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TapProvider()),
      ],
      child: Builder(builder: (context) {
        return DevicePreview(
          enabled: true,
          builder: (context) => ChangeNotifierProvider(
            create: (context) => TapProvider(),
            child: const GradeApp(),
          ),
        );
      }),
    ),
  );
}

class GradeApp extends StatelessWidget {
  const GradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // note that : we are working on iphone 12 pro max
    // do not delete this comment
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
