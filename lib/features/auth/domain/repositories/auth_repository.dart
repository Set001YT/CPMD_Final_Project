import '../entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> watchAuthState();
  Future<AuthUser> signInWithEmail(String email, String password);
  Future<AuthUser> registerWithEmail(String email, String password, String name);
  Future<void> signOut();
  AuthUser? get currentUser;
}
