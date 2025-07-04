import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/core/routing/app_router.dart';
import 'package:provider/provider.dart';

import 'core/helpers/cache_manager.dart';
import 'core/helpers/tapProvider.dart';

void main() async {
  await CacheManager.init();
  runApp(
    // this multi privider for bottom nav bar to work
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => tapProvider()),
      ],
      child: Builder(builder: (context) {
        return DevicePreview(
          enabled: true,
          builder: (context) => ChangeNotifierProvider(
            create: (context) => tapProvider(),
            child: const gradeApp(),
          ),
        );
      }),
    ),
  );
}

class gradeApp extends StatelessWidget {
  const gradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // note that : we are working on iphone 12 pro max
    // do not delete this comment
    return MaterialApp(
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
