// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/material.dart';
// import 'package:medify/core/routing/app_router.dart';
// import 'package:provider/provider.dart';
// import 'core/helpers/cache_manager.dart';
// import 'core/helpers/tapProvider.dart';

// void main() async {
//   await CacheManager.init();
//   runApp(
//     // this multi privider for bottom nav bar to work
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => tapProvider()),
//       ],
//       child: DevicePreview(
//         enabled: true,
//         builder: (context) => ChangeNotifierProvider(
//           create: (context) => tapProvider(),
//           child: const gradeApp(),
//         ),
//       ),
//     ),
//   );
// }

// class gradeApp extends StatelessWidget {
//   const gradeApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // note that : we are working on iphone 12 pro max
//     // do not delete this comment
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: AppRouter.generateRoute,
//     );
//   }
// }


import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/core/routing/app_router.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD

import 'core/helpers/cache_manager.dart';
import 'core/helpers/tapProvider.dart';

void main() async {
  await CacheManager.init();
=======
<<<<<<< HEAD
import 'core/helpers/cache_manager.dart';
import 'core/helpers/tapProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ إصلاح مشكلة التهيئة
  await CacheManager.init(); // تأكد من التهيئة الصحيحة
=======

import 'core/helpers/tapProvider.dart';
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293

>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => tapProvider()),
      ],
      child: DevicePreview(
        enabled: true,
        builder: (context) => const GradeApp(), // ✅ استخدام const
      ),
    ),
  );
}

class GradeApp extends StatelessWidget {
  const GradeApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
=======
    // note that : we are working on iphone 12 pro max
    // do not delete this comment
    return const MaterialApp(
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder, // ✅ حل مشكلة context
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
    );
  }
}