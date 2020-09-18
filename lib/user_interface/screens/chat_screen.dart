import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:server_link_client/data_containers/chat_message.dart';
import 'package:server_link_client/data_containers/server_info.dart';

class ChatScreen extends StatefulWidget{
  
  final ServerInfo serverInfo;
  final List<ChatMessage> messages = List<ChatMessage>();

  ChatScreen(this.serverInfo);

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen>{

  // TODO add listener for chat messages
  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.messages.length == 0)
    {
      widget.messages.addAll([
        ChatMessage('Jefke', 'Dit is echt een coole server'),
        ChatMessage('Jon Bovi', 'Ja maar mijn naam klopt niet'),
        ChatMessage('Tronald Dump', 'Hahahaa jij loser met je foute naam'),
        ChatMessage('You', 'Ik haat deze plek', sentBySelf: true),
      ]);
    }

    return Scaffold(

      // Top AppBar for chat page

      appBar: AppBar(
        title: Text(
          widget.serverInfo.serverName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ), 
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.link,
              color: Colors.white,
            ), 
            onPressed: () {
              // TODO code generation and account linking
              // Request code from server
              // Receive code from server
              // Display code to user

              // Serverside
              // wait for link command
              // Link MC account to app
            }
          ),
        ],
      ),

      // Messages display

      body: ListView(
        reverse: true,
        children: [
          for (ChatMessage message in widget.messages)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3.0),
              child: Column(
                crossAxisAlignment: message.sentBySelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      message.sender
                    ),
                  ),
                  Bubble(
                    color: message.sentBySelf ? Colors.white : Colors.cyan,
                    child: Text(
                      message.message, 
                      style: TextStyle(
                        color: message.sentBySelf ? Colors.black : Colors.white,
                      ),
                    ),
                    alignment: message.sentBySelf ? Alignment.topRight : Alignment.topLeft,
                    nip: message.sentBySelf ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                    nipRadius: 0.5,
                  ),
                ],
              ),
            ),
          
          SizedBox(
            height: 100.0,
          ),
        ].reversed.toList(),
      ),

      // Send messages here
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 70.0,
            child: TextFormField(
              autocorrect: true,
              autofocus: false,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Type your message here',
                labelStyle: TextStyle(
                  color: Colors.black
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                // border: InputBorder()
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.cyan,
              ),
              child: IconButton(
                
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ), 
                onPressed: ()
                {
                  // TODO send message
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}