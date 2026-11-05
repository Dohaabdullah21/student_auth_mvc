import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/auth_models.dart';
import '../../utils/form_validators.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final AuthController controller;
  const LoginPage({super.key, required this.controller});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // مفتاح النموذج لفحص كافة الحقول دفعة واحدة عند الضغط على الزر
  final _formKey = GlobalKey<FormState>();

  // متحكمات النصوص لقراءة ما يكتبه الطالب
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  // متغيرات حالة الواجهة المحلية (إخفاء كلمة المرور + تذكرني)
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    // تنظيف الذاكرة عند إغلاق الشاشة
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // دالة تنفيذ تسجيل الدخول عند الضغط على الزر
  Future<void> _submitLogin() async {
    // 1. فحص صحة النموذج عبر GlobalKey<FormState>
    if (!_formKey.currentState!.validate()) return;

    // 2. تجهيز كائن الطلب
    final request = LoginRequest(
      identifier: _identifierController.text.trim(),
      password: _passwordController.text,
      rememberMe: _rememberMe,
    );

    // 3. استدعاء الدالة من المتحكم
    final success = await widget.controller.login(request);

    if (!mounted) return;

    // 4. عرض النتيجة للطالب
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم تسجيل الدخول بنجاح! مرحباً بك.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.controller.errorMessage ?? 'حدث خطأ'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ListenableBuilder يستمع لتغيرات AuthController بدون أي حزم خارجية
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('تسجيل الدخول الطلابي'),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.school, size: 80, color: Colors.blue),
                      const SizedBox(height: 16),
                      const Text(
                        'بوابة الطالب الأكاديمية',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),

                      // حقل المعرف الأكاديمي أو البريد
                      TextFormField(
                        controller: _identifierController,
                        decoration: const InputDecoration(
                          labelText: 'الرقم الأكاديمي أو البريد الجامعي',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: FormValidators.validateLoginIdentifier,
                      ),
                      const SizedBox(height: 16),

                      // حقل كلمة المرور مع زر الإخفاء/الإظهار (Obscure Toggle)
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: FormValidators.validateLoginPassword,
                      ),
                      const SizedBox(height: 8),

                      // صف يحتوي على "تذكرني" ورابط "نسيت كلمة المرور؟"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (val) {
                                  setState(() {
                                    _rememberMe = val ?? false;
                                  });
                                },
                              ),
                              const Text('تذكرني'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ForgotPasswordPage(
                                    controller: widget.controller,
                                  ),
                                ),
                              );
                            },
                            child: const Text('نسيت كلمة المرور؟'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // زر تسجيل الدخول مع مؤشر التحميل
                      ElevatedButton(
                        onPressed: widget.controller.isLoading ? null : _submitLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: widget.controller.isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(strokeWidth: 2.5),
                              )
                            : const Text(
                                'تسجيل الدخول',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                      const SizedBox(height: 16),

                      // رابط إنشاء حساب جديد للتوجه لشاشة RegisterPage
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('طالب مستجد ولا تملك حساباً؟'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RegisterPage(
                                    controller: widget.controller,
                                  ),
                                ),
                              );
                            },
                            child: const Text('إنشاء حساب جديد'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}