import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:impots_benin/global.dart';
import 'package:impots_benin/useful/colors.dart';
import 'package:impots_benin/app/components/text_components.dart';
import '/models/notification.dart';

class PageNotifications extends StatefulWidget {
  const PageNotifications({super.key});

  @override
  State<PageNotifications> createState() => _PageNotificationsState();
}

class _PageNotificationsState extends State<PageNotifications> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool isLoading = true;
  List<NotificationModel> notifications = [];

  Future<void> fetchNotifications() async {
    final token = await _storage.read(key: 'auth_token');

    try {
      final response = await http.get(
        Uri.parse('${Global.baseUrl}/notifications'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> list = data['data'] ?? [];

        setState(() {
          notifications =
              list.map((item) => NotificationModel.fromJson(item)).toList();
        });
      } else {
        print('Erreur serveur : ${response.statusCode}');
        print('Réponse : ${response.body}');
      }
    } catch (e) {
      print('Erreur réseau : $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundApp,
      appBar: AppBar(
        backgroundColor: backgroundApp,
        elevation: 1,
        centerTitle: true,
        title: TextComponents(
          txt: "Notifications",
          fw: FontWeight.bold,
          family: "Bold",
          txtSize: 20,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: mainColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.notifications_off, size: 40, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      "Aucune notification pour le moment.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Text(
                          notif.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              notif.body,
                              style: const TextStyle(fontSize: 14),
                            ),
                            if (notif.is_send != null) ...[
                              const SizedBox(height: 5),
                              Text(
                                notif.is_send!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ]
                          ],
                        ),
                        onTap: () {
                          // Optionnel : afficher un dialogue ou une page détail
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text(notif.title),
                              content: Text(notif.body),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: const Text('Fermer'),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
