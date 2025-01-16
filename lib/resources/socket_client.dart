import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;

  static SocketClient? _instance;

  SocketClient._intenal() {
    socket = IO.io('http://192.168.1.45:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.on('connect', (_) => log('Socket connected: ${socket!.id}'));
    socket!.on('disconnect', (_) => log('Socket disconnected'));
    socket!.on('connect_error', (data) => log('Connect error: $data'));
    socket!.on('connect_timeout', (data) => log('Connection timeout: $data'));
    socket!.on('error', (data) => log('Error: $data'));

    socket!.connect();
    log("Socket connected: ${socket!.connected}");
  }
  // SocketClient._intenal() {
  //   socket = IO.io('http://192.168.29.36:3000', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //   });

  //   socket!.on('connect', (_) => log('Socket connected: ${socket!.id}'));
  //   socket!.on('disconnect', (_) => log('Socket disconnected'));
  //   socket!.on('connect_error', (data) => log('Connect error: $data'));
  //   socket!.on('connect_timeout', (data) => log('Connection timeout: $data'));
  //   socket!.on('error', (data) => log('Error: $data'));

  //   socket!.connect();
  //   log("Socket connected: ${socket!.connected}");
  // }

  static SocketClient? get instance {
    _instance ??= SocketClient._intenal();

    return _instance;
  }
}
