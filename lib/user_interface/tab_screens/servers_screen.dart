import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/server_info.dart';
import 'package:server_link_client/networking/server_list.dart';
import 'package:server_link_client/user_interface/widgets/animated/load_server_tile.dart';
import 'package:server_link_client/user_interface/widgets/server_tile.dart';

class ServersScreen extends StatefulWidget{

  final ServerList serverList;

  ServersScreen(this.serverList);

  @override
  State<StatefulWidget> createState() {
    return _ServersScreenState();
  }
}

class _ServersScreenState extends State<ServersScreen>{
  
  Future<List<ServerInfo>> getCurrentServers() async
  {
    await new Future.delayed(const Duration(milliseconds: 250));
    return [
      ServerInfo('Name', 'motd', 10, 50),
      ServerInfo('This is my server!', 'Server message of the day', 3, 12),
      ServerInfo('Name', 'motd', 10, 50),
      ServerInfo('Name', 'motd', 10, 50),
    ];
  }

  @override
  void initState() {
    super.initState();

    widget.serverList.addListener( this );
  }
  
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<List<ServerInfo>>(
      future: widget.serverList.getServers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none || snapshot.hasData == null || snapshot.data == null)
          return LoadServerTile();

        if (snapshot.data.length == 0)
          return Text('No servers found!');

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            ServerInfo server = snapshot.data[index];
            return Column(
              children: [
                Dismissible(
                  key: ValueKey(index),
                  onDismissed: (direction) => widget.serverList.removeServer(index),
                  child: Column(
                    children: [
                      ServerTile( server ),
                      if (index != snapshot.data.length-1)
                        Padding(
                          // padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                          padding: EdgeInsets.only(left: width/6 + width/15, right: 5.0),
                          child: Container(
                            height: 0.2,
                            width: double.infinity,
                            color: Colors.black,
                          ),
                        ),
                    ],
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