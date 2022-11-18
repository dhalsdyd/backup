import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:backup/app/pages/home/controller.dart';

abstract class FGBPApiInterface {
  Future<Map> loginWithGoogle(String idToken);
  Future<Map> onboardingAuth();
  Future<Map> refresh(String refreshToken);
  Future<void> onboardingName(String name);
  Future<void> onboardingCreateFamily(String name);

  Future<List<Category>> getCategories();

  Future<TodayStory> getTodayStory();

  Future<List<Album>> getAlbums();
  Future<AlbumDetail> getAlbumDetails(int albumId);
  Future<void> createAlbum(
      String name, String? description, int? categoryId, String? eventDate);
  Future<String> uploadFile(
      FileSource fileSource, Function(int, int)? onSendProgress);

  Future<void> createStory(int albumId, String? description, String imageKey);

  Future<Map> enterFamily(String familyCode);
  Future<String> getFamilyCode();

  Future<Profile> getMyProfile();
  Future<List<Member>> getFamilyMembers();
}
