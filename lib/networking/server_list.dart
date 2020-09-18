import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/server_info.dart';

class ServerList {

  List<ServerInfo> _servers = List<ServerInfo>();

  ServerList()
  {
    _servers = [
      ServerInfo('Name', 'motd', 10, 50),
      ServerInfo('This is my server!', 'Server message of the day', 3, 12),
      ServerInfo('Name', 'motd', 10, 50),
      ServerInfo('Name', 'motd', 10, 50),
    ];
  }

  /// Remove the server at the given index
  void removeServer(int index)
  {
    _servers.removeAt(index);
  }

  /// Get the modified list after adding a requested server
  Future<List<ServerInfo>> addServer(String ip, String port) async
  {
    await new Future.delayed(const Duration(seconds: 1));
    _servers.add(
      ServerInfo(
        'Server $ip', 
        'The port of this server is $port', 
        25, 
        53
      ),
    );

    return _servers;
  }

  /// Get the current server list after updating each entry
  Future<List<ServerInfo>> getServers() async {
    // TODO update all server info
    await new Future.delayed(const Duration(seconds: 1));
    return _servers;
  }

}