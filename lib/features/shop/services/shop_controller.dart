// lib/features/shop/services/shop_controller.dart

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:setrise/features/shop/models/shop_models.dart';

class ShopController extends ChangeNotifier {
  final List<ProductModel> _products = [];
  final List<AuctionItem>  _auctions = [];
  final List<StoreModel>   _stores   = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int  _currentPage = 1;

  List<ProductModel> get products       => List.unmodifiable(_products);
  List<AuctionItem>  get auctions       => List.unmodifiable(_auctions);
  List<StoreModel>   get stores         => List.unmodifiable(_stores);
  bool               get isLoadingMore  => _isLoadingMore;
  bool               get hasMore        => _hasMore;

  Future<void> fetchInitialData() async {
    _products.clear();
    _auctions.clear();
    _stores.clear();
    _currentPage = 1;
    _hasMore = true;
    _stores.addAll(StoreModel.getMockStores());
    _auctions.addAll(AuctionItem.getMockAuctions());
    await _fetchNextPage();
    notifyListeners();
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    notifyListeners();
    try { await _fetchNextPage(); }
    finally { _isLoadingMore = false; notifyListeners(); }
  }

  Future<void> _fetchNextPage() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final newProducts = ProductModel.getFeaturedProducts()
        .map((p) => p.copyWith(
            id: 'page${_currentPage}_${p.id}'))
        .toList();
    if (newProducts.isEmpty) { _hasMore = false; return; }
    _products.addAll(newProducts);
    _currentPage++;
    if (_currentPage > 4) _hasMore = false;
  }

  Future<void> refresh() => fetchInitialData();
}

