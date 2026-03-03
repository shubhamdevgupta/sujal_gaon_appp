import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String village;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.village,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF1F8FF),
            Color(0xFFE3F2FD),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔵 Avatar
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF64B5F6), Color(0xFF1E88E5)],
              ),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          /// 🔵 Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Name
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D47A1),
                  ),
                ),

                const SizedBox(height: 10),

                /// Email Row
                _infoRow(
                  icon: Icons.email_outlined,
                  text: email,
                ),

                const SizedBox(height: 6),

                /// Village Row
                _infoRow(
                  icon: Icons.location_on_outlined,
                  text: village,
                ),
              ],
            ),
          ),

          /// Arrow Icon
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }

  Widget _infoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blueGrey),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}