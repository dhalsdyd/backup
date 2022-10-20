import 'package:backup/app/data/provider/api_interface.dart';

class TestRepository {
  final FGBPApiInterface api;

  TestRepository(this.api);

  Future<void> get() => api.getInfo();
}
