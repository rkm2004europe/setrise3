import '../models/product_model.dart';

final List<ProductModel> mockProducts = [
  ProductModel(
    id: 'p1', name: 'هاتف ذكي Pro Max', description: 'شاشة 6.7" ، ذاكرة 256GB', price: 1200, oldPrice: 1500,
    images: ['📱'], category: 'إلكترونيات', sellerId: 's1', sellerName: 'متجر التقنية', rating: 4.5, reviewCount: 230, stock: 15, hasDelivery: true, deliveryFee: 50, codAvailable: true,
  ),
  ProductModel(
    id: 'p2', name: 'حذاء رياضي نايك', description: 'مقاس 42، لون أسود', price: 350, oldPrice: 500,
    images: ['👟'], category: 'أزياء', sellerId: 's2', sellerName: 'عالم الرياضة', rating: 4.2, reviewCount: 89, stock: 40, hasDelivery: true, deliveryFee: 30, codAvailable: true,
  ),
  ProductModel(
    id: 'p3', name: 'بيتزا مارغريتا', description: 'جبنة طازجة، صلصة طماطم', price: 25,
    images: ['🍕'], category: 'طعام', sellerId: 's3', sellerName: 'مطعم البيتزا', rating: 4.8, reviewCount: 120, stock: 999, hasDelivery: true, deliveryFee: 15, codAvailable: false,
  ),
];
