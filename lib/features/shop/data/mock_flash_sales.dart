import '../models/product_model.dart';

final List<ProductModel> flashSaleProducts = [
  ProductModel(
    id: 'fs1', name: 'سماعات بلوتوث', description: 'عزل ضوضاء', price: 99, oldPrice: 199,
    images: ['🎧'], category: 'إلكترونيات', sellerId: 's1', sellerName: 'متجر التقنية', rating: 4.3, reviewCount: 56, stock: 5, hasDelivery: true, deliveryFee: 20, codAvailable: false,
  ),
  ProductModel(
    id: 'fs2', name: 'تي شيرت قطني', description: 'مقاسات متعددة', price: 29, oldPrice: 59,
    images: ['👕'], category: 'أزياء', sellerId: 's2', sellerName: 'عالم الرياضة', rating: 4.0, reviewCount: 12, stock: 30, hasDelivery: true, deliveryFee: 15, codAvailable: true,
  ),
];
