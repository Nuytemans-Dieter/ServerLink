import 'dart:io';

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

  Socket socket;
  TextEditingController _chatFieldController;
  Set<String> sentMessages;

  @override
  void initState()
  {
    super.initState();

    sentMessages = Set<String>();
    _chatFieldController = new TextEditingController();
    initChatListener();
  }

  void initChatListener() async
  {
    socket = await Socket.connect(widget.serverInfo.ip, widget.serverInfo.port);

    socket.listen((event) {
      String input = String.fromCharCodes( event );
      List<String> parts = input.split(' ');

      // Event look:
      // sub_chat <sender name> <ingame/mobile> <sender UUID> <message>

      if (parts.length > 3 && parts[0] == 'sub_chat')
      {

        String sender = parts[1].replaceAll('+', ' ');
        bool isMobile = parts[2] == 'mobile';
        bool isSentBySelf = parts[3] == 'ID';

        // Strip everything except the message itself
        parts.removeRange(0, 4);

        String message = parts.join(' ').replaceAll('\n', '');

        setState(() {
          widget.messages.add(
            ChatMessage(
              isSentBySelf ? 'you' : sender,
              message,
              isMobile: isMobile,
              sentBySelf: isSentBySelf,
            ),
          );
        });
      }
      }).onDone(() {
        socket.destroy();
      });

      socket.writeln('ID keep_alive');
      await Future.delayed(Duration(milliseconds: 10));
      socket.writeln('ID sub_chat join');
    }

  @override
  void dispose()
  {
    socket.destroy();
    super.dispose();
  }

  void handleSendMessage()
  {
    String text = _chatFieldController.text;
    socket.writeln('ID send_chat my_name $text');

    sentMessages.add(text);
    _chatFieldController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {

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
              onEditingComplete: () => handleSendMessage(),
              autocorrect: true,
              autofocus: false,
              maxLines: 1,
              controller: _chatFieldController,
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
                onPressed: () => handleSendMessage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}