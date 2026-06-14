import '../models/product_model.dart';

final List<ProductModel> mockRecommendedProducts = [
  ProductModel(id: 'r1', name: 'سماعات احترافية', description: '', price: 180, oldPrice: 250, images: ['🎧'], category: 'إلكترونيات', sellerId: 's1', sellerName: 'متجر التقنية', rating: 4.6, reviewCount: 45, stock: 20, hasDelivery: true, deliveryFee: 15, codAvailable: true),
  ProductModel(id: 'r2', name: 'حقيبة ظهر عصرية', description: '', price: 60, images: ['🎒'], category: 'أزياء', sellerId: 's2', sellerName: 'عالم الرياضة', rating: 4.3, reviewCount: 12, stock: 50, hasDelivery: true, deliveryFee: 10, codAvailable: true),
];
