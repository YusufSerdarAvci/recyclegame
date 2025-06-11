// lib/screens/leaderboard_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycle_game/services/firestore_service.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No scores yet. Be the first!'));
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Could not load leaderboard.'));
          }

          final scores = snapshot.data!.docs;

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final scoreData = scores[index].data() as Map<String, dynamic>;
              return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text(scoreData['displayName'] ?? 'Anonymous'),
                trailing: Text(
                  '${scoreData['score'] ?? 0}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              );
            },
          );
        },
      ),
    );
  }
}