import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class UserNotifier extends AsyncNotifier<List<User>> {
  final ApiServices apiServices;

  UserNotifier(this.apiServices);

  @override
  Future<List<User>> build() async {
    return await fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    try {
      return await apiServices.getUsers();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  void retry() {
    state = const AsyncValue.loading();
    fetchUsers();
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, List<User>>(
  () => UserNotifier(ApiServices()),
);
