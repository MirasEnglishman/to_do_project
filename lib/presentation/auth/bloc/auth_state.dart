import 'package:asyl_project/data/models/user.dart';
import 'package:equatable/equatable.dart';


// События состояния
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

// Начальное состояние
class AuthInitial extends AuthState {}

// Загрузка
class AuthLoading extends AuthState {}

// Авторизован
class AuthAuthenticated extends AuthState {
  final UserModel user;
  
  const AuthAuthenticated(this.user);
  
  @override
  List<Object?> get props => [user];
}

// Не авторизован
class AuthUnauthenticated extends AuthState {}

// Ошибка
class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);
  
  @override
  List<Object?> get props => [message];
}