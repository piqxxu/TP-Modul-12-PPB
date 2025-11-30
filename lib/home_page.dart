import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'user_controller.dart';
import 'user_model.dart';
import 'add_user_page.dart';

class HomePage extends StatelessWidget {
  final UserController userController = UserController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modul 12 - Firebase PART I')),
      body: StreamBuilder<List<UserModel>>(
        stream: userController.streamUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data;

          if (users == null || users.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada data pengguna.\nSilakan tambahkan data baru.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.description),
                      const SizedBox(height: 4),
                      Text(
                        'Dibuat: ${DateFormat('dd-MM-yyyy HH:mm').format(user.createdDate.toLocal())}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddUserPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
