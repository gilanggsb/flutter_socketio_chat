import 'package:flutter/material.dart';

import '../models/message_model.dart';

class ChatComponent extends StatelessWidget {
  const ChatComponent({
    Key? key,
    required this.messageModel,
    required this.isSender,
  }) : super(key: key);

  final MessageModel messageModel;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isSender
                  ? Text(messageModel.timeStamp,
                      style: const TextStyle(color: Colors.grey, fontSize: 14))
                  : Text(messageModel.name.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
              isSender
                  ? Text(messageModel.name.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                  : Text(messageModel.timeStamp,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.teal[400],
                borderRadius: BorderRadius.only(
                  topLeft: isSender
                      ? const Radius.circular(8)
                      : const Radius.circular(0),
                  bottomLeft: isSender
                      ? const Radius.circular(8)
                      : const Radius.circular(8),
                  topRight: isSender
                      ? const Radius.circular(0)
                      : const Radius.circular(8),
                  bottomRight: isSender
                      ? const Radius.circular(8)
                      : const Radius.circular(8),
                )),
            padding: const EdgeInsets.all(12),
            child: Text(messageModel.message,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
    );
  }
}
