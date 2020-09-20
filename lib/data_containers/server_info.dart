import 'dart:io';

class ServerInfo {

  String serverName;
  String motd;
  int maxPlayers = 0;

  int _currentPlayers = 0;

  final String ip;
  final int port;

  int get currentPlayers => _currentPlayers;
  set currentPlayers(int numberOfPlayers)
  {
    if (numberOfPlayers <= maxPlayers)
      _currentPlayers = numberOfPlayers;
  }

  ServerInfo.open(this.ip, this.port);
  ServerInfo(this.ip, this.port, this.serverName, this.motd, this._currentPlayers, this.maxPlayers);
  // ServerInfo.fromString(String response);

  Future<void> updateServerInfo() async {
    Socket.connect(ip, port).then((socket) async {
      print('Connected to: '
        '${socket.remoteAddress.address}:${socket.remotePort}');

      Set<String> handledRequests = Set<String>();

      //Establish the onData, and onDone callbacks
      socket.listen((data) {
        String reply = new String.fromCharCodes(data).trim();

        List<String> parts = reply.split(' ');

        if (parts.length > 1)
        {

          String request = parts[0];
          print(parts);
          parts.removeAt(0);

          switch( request )
          {
            case 'get_name':
              serverName = parts.join(' ') ?? 'No name found';
              break;

            case 'get_motd':
              motd = parts.join(' ') ?? 'No motd found';
              break;

            case 'get_num_players':
              _currentPlayers = int.tryParse( parts[0] ) ?? 0;
              break;

            case 'get_max_players':
              maxPlayers = int.tryParse( parts[0] ) ?? 1;
              break;

          }
        }
        else
        {
          print('Too few arguments received in a response!');
        }
      },
      onDone: () {
        socket.destroy();
      });

      
      // Make sure this connection can handle multiple requests
      socket.writeln('ID keep_alive');
      await Future.delayed(const Duration(milliseconds: 10));

      socket.writeln('ID get_name');
      await Future.delayed(const Duration(milliseconds: 10));
      socket.writeln('ID get_motd');
      await Future.delayed(const Duration(milliseconds: 10));
      socket.writeln('ID get_num_players');
      await Future.delayed(const Duration(milliseconds: 10));
      socket.writeln('ID get_max_players');

      await Future.delayed(const Duration(milliseconds: 500));
      socket.writeln('ID close');
    });

  }

}