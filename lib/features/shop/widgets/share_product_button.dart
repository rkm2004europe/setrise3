import 'package:flutter/material.dart';
import '../../shar/screens/share_sheet.dart';
import '../theme/app_colors.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;
  final String productName;
  final String description;

  const ShareProductButton({
    super.key,
    required this.productId,
    required this.productName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ShareSheet.show(
        context,
        data: ShareData(
          id: productId,
          title: productName,
          subtitle: description,
          accentColor: ShopColors.accent,
          link: 'https://setrise.app/shop/$productId',
        ),
      ),
      child: const Icon(Icons.share, color: ShopColors.accent),
    );
  }
}
