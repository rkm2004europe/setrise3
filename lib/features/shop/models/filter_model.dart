class FilterModel {
  String category;
  double minPrice;
  double maxPrice;
  String sortBy;

  FilterModel({
    this.category = 'الكل',
    this.minPrice = 0,
    this.maxPrice = 10000,
    this.sortBy = 'latest',
  });
}
