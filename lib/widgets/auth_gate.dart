import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/home_screen.dart';
import '../theme/app_theme.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isLoading) {
          return Scaffold(
            backgroundColor: AppColorsResolver.canvas(context),
            body: Center(
              child: CircularProgressIndicator(
                color: AppColorsResolver.link(context),
              ),
            ),
          );
        }

        if (auth.error != null && !auth.isInitialized) {
          return Scaffold(
            backgroundColor: AppColorsResolver.canvas(context),
            body: Padding(
              padding: const EdgeInsets.all(AppSpacing.s6),
              child: Center(
                child: Text(
                  auth.error!,
                  textAlign: TextAlign.center,
                  style: AppText.bodyFor(
                    context,
                  ).copyWith(color: AppColorsResolver.danger(context)),
                ),
              ),
            ),
          );
        }

        if (auth.isAuthenticated) {
          return const HomeScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
