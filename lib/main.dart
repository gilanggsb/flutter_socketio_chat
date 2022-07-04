import 'package:flutter/material.dart';

import 'modules/socketio/screens/socketio_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Masukkan Nama Anda',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (usernameController.text == "") {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Silahkan Masukan Nama Anda')));
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SocketIOScreen(
                userName: usernameController.text,
              ),
            ),
          );
        },
        tooltip: 'Chats',
        child: const Icon(
          Icons.message,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
