import '../models/auth_models.dart';

abstract class AuthRepository {
  Future<UserModel> login(LoginRequest request);
  Future<UserModel> register(RegisterRequest request);
  Future<void> sendPasswordResetCode(String identifier);
  Future<void> resetPassword(ResetPasswordRequest request);
}

// كلاس داخلي بسيط لحفظ بيانات الطالب في الذاكرة
class _StoredUser {
  final String fullName;
  final String academicId;
  final String email;
  String password;

  _StoredUser({
    required this.fullName,
    required this.academicId,
    required this.email,
    required this.password,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final List<_StoredUser> _mockDatabase = [
    _StoredUser(
      fullName: 'طالب تجريبي',
      academicId: '2023110313',
      email: 'student@uni.edu',
      password: 'Password123',
    ),
  ];

  @override
  Future<UserModel> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 2));

    for (final user in _mockDatabase) {
      if (user.academicId == request.identifier ||
          user.email == request.identifier) {
        if (user.password != request.password) {
          throw Exception('كلمة المرور غير صحيحة لهذا الحساب');
        }
        return UserModel(
          fullName: user.fullName,
          academicId: user.academicId,
          email: user.email,
        );
      }
    }

    if (request.password == 'wrong123') {
      throw Exception('بيانات الدخول غير صحيحة');
    }

    return UserModel(
      fullName: 'طالب جامعي',
      academicId: request.identifier,
      email: 'student@uni.edu',
    );
  }

  @override
  Future<UserModel> register(RegisterRequest request) async {
    await Future.delayed(const Duration(seconds: 2));

    for (final user in _mockDatabase) {
      if (user.academicId == request.academicId ||
          user.email == request.email) {
        throw Exception('الرقم الأكاديمي أو البريد الجامعي مسجل مسبقاً');
      }
    }

    _mockDatabase.add(
      _StoredUser(
        fullName: request.fullName,
        academicId: request.academicId,
        email: request.email,
        password: request.password,
      ),
    );

    return UserModel(
      fullName: request.fullName,
      academicId: request.academicId,
      email: request.email,
    );
  }

  @override
  Future<void> sendPasswordResetCode(String identifier) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await Future.delayed(const Duration(seconds: 2));

    if (request.otpCode == '000000') {
      throw Exception('رمز التحقق (OTP) غير صحيح');
    }

    for (final user in _mockDatabase) {
      if (user.academicId == request.identifier ||
          user.email == request.identifier) {
        user.password = request.newPassword;
        break;
      }
    }
  }
}
