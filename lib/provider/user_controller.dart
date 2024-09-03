import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class UserNotifier extends AsyncNotifier<List<User>> {
  final ApiServices apiServices;

  UserNotifier(this.apiServices);

  @override
  FutureOr<List<User>> build() async {
    return fetchUsers();
  }

  /// FETCHING USERS METHOD
  fetchUsers() async {
    try {
      state = const AsyncValue.loading();
      state = AsyncData(await apiServices.getUsers());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      throw Exception('Failed to load users: $e');
    }
  }

  /// RETRYING METHOD
  void retry() {
    fetchUsers();
  }
}

final userProvider = AsyncNotifierProvider<UserNotifier, List<User>>(
  () => UserNotifier(ApiServices()),
);
