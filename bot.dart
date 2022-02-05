import 'dart:convert';
import 'dart:io';
import 'dart:async';

Future<void> main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: bot <host:port>');
    return;
  }

  // Define some stuff
  var host = arguments[0].split(':')[0];
  int port = int.parse(arguments[0].split(':')[1]);
  final nick = 'pingbot';
  final pref = '!';
  var recv;

  // Connect to the server
  final socket = await Socket.connect(host, port);
  print('\/\/ $nick connected to $host at $port\n');
  // Listen to the ping command
  socket.listen((v) {
    recv = json.decode(utf8.decode(v, allowMalformed: true).trim());
    if (recv['msg'].split(' ')[0] == pref + 'ping') {
      socket.add(utf8.encode(json.encode({"user": nick, "msg": "pong"})));
      print('Responded to ${recv["user"]} executing ping');
    }
  });
}
