import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import '../services/dio_factory.dart';
import '../services/extraction_service.dart';

/// Provides [ExtractionService] and [ApiService] wired to the current auth token.
class ServicesProvider extends StatelessWidget {
  const ServicesProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<AuthProvider, ExtractionService>(
      update: (_, auth, __) =>
          ExtractionService(createAuthenticatedDio(() => auth.accessToken)),
      dispose: (_, __) {},
      child: ProxyProvider<AuthProvider, ApiService>(
        update: (_, auth, __) =>
            ApiService(accessTokenProvider: () => auth.accessToken),
        dispose: (_, __) {},
        child: child,
      ),
    );
  }
}
