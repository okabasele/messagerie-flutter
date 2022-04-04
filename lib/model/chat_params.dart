

import 'package:messagerie_flutter/model/Utilisateur.dart';

class ChatParams{
  final Utilisateur user;
  final Utilisateur peer;

  ChatParams(this.user, this.peer);

  String getChatGroupId() {
    if (user.id.hashCode <= peer.id.hashCode) {
      return '${user.id}-${peer.id}';
    } else {
      return '${peer.id}-${user.id}';
    }
  }

}