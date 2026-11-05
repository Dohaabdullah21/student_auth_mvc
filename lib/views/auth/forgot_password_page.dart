import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/form_validators.dart';
import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final AuthController controller;
  const ForgotPasswordPage({super.key, required this.controller});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;

    final identifier = _identifierController.text.trim();
    final success = await widget.controller.sendPasswordResetCode(identifier);

    if (!mounted) return;

    if (success) {
      // إظهار SnackBar أخضر كما هو مطلوب في التكليف
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم إرسال رمز التحقق (OTP) المكون من 6 أرقام بنجاح!'),
          backgroundColor: Colors.green,
        ),
      );

      // الانتقال تلقائياً لشاشة تعيين كلمة المرور الجديدة
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordPage(
            controller: widget.controller,
            identifier: identifier,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('استعادة كلمة المرور'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. البطاقة التوجيهية أعلى الشاشة
                    Card(
                      color: Colors.blue.shade50,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blue.shade200),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline, color: Colors.blue, size: 32),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'أدخل رقمك الأكاديمي أو بريدك الجامعي المسجل، وسنقوم بإرسال رمز تحقق (OTP) مكون من 6 أرقام لإعادة تعيين كلمة المرور الخاصة بك.',
                                style: TextStyle(fontSize: 14, height: 1.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 2. حقل البريد أو الرقم الأكاديمي مع التحقق
                    TextFormField(
                      controller: _identifierController,
                      decoration: const InputDecoration(
                        labelText: 'الرقم الأكاديمي أو البريد الجامعي',
                        prefixIcon: Icon(Icons.account_box_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: FormValidators.validateLoginIdentifier,
                    ),
                    const SizedBox(height: 24),

                    // 3. زر إرسال رمز التحقق
                    ElevatedButton(
                      onPressed: widget.controller.isLoading ? null : _sendCode,
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
                              'إرسال رمز التحقق',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                    const SizedBox(height: 12),

                    // 4. زر العودة لتسجيل الدخول
                    TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('العودة لتسجيل الدخول'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}