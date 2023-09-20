class UserData {
  final String uid;
  final String email;

  // Pour l\'instant on veut pas enregistrer password dans firebase, on ajoutera après les autres infos du Profile (nom, prenom, photo,..)

  UserData({
    required this.uid,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      email: map['email'] ?? '',
    );
  }
}
