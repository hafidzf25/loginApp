import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      try {
        final email = event.email;
        final password = event.password;

        if (password.length < 6) {
          return emit(AuthFailure(
              failureMessage: 'Password can\'t less than 6 characters'));
        }

        // Mengapa ada future dan menunggu? Untuk mengecek dalam database dengan waktu 1 detik
        await Future.delayed(
          Duration(seconds: 1),
          () {
            return emit(AuthSuccess(uid: '$email-$password'));
          },
        );
      } on Exception catch (e) {
        return emit(AuthFailure(failureMessage: e.toString()));
      }
    });
  }
}
