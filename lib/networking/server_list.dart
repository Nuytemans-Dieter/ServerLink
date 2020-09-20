import 'package:server_link_client/data_containers/server_info.dart';

class ServerList {

  List<ServerInfo> _servers = List<ServerInfo>();

  /// Remove the server at the given index
  void removeServer(int index)
  {
    _servers.removeAt(index);
  }

  /// Get the modified list after adding a requested server
  Future<List<ServerInfo>> addServer(String ip, int port) async
  {
    _servers.add(
      ServerInfo.open(
        ip, 
        port,
      ),
    );

    await _servers.last.updateServerInfo();
    return _servers;
  }

  /// Get the current server list after updating each entry
  Future<List<ServerInfo>> getServers() async {

    // for (ServerInfo server in _servers)
      // await server.updateServerInfo();

    return _servers;
  }

}