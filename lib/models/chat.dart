import 'chat_message.dart';
import 'chat_user.dart';

class Chat {
  final String uid;
  final String currentUserId;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;

  late final List<ChatUser> _recipients;

  Chat({
    required this.uid,
    required this.currentUserId,
    required this.activity,
    required this.group,
    required this.members,
    required this.messages,
}) {
    _recipients = members.where((i) => i.uid != currentUserId).toList();
  }

  List<ChatUser> recipients(){
    return _recipients;
  }

  String title() {
    return !group ?
    _recipients.first.name :
    _recipients.map((_user) => _user.name).join(" ,");
  }

  String imageURL() {
    return !group ?
    _recipients.first.image :
    "https://www.google.com/imgres?q=group%20chat%20images&imgurl=https%3A%2F%2Fnpr.brightspotcdn.com%2F99%2Fef%2F2f5a77484d89a63e9913a33e6453%2Fgroup-chat-1400x1400.jpg&imgrefurl=https%3A%2F%2Fwww.wbfo.org%2Fpodcast%2Fgroup-chat&docid=hr159S3AZx-0lM&tbnid=v6pxGFC678JwyM&vet=12ahUKEwiK2eqv_dSKAxUKdqQEHQUMOu8QM3oECGAQAA..i&w=1400&h=1400&hcb=2&ved=2ahUKEwiK2eqv_dSKAxUKdqQEHQUMOu8QM3oECGAQAA";
  }
}