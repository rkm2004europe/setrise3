import 'package:flutter/material.dart';
import '../../shar/screens/share_sheet.dart';
import '../theme/colors.dart';

class ShareMessageSheet {
  static void show(BuildContext context, {required String messageText}) {
    ShareSheet.show(
      context,
      data: ShareData(
        id: 'msg_share',
        title: 'رسالة',
        subtitle: messageText,
        accentColor: ChatColors.accent,
        link: 'https://setrise.app/message',
      ),
    );
  }
}
