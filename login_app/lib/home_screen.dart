import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/bloc/auth_bloc.dart';
import 'package:login_app/login_screen.dart';
import 'package:login_app/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Hello ${(state as AuthSuccess).uid}'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              children: [
                Text('Welcome!'),
                GradientButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
