import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:string_similarity/string_similarity.dart';

import '../../../umbra_utils/design/color.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  List<List<dynamic>> _csvData = [];
  List<String> _suggestedQuestions = [];

  @override
  void initState() {
    super.initState();
    // Add an initial greeting message from the AI to guide the user.
    _messages.add(
      const ChatMessage(
        text:
            "Hello! I'm Dan's AI assistant. Start typing a question and select one of the suggestions that appear. It might not be much accurate but if your question is clear you will get an answer.",
        isUserMessage: false,
      ),
    );
    _loadCSV();
    _textController.addListener(_onTextChanged);
  }

  Future<void> _loadCSV() async {
    // Ensure you have your CSV file in the assets folder
    // and that it's declared in pubspec.yaml
    try {
      final rawData = await rootBundle.loadString('assets/qa_data.csv');
      _csvData = const CsvToListConverter().convert(rawData);
      setState(() {});
    } catch (e) {
      // Handle potential errors, e.g., file not found
      _messages.insert(
        0,
        const ChatMessage(
          text:
              "⚠️ Error: Could not load portfolio data. Please ensure the CSV file is correctly placed in the assets folder.",
          isUserMessage: false,
        ),
      );
    }
  }

  void _onTextChanged() {
    final query = _textController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _suggestedQuestions = [];
      });
      return;
    }

    final questions = _csvData.map((row) => row[0].toString()).toList();
    final bestMatches = StringSimilarity.findBestMatch(query, questions);

    // --- IMPROVEMENT: Stricter similarity threshold ---
    // Increased threshold from 0.1 to 0.35 to filter out irrelevant matches.
    // This ensures that only meaningfully similar questions are suggested.
    setState(() {
      _suggestedQuestions = bestMatches.ratings
          .where((rating) => rating.rating != null && rating.rating! > 0.35)
          .take(2)
          .map((rating) => rating.target!)
          .toList();
    });
  }

  void _onQuestionSelected(String question) {
    // Find the corresponding answer from the CSV data.
    final answerRow = _csvData.firstWhere(
      (row) => row[0].toString() == question,
      orElse: () => [
        "Question not found",
        "Sorry, I couldn't find an answer for that.",
      ],
    );
    final answer = answerRow[1].toString();

    setState(() {
      // Add the user's selected question and the AI's answer to the chat.
      _messages.insert(0, ChatMessage(text: question, isUserMessage: true));
      _messages.insert(0, ChatMessage(text: answer, isUserMessage: false));
      // Clear suggestions and the text field.
      _suggestedQuestions = [];
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Umbrio Chat",
          style: GoogleFonts.poppins(color: AppColors.textPrimaryWhite),
        ),
        backgroundColor: AppColors.backgroundBlack,
        foregroundColor: AppColors.portfolioPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0, color: Colors.black),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Only show the "Did you mean:" prompt if there are suggestions.
                if (_suggestedQuestions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      "Did you mean:",
                      style: GoogleFonts.poppins(
                        color: AppColors.textPrimaryBlack,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                // Build the list of tappable suggestions.
                ..._suggestedQuestions.map((question) {
                  return ListTile(
                    title: Text(
                      question,
                      // Text color is white for visibility.
                      style: GoogleFonts.poppins(
                        color: AppColors.textPrimaryBlack,
                      ),
                    ),
                    onTap: () => _onQuestionSelected(question),
                  );
                }).toList(),
                _buildTextComposer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.portfolioPurple, width: 2.0),
      ),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Expanded(
              child: Container(
                height: 60,
                child: TextField(
                  controller: _textController,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  style: GoogleFonts.poppins(
                    color: AppColors.textPrimaryBlack,
                    fontSize: 20,
                  ), // User input text is white.
                  decoration: InputDecoration.collapsed(
                    hintText: 'Ask a question...',
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.portfolioPurple,
                      fontSize: 20,
                    ), // Hint text is grey.
                  ),
                ),
              ),
            ),
            IconButton(
              // Icon is white to be visible.
              icon: const Icon(Icons.search, color: AppColors.textPrimaryBlack),
              onPressed: () => _onTextChanged(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

// The ChatMessage widget remains the same but will function well
// with the dark theme because its colors are self-contained.
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: isUserMessage
            ? AppColors.portfolioPurple.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(color: AppColors.portfolioPurple, width: 2.0),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: isUserMessage
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (!isUserMessage)
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.portfolioPurple.withOpacity(0.1),
                  child: const Text('🤖'),
                ),
              ),
            if (!isUserMessage) const SizedBox(width: 8.0),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isUserMessage ? Colors.transparent : Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: isUserMessage
                        ? AppColors.textPrimaryBlack
                        : AppColors.portfolioPurple,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            if (isUserMessage) const SizedBox(width: 8.0),
            if (isUserMessage)
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColors.portfolioPurple.withOpacity(0.1),
                  child: const Text('👤'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
