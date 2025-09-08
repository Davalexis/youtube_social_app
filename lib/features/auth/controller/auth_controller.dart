import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gemini_project/features/auth/service/auth_service.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<GoogleSignInAccount?>>((ref) {
  return AuthController(ref.watch(authServiceProvider));
});

class AuthController extends StateNotifier<AsyncValue<GoogleSignInAccount?>> {
  final AuthService _authService;
  StreamSubscription? _authStateSubscription;

  AuthController(this._authService) : super(const AsyncValue.loading()) {
    _authStateSubscription = _authService.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _authService.signInWithGoogle();
      // The stream will automatically update the state
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      // The stream will automatically update the state
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}