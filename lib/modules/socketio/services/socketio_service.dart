import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  SocketService._privateConstructor();
  static final SocketService _instance = SocketService._privateConstructor();
  factory SocketService() => _instance;
  late io.Socket socket;
  String totalUser = "";

  io.Socket initSocket(
      String name, Function getMessage, Function getUserOnline) {
    try {
      socket = io.io('https://nodejs-chat-socketio.herokuapp.com/', {
        'transports': ['websocket'],
        'autoConnect': true,
      });
      // socket = io.io('http://10.60.0.84:8080', {
      //   'transports': ['websocket'],
      //   'autoConnect': true,
      // });
      // socket = io.io('https://nodejs-chat-socketio.herokuapp.com/', {
      //   'transports': ['websocket'],
      //   'autoConnect': true,
      // });
      socket.connect();
      socket.emit('join_chat', name);
      socket.on('countUserOnline', ((data) => {getUserOnline(data)}));
      socket.on('receive_message', (data) => {getMessage(data)});
    } catch (e) {
      print('NPLOG SocketIO ${e.toString()}');
    }
    return socket;
  }

  static Future<void> disconnectSocket(io.Socket socket) async {
    socket.emit('leave_chat', 'leave');
    Future.delayed(const Duration(milliseconds: 1000), () {
      print('dispose socket');
      socket.dispose();
    });
  }
}
