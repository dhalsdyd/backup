import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/provider/api_interface.dart';

class CategoryRepository {
  final FGBPApiInterface api;

  CategoryRepository(this.api);

  Future<List<Category>> getCategories() => api.getCategories();
}
