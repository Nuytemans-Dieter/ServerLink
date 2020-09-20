class ChatMessage {

  final String sender;
  final String message;
  final bool isMobile;
  final bool sentBySelf;

  ChatMessage(this.sender, this.message, {this.isMobile: false, this.sentBySelf: false});

}