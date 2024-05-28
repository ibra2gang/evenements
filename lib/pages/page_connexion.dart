import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'page_evenements.dart'; // Assurez-vous que vous avez importé la page des événements

class PageConnexion extends StatefulWidget {
  const PageConnexion({Key? key}) : super(key: key);

  @override
  State<PageConnexion> createState() => _PageConnexionState();
}

class _PageConnexionState extends State<PageConnexion> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _message;
  bool _isLoginMode = true;

  Future<void> _submit() async {
    setState(() {
      _message = "";
    });
    try {
      UserCredential userCredential;
      if (_isLoginMode) {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PageEvenements()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = e.message;
      });
    }
  }

  void _switchMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
    });
  }

  Widget saisirEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Adresse mail',
          icon: Icon(Icons.mail),
        ),
      ),
    );
  }

  Widget saisirMdp() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Mot de passe',
          icon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget boutonPrincipal() {
    return ElevatedButton(
      onPressed: _submit,
      child: Text(_isLoginMode ? 'Se connecter' : 'S\'inscrire'),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ), backgroundColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
    );
  }

  Widget boutonSecondaire() {
    return TextButton(
      onPressed: _switchMode,
      child: Text(_isLoginMode
          ? 'Créer un nouveau compte'
          : 'J\'ai déjà un compte'),
    );
  }

  Widget messageValidation() {
    return _message == null
        ? Container()
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _message!,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Connexion' : 'Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                saisirEmail(),
                saisirMdp(),
                SizedBox(height: 20),
                boutonPrincipal(),
                boutonSecondaire(),
                messageValidation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
