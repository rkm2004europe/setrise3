import '../models/marketplace_listing_model.dart';

final List<MarketplaceListingModel> mockMarketplace = [
  MarketplaceListingModel(
    id: 'ml1', title: 'جهاز ألعاب مستعمل', description: 'PlayStation 5 مع يدين', price: 1800,
    category: 'إلكترونيات', sellerId: 'u1', sellerName: 'كريم', location: 'الجزائر العاصمة',
    postedAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  MarketplaceListingModel(
    id: 'ml2', title: 'طاولة طعام خشبية', description: 'طاولة 6 كراسي', price: 950,
    category: 'أثاث', sellerId: 'u2', sellerName: 'سارة', location: 'وهران',
    postedAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
];
