// lib/features/shop/models/shop_models.dart

import 'package:flutter/material.dart';

// ════════════════════════════════════════
// COLORS — بديل AppColors
// ════════════════════════════════════════
class ShopColors {
  static const bg      = Color(0xFF000000);
  static const surface = Color(0xFF111111);
  static const card    = Color(0xFF1C1C1E);
  static const accent  = Color(0xFFFF9500);
  static const red     = Color(0xFFFF3B30);
  static const green   = Color(0xFF34C759);
  static const blue    = Color(0xFF007AFF);
  static const grey    = Color(0xFF8E8E93);
  static const grey2   = Color(0xFF636366);
}

// ════════════════════════════════════════
// PRODUCT MODEL
// ════════════════════════════════════════
class ProductModel {
  final String id, name, brand, description;
  final double price;
  final double? oldPrice;
  final List<String> images;
  final double rating;
  final int reviewsCount;
  bool isFavorite;
  final int? discountPercentage;
  final String? videoUrl;
  final String? category;

  ProductModel({
    required this.id, required this.name, required this.brand,
    required this.description, required this.price, this.oldPrice,
    required this.images, required this.rating, required this.reviewsCount,
    this.isFavorite = false, this.discountPercentage,
    this.videoUrl, this.category,
  });

  ProductModel copyWith({bool? isFavorite}) => ProductModel(
    id: id, name: name, brand: brand, description: description,
    price: price, oldPrice: oldPrice, images: images, rating: rating,
    reviewsCount: reviewsCount,
    isFavorite: isFavorite ?? this.isFavorite,
    discountPercentage: discountPercentage, videoUrl: videoUrl, category: category,
  );

  static List<ProductModel> getFeaturedProducts() => [
    ProductModel(id: 'p1', name: 'AirPods Pro 3', brand: 'Apple',
      description: 'Active Noise Cancellation. Transparency mode. Adaptive Audio.',
      price: 249.99, oldPrice: 299.99,
      images: ['https://picsum.photos/400/400?random=1'],
      rating: 4.9, reviewsCount: 2841, discountPercentage: 17, category: 'Electronics'),
    ProductModel(id: 'p2', name: 'Nike Air Max 270', brand: 'Nike',
      description: 'The Nike Air Max 270 delivers incredible comfort.',
      price: 149.99, oldPrice: 180.00,
      images: ['https://picsum.photos/400/400?random=2'],
      rating: 4.7, reviewsCount: 1203, discountPercentage: 17, category: 'Fashion'),
    ProductModel(id: 'p3', name: 'Sony WH-1000XM5', brand: 'Sony',
      description: 'Industry-leading noise canceling headphones.',
      price: 349.00, images: ['https://picsum.photos/400/400?random=3'],
      rating: 4.8, reviewsCount: 4521, category: 'Electronics'),
    ProductModel(id: 'p4', name: 'MacBook Air M3', brand: 'Apple',
      description: '13.6-inch Liquid Retina display. M3 chip.',
      price: 1099.00, oldPrice: 1299.00,
      images: ['https://picsum.photos/400/400?random=4'],
      rating: 4.9, reviewsCount: 891, discountPercentage: 15, category: 'Electronics'),
    ProductModel(id: 'p5', name: 'Levi\'s 501 Jeans', brand: 'Levi\'s',
      description: 'The original straight-leg jeans.',
      price: 89.99, images: ['https://picsum.photos/400/400?random=5'],
      rating: 4.5, reviewsCount: 3201, category: 'Fashion'),
    ProductModel(id: 'p6', name: 'Nespresso Vertuo', brand: 'Nespresso',
      description: 'Barista-style coffee at home.',
      price: 199.00, oldPrice: 249.00,
      images: ['https://picsum.photos/400/400?random=6'],
      rating: 4.6, reviewsCount: 752, discountPercentage: 20, category: 'Home'),
    ProductModel(id: 'p7', name: 'Adidas Ultraboost 23', brand: 'Adidas',
      description: 'Responsive Boost cushioning.',
      price: 189.99, images: ['https://picsum.photos/400/400?random=7'],
      rating: 4.7, reviewsCount: 1842, category: 'Sports'),
    ProductModel(id: 'p8', name: 'Samsung QLED 4K', brand: 'Samsung',
      description: '65-inch QLED 4K Smart TV.',
      price: 1299.00, oldPrice: 1799.00,
      images: ['https://picsum.photos/400/400?random=8'],
      rating: 4.8, reviewsCount: 621, discountPercentage: 28, category: 'Electronics'),
  ];

  static List<ProductModel> getFlashDeals() => List.generate(8, (i) => ProductModel(
    id: 'fd$i', name: 'Flash Deal ${i + 1}', brand: 'Brand ${i + 1}',
    description: 'Limited time offer',
    price: 19.99 + i * 10, oldPrice: 49.99 + i * 10,
    images: ['https://picsum.photos/400/400?random=${50 + i}'],
    rating: 4.5, reviewsCount: 100 + i * 50,
    discountPercentage: 50 + i, category: 'All',
  ));
}

// ════════════════════════════════════════
// STORE MODEL
// ════════════════════════════════════════
class StoreModel {
  final String id, name, category, logoUrl, coverUrl, description;
  final double rating;
  final int products;
  final int followers;
  bool isFollowing;

  StoreModel({
    required this.id, required this.name, required this.category,
    required this.logoUrl, required this.coverUrl, required this.description,
    required this.rating, required this.products, required this.followers,
    this.isFollowing = false,
  });

  static List<StoreModel> getMockStores() => [
    StoreModel(id: 's1', name: 'TechZone', category: 'Electronics',
      logoUrl: 'https://picsum.photos/100/100?random=101',
      coverUrl: 'https://picsum.photos/400/200?random=201',
      description: 'Best electronics at best prices',
      rating: 4.8, products: 342, followers: 18400, isFollowing: true),
    StoreModel(id: 's2', name: 'FashionHub', category: 'Fashion',
      logoUrl: 'https://picsum.photos/100/100?random=102',
      coverUrl: 'https://picsum.photos/400/200?random=202',
      description: 'Trendy fashion for everyone',
      rating: 4.6, products: 1204, followers: 42100),
    StoreModel(id: 's3', name: 'HomeDecor+', category: 'Home',
      logoUrl: 'https://picsum.photos/100/100?random=103',
      coverUrl: 'https://picsum.photos/400/200?random=203',
      description: 'Transform your living space',
      rating: 4.7, products: 580, followers: 9800),
    StoreModel(id: 's4', name: 'SportsWorld', category: 'Sports',
      logoUrl: 'https://picsum.photos/100/100?random=104',
      coverUrl: 'https://picsum.photos/400/200?random=204',
      description: 'Everything sports',
      rating: 4.5, products: 789, followers: 23400),
  ];
}

// ════════════════════════════════════════
// AUCTION MODEL
// ════════════════════════════════════════
class AuctionItem {
  final String id, name, description, imageUrl;
  final double startingBid;
  double currentBid;
  int bidCount;
  final DateTime endTime;
  final String category;

  AuctionItem({
    required this.id, required this.name, required this.description,
    required this.imageUrl, required this.startingBid,
    required this.currentBid, required this.bidCount,
    required this.endTime, this.category = 'All',
  });

  static List<AuctionItem> getMockAuctions() => [
    AuctionItem(id: 'a1', name: 'Rolex Submariner', description: 'Vintage 1965 Rolex Submariner. Original box and papers.',
      imageUrl: 'https://picsum.photos/400/400?random=201',
      startingBid: 5000, currentBid: 6750, bidCount: 23,
      endTime: DateTime.now().add(const Duration(hours: 2)), category: 'Watches'),
    AuctionItem(id: 'a2', name: 'iPhone 15 Pro Max', description: 'Brand new, sealed. 256GB Natural Titanium.',
      imageUrl: 'https://picsum.photos/400/400?random=202',
      startingBid: 800, currentBid: 1050, bidCount: 15,
      endTime: DateTime.now().add(const Duration(hours: 5)), category: 'Electronics'),
    AuctionItem(id: 'a3', name: 'PS5 Bundle', description: 'PS5 + 3 games + extra controller.',
      imageUrl: 'https://picsum.photos/400/400?random=203',
      startingBid: 350, currentBid: 520, bidCount: 28,
      endTime: DateTime.now().add(const Duration(minutes: 45)), category: 'Gaming'),
    AuctionItem(id: 'a4', name: 'Hermès Birkin 30', description: 'Togo leather, Gold hardware.',
      imageUrl: 'https://picsum.photos/400/400?random=204',
      startingBid: 8000, currentBid: 12400, bidCount: 41,
      endTime: DateTime.now().add(const Duration(hours: 8)), category: 'Fashion'),
    AuctionItem(id: 'a5', name: 'Porsche 911 GT3', description: '2023 model, 4000km, full service history.',
      imageUrl: 'https://picsum.photos/400/400?random=205',
      startingBid: 150000, currentBid: 178000, bidCount: 9,
      endTime: DateTime.now().add(const Duration(days: 1)), category: 'Cars'),
  ];
}

// ════════════════════════════════════════
// CART MODELS
// ════════════════════════════════════════
class CartItem {
  final String id, imageUrl, brand, name;
  final double price;
  int quantity;

  CartItem({
    required this.id, required this.imageUrl, required this.brand,
    required this.name, required this.price, this.quantity = 1,
  });
}

// ════════════════════════════════════════
// CHECKOUT MODELS
// ════════════════════════════════════════
enum PaymentType { creditCard, paypal, cashOnDelivery }

class Address {
  final String id, name, fullName, street, city, state, zipCode, country, phone;
  final bool isDefault;

  const Address({
    required this.id, required this.name, required this.fullName,
    required this.street, required this.city, required this.state,
    required this.zipCode, required this.country, required this.phone,
    this.isDefault = false,
  });
}

class PaymentMethod {
  final String id, name, details;
  final PaymentType type;
  final IconData icon;

  const PaymentMethod({
    required this.id, required this.type, required this.name,
    required this.icon, required this.details,
  });
}

