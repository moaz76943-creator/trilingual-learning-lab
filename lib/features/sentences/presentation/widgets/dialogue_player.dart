import 'package:flutter/material.dart';

class DialogueMessage {
  final String speakerName;
  final String textAr;
  final String textDe;
  final String textEn;
  final bool isUser;

  const DialogueMessage({
    required this.speakerName,
    required this.textAr,
    required this.textDe,
    required this.textEn,
    this.isUser = false,
  });
}

class DialoguePlayer extends StatelessWidget {
  final List<DialogueMessage> messages;
  final Function(int index)? onLineSelected;

  const DialoguePlayer({
    super.key,
    required this.messages,
    this.onLineSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          elevation: msg.isUser ? 3 : 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(msg.textAr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('🇩🇪 ${msg.textDe}', style: const TextStyle(fontSize: 14)),
                Text('🇬🇧 ${msg.textEn}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            trailing: Chip(label: Text(msg.speakerName)),
            onTap: () => onLineSelected?.call(index),
          ),
        );
      },
    );
  }
}
