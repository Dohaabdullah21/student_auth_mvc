// 1. نموذج بيانات الطالب بعد تسجيل الدخول أو التسجيل
class UserModel {
  final String fullName;    // الاسم الكامل للطالب
  final String academicId;  // الرقم الأكاديمي
  final String email;       // البريد الجامعي

  // المشيد (Constructor) لإجبار تمرير هذه البيانات عند إنشاء كائن الطالب
  UserModel({
    required this.fullName,
    required this.academicId,
    required this.email,
  });
}

// 2. نموذج طلب تسجيل الدخول (يرسل من شاشة الدخول إلى المستودع)
class LoginRequest {
  final String identifier; // يقبل الرقم الأكاديمي أو البريد الجامعي
  final String password;   // كلمة المرور
  final bool rememberMe;   // حالة خيار "تذكرني"

  LoginRequest({
    required this.identifier,
    required this.password,
    this.rememberMe = false,
  });
}

// 3. نموذج طلب إنشاء حساب جديد (يرسل من شاشة التسجيل إلى المستودع)
class RegisterRequest {
  final String fullName;
  final String academicId;
  final String email;
  final String password;

  RegisterRequest({
    required this.fullName,
    required this.academicId,
    required this.email,
    required this.password,
  });
}

// 4. نموذج طلب تعيين كلمة مرور جديدة
class ResetPasswordRequest {
  final String identifier;  // البريد أو الرقم الأكاديمي الذي طلب الاستعادة
  final String otpCode;     // رمز التحقق المكون من 6 أرقام
  final String newPassword; // كلمة المرور الجديدة

  ResetPasswordRequest({
    required this.identifier,
    required this.otpCode,
    required this.newPassword,
  });
}