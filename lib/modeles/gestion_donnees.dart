import 'package:cloud_firestore/cloud_firestore.dart';
import 'evenement.dart';

void modifierEvenementDansFirebase(Evenement evenement) async {
  try {
    await FirebaseFirestore.instance
        .collection(Evenement.NOM_COLLECTION_EVENEMENT)
        .doc(evenement.id)
        .update(evenement.toMap());
    print("Événement mis à jour avec succès");
  } catch (e) {
    print("Erreur lors de la mise à jour de l'événement : $e");
  }
}