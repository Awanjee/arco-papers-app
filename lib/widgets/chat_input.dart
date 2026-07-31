import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/arco_components.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSend;
  final bool isLoading;

  const ChatInput({super.key, required this.onSend, required this.isLoading});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isLoading) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s4),
      decoration: BoxDecoration(
        color: AppColorsResolver.surface1(context),
        border: Border(
          top: BorderSide(color: AppColorsResolver.borderSubtle(context)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _send(),
              style: AppText.bodyFor(context).copyWith(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Ask about products or pricing...',
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.s2),
          widget.isLoading
              ? SizedBox(
                  width: 44,
                  height: 44,
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColorsResolver.link(context),
                      ),
                    ),
                  ),
                )
              : ArcoIconButton(icon: Icons.send_outlined, onPressed: _send),
        ],
      ),
    );
  }
}
