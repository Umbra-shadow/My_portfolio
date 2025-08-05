import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../umbra_utils/design/color.dart';

class ChatMessage {
  final String text;
  final bool isUserMessage;
  const ChatMessage({required this.text, required this.isUserMessage});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isAiTyping = false;

  @override
  void initState() {
    super.initState();
    // Start with a welcoming message from the AI
    _messages.add(
      const ChatMessage(
        text:
            "Hello! I am a trained AI version of Dan. How can I help you today?",
        isUserMessage: false,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;

    // Add user's message to the list
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUserMessage: true));
      _isAiTyping = true;
    });
    _textController.clear();

    // --- Backend Simulation ---
    // Simulate a delay, then add the AI's response.
    // In a real app, you would make your API call here.
    Future.delayed(const Duration(milliseconds: 1500), () {
      const aiResponse = ChatMessage(
        text:
            "That's a great question! While I process that, feel free to ask me about Dan's skills in Flutter, Python, or Cloud technologies.",
        isUserMessage: false,
      );
      setState(() {
        _isAiTyping = false;
        _messages.insert(0, aiResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "AI Assistant",
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // --- CHAT MESSAGE LIST ---
          Expanded(
            child: ListView.builder(
              reverse: true, // Makes the list grow from the bottom
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _ChatMessageBubble(message: _messages[index]);
              },
            ),
          ),

          // --- "AI IS TYPING" INDICATOR ---
          if (_isAiTyping) const _AiTypingIndicator(),

          // --- TEXT INPUT AREA ---
          _buildTextInputArea(),
        ],
      ),
    );
  }

  Widget _buildTextInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: "Ask about skills, projects...",
                  // filled: true,
                  // fillColor: AppColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.send_rounded),
              onPressed: _sendMessage,
              color: AppColors.portfolioPurple,
              iconSize: 28,
            ),
          ],
        ),
      ),
    );
  }
}

// --- REUSABLE SUB-WIDGETS ---

class _ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _ChatMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.isUserMessage;
    return Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isUser ? AppColors.portfolioPurple : AppColors.cardMuted,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                bottomRight: isUser ? Radius.zero : const Radius.circular(20),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isUser
                    ? AppColors.textPrimaryBlack
                    : AppColors.textPrimaryBlack,
                fontSize: 16,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.2, duration: 300.ms, curve: Curves.easeOut);
  }
}

class _AiTypingIndicator extends StatelessWidget {
  const _AiTypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            decoration: const BoxDecoration(
              color: AppColors.cardMuted,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(),
                _TypingDot(delay: 200.ms),
                _TypingDot(delay: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  final Duration delay;
  const _TypingDot({this.delay = Duration.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: const BoxDecoration(
            color: AppColors.textPrimaryWhite,
            shape: BoxShape.circle,
          ),
        )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
          delay: delay,
        )
        .moveY(begin: -2, end: 2, duration: 600.ms, curve: Curves.easeInOut);
  }
}
