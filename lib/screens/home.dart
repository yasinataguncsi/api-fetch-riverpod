import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../provider/user_controller.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('User List With Api/Riverpod')),
      body: Builder(
        builder: (context) {
          if (asyncUserState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncUserState.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${asyncUserState.error}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => ref.read(userProvider.notifier).retry(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (asyncUserState.hasValue) {
            final users = asyncUserState.value!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final User user = users[index];
                return UserCard(user: user);
              },
            );
          } else {
            // Fallback for unexpected states
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: Colors.amber.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.avatar ?? ''),
              onBackgroundImageError: (exception, stackTrace) {
                const Icon(Icons.person, size: 60);
              },
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Id: ${user.id}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
