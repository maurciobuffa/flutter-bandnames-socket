import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(socketService.serverStatus.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.message),
        onPressed: () {
          socketService.emit("new-message",
              {"name": "Flutter", "message": "Hola desde Flutter"});
        },
      ),
    );
  }
}
