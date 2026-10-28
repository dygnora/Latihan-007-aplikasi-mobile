
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ProfileAvatar(),
            const SizedBox(height: 20),
            const ProfileInfo(
              userName: 'Deny Dermawan',
              role: 'Teknik Informatika | Software Engineering | Global Institute',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String count;
  final String label;

  const StatItem({
    super.key,
    required this.count,
    required this.label,
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: const Color.fromARGB(255, 86, 65, 2),
          ),
        )
      ],
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String userName;
  final String role;

  const ProfileInfo({
    super.key,
    required this.userName,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          userName,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          role,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20), 
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Fitur edit belum aktif pada modul statis.',
                ),
              ),
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit Profil'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            foregroundColor: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              StatItem(count: '15', label: 'Proyek'),
              SizedBox(height: 24),
              StatItem(count: '1,5k', label: 'Follower'),
              SizedBox(height: 24),
              StatItem(count: '100', label: 'Following')
            ]
          ),
        )
      ],
    );
  }
}
