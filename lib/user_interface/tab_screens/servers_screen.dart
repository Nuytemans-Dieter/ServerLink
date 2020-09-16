import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/server_info.dart';
import 'package:server_link_client/user_interface/widgets/server_tile.dart';

class ServersScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ServersScreenState();
  }
}

class _ServersScreenState extends State<ServersScreen>{
  
  Future<List<ServerInfo>> getCurrentServers() async
  {
    await new Future.delayed(const Duration(seconds: 1));
    return [
      ServerInfo('Name', 'motd', 10, 50),
      ServerInfo('This is my server!', 'Server message of the day', 3, 12),
      ServerInfo('Name', 'motd', 10, 50),
      ServerInfo('Name', 'motd', 10, 50),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ServerInfo>>(
      future: getCurrentServers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == null || snapshot.data == null)
          return Container();

        if (snapshot.data.length == 0)
          return Text('No servers found!');

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ServerInfo server = snapshot.data[index];
            return Column(
              children: [
                ServerTile( server ),
                if (index != snapshot.data.length-1)
                  Padding(
                    // padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/4, right: 5.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}