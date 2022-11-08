import 'package:backup/app/data/models/user.dart';
import 'package:backup/app/data/provider/api_interface.dart';

class ProfileRepository {
  final FGBPApiInterface api;

  ProfileRepository(this.api);

  Future<String> getFamilyCode() => api.getFamilyCode();
  Future<Profile> getMyProfile() => api.getMyProfile();
  Future<List<Member>> getFamilyMembers() => api.getFamilyMembers();
}
