import 'package:flutter/material.dart';
import 'package:flutter_socketio/modules/socketio/models/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../components/chat_component.dart';
import '../services/socketio_service.dart';

class SocketIOScreen extends StatefulWidget {
  final String userName;
  const SocketIOScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<SocketIOScreen> createState() => _SocketIOScreenState();
}

int userID = 7890;

class _SocketIOScreenState extends State<SocketIOScreen> {
  final TextEditingController messageController = TextEditingController();
  List<MessageModel> listMessage = <MessageModel>[];
  late io.Socket socket;
  String userOnline = '';

  void getMessage(dynamic data) {
    if (!mounted) return;
    setState(() {
      listMessage.add(messageModelFromJson(data));
    });
  }

  void getUserOnline(dynamic data) {
    if (!mounted) return;
    userOnline = data.toString();
    setState(() {});
  }

  @override
  void initState() {
    socket =
        SocketService().initSocket(widget.userName, getMessage, getUserOnline);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          color: Colors.teal,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: TextField(
                    decoration: const InputDecoration(
                        fillColor: Colors.white, filled: true),
                    controller: messageController,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (messageController.text != "") {
                    MessageModel message = MessageModel(
                      id: userID,
                      name: widget.userName,
                      message: messageController.text,
                      timeStamp: DateTime.now().toString(),
                    );
                    socket.emit('send_message', messageModelToJson(message));
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.teal,
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SocketIO Room ($userOnline)',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () async {
                      SocketService.disconnectSocket(socket)
                          .then((_) => {Navigator.pop(context)});
                    },
                    child: const Text('Tutup',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: listMessage.length,
                  itemBuilder: (context, index) => ChatComponent(
                      messageModel: listMessage[index],
                      isSender: listMessage[index].id == userID)),
            ),
          ],
        ),
      ),
    );
  }
}
