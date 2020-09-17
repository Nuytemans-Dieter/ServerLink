import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/server_info.dart';

class ServerList {

  List<ServerInfo> _servers = List<ServerInfo>();
  List<State> listeners = List<State>();

  /// Add a listener page that will refresh upon receiving a new value
  void addListener(State state)
  {
    listeners.add(state);
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
    for (State state in listeners)
      state.setState(() {});
  }

  /// Get the current server list after updating each entry
  Future<List<ServerInfo>> getServers() async {
    // TODO update all server info
    await new Future.delayed(const Duration(seconds: 1));
    return _servers;
  }

}