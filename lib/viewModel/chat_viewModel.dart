import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/models/conversation_model.dart';
import 'package:fyp_renterra_frontend/data/models/messages_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:http/http.dart' as http;

class ChatViewModel extends ChangeNotifier {
  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isIconLoading = false;

  void _setIconLoading(bool value) {
    isIconLoading = value;
    notifyListeners();
  }

  List<ConversationModel> conversationMessageList = [];

  List<Messages> messagesList = [];

  String? userId;
  late MessageModel messageModel;

  late ConversationModel conversationModel;

  Future<void> getAllConversations() async {
    _setLoading(true);
    try {
      final token = await SessionManager.getAccessToken();

      final response = await http.get(
        Uri.parse('${ApiClient.baseUrl}/chat/conversations'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        conversationMessageList =
            data.map((json) => ConversationModel.fromJson(json)).toList();

        print(data.toString());
        notifyListeners();
        _setLoading(false);
      } else {
        throw Exception(
            'Failed to fetch conversations: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in getAllConversations: $e');
      rethrow;
    }
  }

  Future<void> getAllMessages(String conversationId) async {
    _setLoading(true);
    try {
      final token = await SessionManager.getAccessToken();

      final response = await http.get(
        Uri.parse('${ApiClient.baseUrl}/chat/messages/$conversationId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _setLoading(false);
        final data = jsonDecode(response.body);

        messageModel = MessageModel.fromJson(data);

        userId = messageModel.userId;

        messagesList = messageModel.messages!;

        print(messagesList);

        print(data.toString());
        notifyListeners();
      } else {
        throw Exception(
            'Failed to fetch conversations: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in getAllConversations: $e');
      rethrow;
    }
  }

  Future<void> sendMessage(String conversationId, String messageText) async {
    _setIconLoading(true);
    try {
      final token = await SessionManager.getAccessToken();

      final response = await http.post(
        Uri.parse('${ApiClient.baseUrl}/chat/message'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'conversationId': conversationId,
          'message': messageText,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        // Convert response into Messages model
        final newMessage = Messages.fromJson(json);

        // Add to existing messagesList
        messagesList.add(newMessage);

        // Notify listeners so UI rebuilds
        notifyListeners();

        _setIconLoading(false);
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error sending message: $e');
      rethrow;
    }
  }

  Future<void> chartStart(String otherUserId) async {
    
    try {
      final token = await SessionManager.getAccessToken();

      final response = await http.post(
        Uri.parse('${ApiClient.baseUrl}/chat/conversation'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },

        //take from rentalmodel user id 
        body: jsonEncode({
          'otherUserId': otherUserId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body);

        // Convert response into Messages model
        conversationModel = ConversationModel.fromJson(json);

        print(conversationModel.id);
      
        // Notify listeners so UI rebuilds

      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error sending message: $e');
      rethrow;
    }
  }

  String convertToPakistanLocalTimeOnly(String utcTimestamp) {
    // Parse the UTC timestamp
    DateTime utcTime = DateTime.parse(utcTimestamp);

    DateTime pakistanTime = utcTime.add(Duration(hours: 5));

    return "${pakistanTime.hour.toString().padLeft(2, '0')}:"
        "${pakistanTime.minute.toString().padLeft(2, '0')}";
  }
}
