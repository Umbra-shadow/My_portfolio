class Country {
  final String name;
  final String code;
  final String? isoCode;

  const Country({required this.name, required this.code, this.isoCode});

  // This is crucial for the DropdownButton to correctly compare and identify objects.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          code == other.code;

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ isoCode.hashCode;
}

class Poem {
  final String title;
  final String imageAsset;
  final String content;
  final String musicUrl;
  final String authorEmail;
  final String authorName;
  final String mood;

  Poem({
    required this.title,
    required this.imageAsset,
    required this.content,
    required this.musicUrl,
    required this.authorEmail,
    required this.authorName,
    required this.mood,
  });

  Poem copyWith({
    String? title,
    String? imageAsset,
    String? content,
    String? musicUrl,
    String? authorEmail,
    String? authorName,
    String? mood,
  }) {
    return Poem(
      title: title ?? this.title,
      imageAsset: imageAsset ?? this.imageAsset,
      content: content ?? this.content,
      musicUrl: musicUrl ?? this.musicUrl,
      authorEmail: authorEmail ?? this.authorEmail,
      authorName: authorName ?? this.authorName,
      mood: mood ?? this.mood,
    );
  }
}

// class User {
//   final int id;
//   final String name; // 'username' from the API
//   final String email;
//   final String phone;
//   final String role; // e.g., "Admin", "Staff", "Normal"
//   final bool isActive; // The boolean status from the API
//
//   // These are boolean flags for easy permission checks on the frontend if needed
//   final bool isStaff;
//   final bool isAdmin;
//   final bool isSuperuser;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.role,
//     required this.isActive,
//     required this.isSuperuser,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     // Helper to determine the highest role
//     String determineRole(bool isSuper, bool isAdmin, bool isStaff) {
//       if (isSuper) return 'Superuser';
//       return 'Normal';
//     }
//
//     // Get the boolean flags from the JSON
//     final bool isSuperuserFlag = json['is_superuser'] ?? false;
//
//     return User(
//       id: json['id'],
//       name: json['username'] ?? 'No Name',
//       email: json['email'] ?? 'No Email',
//       phone: json['phone_number'] ?? '',
//       // Determine the role string from the flags
//       isActive: json['is_active'] ?? false,
//       isSuperuser: isSuperuserFlag,
//       role: determineRole(isSuperuserFlag),
//     );
//   }
// }
