// class Evenement{
//   String? id;
//   late String _description;
//   late String _date;
//   late String _heureDebut;
//   late String _heureFin;
//   late String _animateur;
//   late bool estFavori;
//
//   static const NOM_COLLECTION_EVENEMENT = 'details_evenement';
//
//   Evenement({
//     this.id,
//     required String description,
//     required String date,
//     required String heureDebut,
//     required String heureFin,
//     required String animateur,
//     this.estFavori = false,
//   })  : _description = description,
//         _date = date,
//         _heureDebut = heureDebut,
//         _heureFin = heureFin,
//         _animateur = animateur;
//
//
//   String get description => _description;
//   String get date => _date;
//   String get heureDebut => _heureDebut;
//   String get heureFin => _heureFin;
//   String get animateur => _animateur;
//
//   factory Evenement.fromMap(String id, Map<String, dynamic> data) {
//     return Evenement(
//       id: id,
//       description: data['description'] ?? '',
//       date: data['date'] ?? '',
//       heureDebut: data['heureDebut'] ?? '',
//       heureFin: data['heureFin'] ?? '',
//       animateur: data['animateur'] ?? '',
//       estFavori: data['estFavori'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'description': _description,
//       'date': _date,
//       'heureDebut': _heureDebut,
//       'heureFin': _heureFin,
//       'animateur': _animateur,
//       'estFavori': estFavori,
//     };
//   }
//
// }

class Evenement {
  String id;
  String nom;
  String description;
  bool estFavori;

  Evenement({required this.id, required this.nom, required this.description, this.estFavori = false});

  // Méthode toMap pour convertir un objet Evenement en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'description': description,
      'estFavori': estFavori,
    };
  }

  // Méthode fromMap pour créer un objet Evenement à partir d'une Map
  factory Evenement.fromMap(Map<String, dynamic> map) {
    return Evenement(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      estFavori: map['estFavori'] ?? false,
    );
  }

  static const String NOM_COLLECTION_EVENEMENT = 'evenements';
}
