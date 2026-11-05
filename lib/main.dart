import 'package:flutter/material.dart';
import 'controllers/auth_controller.dart';
import 'repositories/auth_repository.dart';
import 'views/auth/login_page.dart';

void main() {
  // 1. إنشاء نسخة من المستودع (Repository)
  final AuthRepository authRepository = AuthRepositoryImpl();

  // 2. حقن المستودع داخل المتحكم (Controller)
  final AuthController authController = AuthController(authRepository);

  // 3. تشغيل التطبيق وتمرير المتحكم
  runApp(StudentAuthApp(authController: authController));
}

class StudentAuthApp extends StatelessWidget {
  final AuthController authController;

  const StudentAuthApp({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام المصادقة الطلابي - MVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginPage(controller: authController),
    );
  }
}