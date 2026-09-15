import 'package:flutter/material.dart';
class AdminDashboard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10), // Obsidian Black
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0C10),
        title: const Text(
          'FIRGO Leaderboard',
          style: TextStyle(color: Color(0xFFFFBF00), fontWeight: FontWeight.bold), // Amber Gold
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2833),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFBF00), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Your Rank: #5', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Points: 1,240 XP', style: TextStyle(color: Color(0xFFFFBF00), fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF1F2833),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFFFBF00),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        'Top Driver #${index + 1}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('4.9 ★ Rating', style: TextStyle(color: Colors.grey)),
                      trailing: const Text(
                        'Rewards Unlocked',
                        style: TextStyle(color: Color(0xFFFFBF00), fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}