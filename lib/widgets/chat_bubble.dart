import 'package:flutter/material.dart';

import '../models/message.dart';
import '../theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  bool get isUser => message.role == MessageRole.user;

  @override
  Widget build(BuildContext context) {
    final userBg = AppColorsResolver.feature(context);
    final userFg = AppColorsResolver.featureInk(context);
    final botBg = AppColorsResolver.surface1(context);
    final botFg = AppColorsResolver.text1(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSpacing.s1,
          horizontal: AppSpacing.s3,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s3,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? userBg : botBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadius.xl),
            topRight: const Radius.circular(AppRadius.xl),
            bottomLeft: Radius.circular(isUser ? AppRadius.xl : AppRadius.xs),
            bottomRight: Radius.circular(isUser ? AppRadius.xs : AppRadius.xl),
          ),
          border: isUser
              ? null
              : Border.all(color: AppColorsResolver.border(context)),
        ),
        child: Text(
          message.content,
          style: AppText.bodyFor(
            context,
          ).copyWith(fontSize: 14, height: 1.5, color: isUser ? userFg : botFg),
        ),
      ),
    );
  }
}
