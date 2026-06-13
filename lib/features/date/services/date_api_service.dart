import '../models/date_user_model.dart';
import '../data/mock_date_users.dart';

class DateApiService {
  Future<List<DateUserModel>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockDateUsers;
  }

  Future<DateUserModel?> fetchUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockDateUsers.where((u) => u.id == id).firstOrNull;
  }
}
