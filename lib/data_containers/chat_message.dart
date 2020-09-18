class ChatMessage {

  final String sender;
  final String message;
  final bool sentBySelf;

  ChatMessage(this.sender, this.message, {this.sentBySelf: false});

}