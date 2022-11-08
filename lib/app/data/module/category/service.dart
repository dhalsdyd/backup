import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/module/category/repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryRepository repository;
  CategoryController(this.repository);

  final Rx<List<Category>> _categories = Rx([]);
  List<Category> get categories => _categories.value;

  Future<List<Category>> getCategories() async {
    try {
      _categories.value = await repository.getCategories();
      return _categories.value;
    } on DioError catch (e) {
      print(e.response!.data);
      return [];
    }
  }
}
