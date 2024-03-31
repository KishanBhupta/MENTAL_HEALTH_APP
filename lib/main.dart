import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mental_helth_wellness/controllers/commentController.dart';
import 'package:mental_helth_wellness/controllers/postController.dart';
import 'package:mental_helth_wellness/views/auth/loginScreen.dart';
import 'package:mental_helth_wellness/views/splashScreen.dart';

import 'utils/localStorage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().initializeLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        // post controller
        Get.put(PostController());
        // comment controller
        Get.put(CommentsController());
      }),
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        )
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}


