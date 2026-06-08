import '../data/filters_data.dart';

class FilterService {
  PostFilter getFilter(int index) {
    return availableFilters[index];
  }

  List<PostFilter> getAllFilters() => availableFilters;
}
