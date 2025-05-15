import 'package:to_do_project/data/models/user.dart';
import 'package:to_do_project/utlis/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<UserModel?> getCurrentUser();
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  Future<void> saveUserLocally(UserModel user);
  Future<UserModel?> getUserLocally();
  Future<void> clearUserLocally();
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SharedPreferenceHelper _preferenceHelper = SharedPreferenceHelper();

  @override
  Future<UserModel?> getCurrentUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      return await getUserLocally();
    }
    
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      displayName: firebaseUser.displayName,
      isEmailVerified: firebaseUser.emailVerified,
    );
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final User? firebaseUser = result.user;
      if (firebaseUser == null) {
        throw Exception('Пользователь не найден');
      }
      
      final UserModel user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        displayName: firebaseUser.displayName,
        isEmailVerified: firebaseUser.emailVerified,
      );
      
      await saveUserLocally(user);
      return user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            throw Exception('Пользователь с таким email не найден');
          case 'wrong-password':
            throw Exception('Неверный пароль');
          case 'invalid-email':
            throw Exception('Неверный формат email');
          case 'user-disabled':
            throw Exception('Учетная запись отключена');
          default:
            throw Exception('Ошибка авторизации: ${e.message}');
        }
      }
      throw Exception('Ошибка авторизации: $e');
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final User? firebaseUser = result.user;
      if (firebaseUser == null) {
        throw Exception('Ошибка при создании пользователя');
      }
      
      final UserModel user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        displayName: firebaseUser.displayName,
        isEmailVerified: firebaseUser.emailVerified,
      );
      
      await saveUserLocally(user);
      return user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            throw Exception('Email уже используется');
          case 'invalid-email':
            throw Exception('Неверный формат email');
          case 'weak-password':
            throw Exception('Пароль слишком простой');
          case 'operation-not-allowed':
            throw Exception('Операция не разрешена');
          default:
            throw Exception('Ошибка регистрации: ${e.message}');
        }
      }
      throw Exception('Ошибка регистрации: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await clearUserLocally();
  }

  @override
  Future<void> saveUserLocally(UserModel user) async {
    await _preferenceHelper.saveUser(user);
  }

  @override
  Future<UserModel?> getUserLocally() async {
    return _preferenceHelper.getUser();
  }

  @override
  Future<void> clearUserLocally() async {
    await _preferenceHelper.clearUser();
  }
}