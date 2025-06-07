import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:impots_benin/app/components/text_components.dart';

class Messageriechatbot extends StatefulWidget {
  const Messageriechatbot({super.key});

  @override
  State<Messageriechatbot> createState() => _MessageriechatbotState();
}

class _MessageriechatbotState extends State<Messageriechatbot> {
  List<Map<String, dynamic>> messages = [
    {"text": "Bonjour ! Comment puis-je vous aider ?", "isUser": false},
  ];
  TextEditingController messageController = TextEditingController();
  bool isLoading = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    String text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({"text": text, "isUser": true});
      isLoading = true;
    });

    messageController.clear();

    try {
      final response = await http.post(
        Uri.parse('https://n8n-erw6.onrender.com/webhook/chatbot'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"question": text}),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        String botResponse;

        if (decoded is List &&
            decoded.isNotEmpty &&
            decoded[0] is Map &&
            decoded[0].containsKey('output')) {
          botResponse = decoded[0]['output'];
        } else if (decoded is Map && decoded.containsKey('answer')) {
          botResponse = decoded['answer'];
        } else if (decoded is String) {
          botResponse = decoded;
        } else {
          botResponse = "Réponse inattendue du serveur.";
        }

        setState(() {
          messages.add({"text": botResponse, "isUser": false});
          isLoading = false;
        });
      } else {
        setState(() {
          messages.add({"text": "Erreur serveur, veuillez réessayer.", "isUser": false});
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        messages.add({"text": "Erreur réseau, vérifiez votre connexion.", "isUser": false});
        isLoading = false;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.smart_toy, color: Colors.white),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            TextComponents(
              txt: "impots.benin ",
              txtSize: 19,
              color: Colors.black,
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isUser = message['isUser'] as bool;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 0),
                        bottomRight: Radius.circular(isUser ? 0 : 16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      message['text'] as String,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: messageController,
                      enabled: !isLoading,
                      decoration: const InputDecoration(
                        hintText: "Écrivez un message...",
                        border: InputBorder.none,
                        icon: Icon(Icons.message, color: Colors.grey),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: isLoading ? null : _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
