import 'package:flutter_test/flutter_test.dart';
import 'package:student_auth_mvc/main.dart';
import 'package:student_auth_mvc/controllers/auth_controller.dart';
import 'package:student_auth_mvc/repositories/auth_repository.dart';

void main() {
  testWidgets('اختبار تشغيل شاشة تسجيل الدخول الطلابي', (
    WidgetTester tester,
  ) async {
    // 1. تجهيز المستودع والمتحكم للاختبار
    final authRepository = AuthRepositoryImpl();
    final authController = AuthController(authRepository);

    // 2. تشغيل التطبيق الفعلي StudentAuthApp بدلاً من MyApp
    await tester.pumpWidget(StudentAuthApp(authController: authController));

    // 3. التأكد من ظهور عنوان شاشة تسجيل الدخول بنجاح
    expect(find.text('تسجيل الدخول الطلابي'), findsOneWidget);
  });
}
