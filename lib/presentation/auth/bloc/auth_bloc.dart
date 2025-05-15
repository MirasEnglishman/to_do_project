
import 'package:to_do_project/data/repositories/auth_repository.dart';
import 'package:to_do_project/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authService;
  
  AuthCubit(this._authService) : super(AuthInitial()) {
    checkAuthStatus();
  }
  
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signIn(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
      print(e.toString());
    }
  }
  
  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUp(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  
  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _authService.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}