import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/services_provider.dart';
import 'theme/app_theme.dart';
import 'widgets/auth_gate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IstatisApp());
}

class IstatisApp extends StatelessWidget {
  const IstatisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider()..init(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, ChatProvider>(
          create: (_) => ChatProvider(),
          update: (_, auth, chat) {
            chat ??= ChatProvider();
            chat.updateApiService(auth);
            return chat;
          },
        ),
      ],
      child: ServicesProvider(
        child: MaterialApp(
        title: 'iStatis',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const AuthGate(),
        ),
      ),
    );
  }
}
