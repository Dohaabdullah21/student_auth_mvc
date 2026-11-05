import 'package:flutter/foundation.dart';
import '../models/auth_models.dart';
import '../repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  // الاعتماد على العقد التجريدي للمستودع (Dependency Injection)
  final AuthRepository _repository;

  AuthController(this._repository);

  // متغيرات الحالة (State Variables)
  bool _isLoading = false;        // هل هناك عملية شبكة جارية الآن؟
  String? _errorMessage;          // رسالة الخطأ إن وجدت
  UserModel? _currentUser;        // بيانات الطالب المسجل حالياً

  // دوال القراءة (Getters) للوصول الآمن من الشاشات
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;

  // دالة مساعدة لتحديث حالة التحميل وإشعار الواجهة
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // يخبر الواجهة بإعادة بناء الأجزاء المستمعة
  }

  // 1. عملية تسجيل الدخول
  Future<bool> login(LoginRequest request) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _currentUser = await _repository.login(request);
      _setLoading(false);
      return true; // نجح الدخول
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false; // فشل الدخول
    }
  }

  // 2. عملية إنشاء حساب جديد
  Future<bool> register(RegisterRequest request) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      _currentUser = await _repository.register(request);
      _setLoading(false);
      return true; // نجح التسجيل
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // 3. عملية إرسال رمز استعادة كلمة المرور
  Future<bool> sendPasswordResetCode(String identifier) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _repository.sendPasswordResetCode(identifier);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }

  // 4. عملية تعيين كلمة المرور الجديدة
  Future<bool> resetPassword(ResetPasswordRequest request) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _repository.resetPassword(request);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setLoading(false);
      return false;
    }
  }
}