import 'package:flutter/material.dart';

import '../models/message.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';

class ChatProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();
  final List<Message> _messages = [];
  bool _isLoading = false;

  List<Message> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;

  void updateApiService(AuthProvider auth) {
    _apiService = ApiService(accessTokenProvider: () => auth.accessToken);
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    _messages.add(Message(content: content, role: MessageRole.user));
    _isLoading = true;
    notifyListeners();

    final response = await _apiService.sendMessage(content);

    _messages.add(Message(content: response, role: MessageRole.assistant));
    _isLoading = false;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
