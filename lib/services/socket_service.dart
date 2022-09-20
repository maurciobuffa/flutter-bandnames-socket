import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;
  get emit => _socket.emit;

  set serverStatus(ServerStatus serverStatus) {
    _serverStatus = serverStatus;
    notifyListeners();
  }

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket = IO.io('http://localhost:3000', {
      "transports": ["websocket"],
      "autoConnect": true,
    });
    _socket.onConnect((_) {
      serverStatus = ServerStatus.Online;
    });
    _socket.onDisconnect((_) {
      serverStatus = ServerStatus.Offline;
    });
  }
}
