import 'package:flutter/material.dart';
import '../services/wallet_transfer_service.dart';
class WalletTransferController extends ChangeNotifier { final WalletTransferService _srv = WalletTransferService(); Future<bool> transfer(String to, int amt) async => await _srv.transfer(to, amt); }
