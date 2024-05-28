import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenements/pages/page_connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modeles/evenement.dart';
import '../modeles/gestion_donnees.dart';

class PageEvenements extends StatefulWidget {
  const PageEvenements({Key? key}) : super(key: key);

  @override
  _PageEvenementsState createState() => _PageEvenementsState();
}

class _PageEvenementsState extends State<PageEvenements> {
  List<Evenement> evenements = []; // Liste des événements à afficher

  @override
  void initState() {
    super.initState();
    _loadEvenements();
  }

  Future<void> _loadEvenements() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(Evenement.NOM_COLLECTION_EVENEMENT)
          .get();

      setState(() {
        evenements = querySnapshot.docs
            .map((doc) => Evenement.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("Erreur lors du chargement des événements : $e");
    }
  }

  void basculerEtatFavori(Evenement evenement) {
    setState(() {
      evenement.estFavori = !evenement.estFavori;
      modifierEvenementDansFirebase(evenement);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des événements'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PageConnexion()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: evenements.length,
        itemBuilder: (context, index) {
          final evenement = evenements[index];
          return ListTile(
            title: Text(evenement.nom),
            subtitle: Text(evenement.description),
            trailing: IconButton(
              icon: Icon(
                evenement.estFavori ? Icons.star : Icons.star_border,
                color: evenement.estFavori ? Colors.amber : Colors.grey,
              ),
              onPressed: () => basculerEtatFavori(evenement),
            ),
          );
        },
      ),
    );
  }
}
