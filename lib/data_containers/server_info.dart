class ServerInfo {

  final String serverName;
  final String motd;
  final int maxPlayers;

  int _currentPlayers;
  int get currentPlayers => _currentPlayers;
  set currentPlayers(int numberOfPlayers)
  {
    if (numberOfPlayers <= maxPlayers)
      _currentPlayers = numberOfPlayers;
  }

  ServerInfo(this.serverName, this.motd, this._currentPlayers, this.maxPlayers);
  // ServerInfo.fromString(String response);

}