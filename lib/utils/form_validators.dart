class FormValidators {
  // 1. التحقق من معرف الدخول (الرقم الأكاديمي أو البريد: لا يقل عن 5 خانات)
  static String? validateLoginIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الرقم الأكاديمي أو البريد الجامعي';
    }
    if (value.trim().length < 5) {
      return 'يجب أن يتكون المعرف من 5 خانات على الأقل';
    }
    return null; // الإدخال سليم
  }

  // 2. التحقق من كلمة مرور تسجيل الدخول (لا تقل عن 6 محارف)
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 محارف على الأقل';
    }
    return null;
  }

  // 3. التحقق من الاسم الكامل (لا يقل عن 3 محارف)
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الاسم الكامل';
    }
    if (value.trim().length < 3) {
      return 'الاسم الكامل يجب أن يكون 3 أحرف على الأقل';
    }
    return null;
  }

  // 4. التحقق من الرقم الأكاديمي (أرقام فقط، من 9 إلى 10 خانات)
  static String? validateAcademicId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الرقم الأكاديمي';
    }
    // تعبير نمطي (Regex) يتحقق أن النص أرقام فقط وطوله بين 9 و 10
    final academicIdRegex = RegExp(r'^\d{9,10}$');
    if (!academicIdRegex.hasMatch(value.trim())) {
      return 'الرقم الأكاديمي يجب أن يتكون من أرقام فقط (9 إلى 10 خانات)';
    }
    return null;
  }

  // 5. التحقق من البريد الجامعي (صيغة Regex قياسية للبريد الإلكتروني)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال البريد الجامعي';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'يرجى إدخال بريد إلكترونيجامعي بصيغة صحيحة';
    }
    return null;
  }

  // 6. التحقق من كلمة المرور القوية (8 محارف على الأقل + رقم + حرف كبير)
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب أن لا تقل عن 8 محارف';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل (A-Z)';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل (0-9)';
    }
    return null;
  }

  // 7. التحقق من تطابق تأكيد كلمة المرور مع كلمة المرور الأصلية
  static String? validateConfirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != originalPassword) {
      return 'كلمتا المرور غير متطابقتين';
    }
    return null;
  }

  // 8. التحقق من رمز التحقق OTP (6 أرقام رقمية حصراً)
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال رمز التحقق (OTP)';
    }
    final otpRegex = RegExp(r'^\d{6}$');
    if (!otpRegex.hasMatch(value.trim())) {
      return 'رمز التحقق يجب أن يتكون من 6 أرقام فقط';
    }
    return null;
  }
}