import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/server_info.dart';

class ServerTile extends StatelessWidget{
  
  final ServerInfo _serverInfo;

  ServerTile(this._serverInfo);
  
  @override
  Widget build(BuildContext context) {
    
    double imageSize = MediaQuery.of(context).size.width / 6;

    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        onLongPress: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Server image
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Container(
                  height: imageSize,
                  width: imageSize,
                  child: Image.network(
                    'https://www.nomadfoods.com/wp-content/uploads/2018/08/placeholder-1-e1533569576673.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Server info: name and MOTD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _serverInfo.serverName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _serverInfo.motd
                  ),
                ],
              ),
              Spacer(),
              
              // Number of players count 'online players/max players' and according icon
              Text(
                _serverInfo.currentPlayers.toString() + ' / ' + _serverInfo.maxPlayers.toString(),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(width: 5.0,),
              Icon(
                Icons.people,
                size: 16.0,
              ),
            ],
          ),
        )
      ),
    );
  }
  
}