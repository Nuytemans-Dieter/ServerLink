import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/server_info.dart';
import 'package:server_link_client/networking/server_list.dart';
import 'package:server_link_client/user_interface/popup/action_popup.dart';
import 'package:server_link_client/user_interface/popup/add_server_popup.dart';
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

  }
  
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => showDialog(
          context: context, 
          child: AddServerPopup(
            onSubmit: (ip, port) async {
              await widget.serverList.addServer(ip, port);
              setState(() {});
            },
          ),
        ),
      ),
      body: FutureBuilder<List<ServerInfo>>(
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
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    key: ValueKey(index),
                    confirmDismiss: (direction) {
                      return showDialog(context: context, child:
                        ActionPopup(
                          title: 'Delete server',
                          icon: Icons.warning,
                          text: 'This server will be deleted from your server list. Are you sure you want to proceed?',
                          acceptMessage: 'Delete!',
                          denyMessage: 'Cancel',
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      widget.serverList.removeServer(index);
                    },
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
      ),
    );
  }
}