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
  var send = new Map();
  send['user'] = nick;

  // Connect to the server
  final socket = await Socket.connect(host, port);
  print('\/\/ $nick connected to $host at $port\n');

  // Listen to commands
  socket.listen((v) {
    recv = json.decode(utf8.decode(v, allowMalformed: true).trim());
    if (recv['msg'].startsWith(pref) && recv['user'] != nick) {
      switch (recv['msg'].split(' ')[0].substring(pref.length)) {
        // what the fuck
        case "ping":
          {
            print('ping recieved');
            send['msg'] = "pong";
            socket.add(utf8.encode(json.encode(send)));
          }
          break;

        case "chungus":
          {
            print('chungus recieved');
            send['msg'] = "the big one";
            socket.add(utf8.encode(json.encode(send)));
          }
          break;

        case "chungussize":
          {
            print('chungussize recieved');
            if (recv['msg'].split(' ').length < 2) {
              send['msg'] = 'usage: ${pref}chungussize <size>';
              socket.add(utf8.encode(json.encode(send)));
            } else {
              send['msg'] =
                  'the size of the chungus is ${recv["msg"].split(" ")[1]}';
              socket.add(utf8.encode(json.encode(send)));
            }
          }
          break;

        default:
          {
            print('unknown command recieved');
          }
          break;
      }
    }
  });
}
