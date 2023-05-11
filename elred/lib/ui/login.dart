import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main.dart';
import '../widget/snackbar.dart';
import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3191),
        centerTitle: true,
        title: const Text(
          'TODO TASK',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      backgroundColor: const Color(0xFF2E3191),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://img.freepik.com/free-vector/isometric-time-management-concept-illustrated_52683-55459.jpg?size=626&ext=jpg&ga=GA1.1.260189797.1678791994&semt=ais'),
            GestureDetector(
                onTap: () async {
                  final GoogleSignInAccount? googleUser =
                      await googleSignIn.signIn();
                  if (googleUser != null) {
                    final GoogleSignInAuthentication googleAuth =
                        await googleUser.authentication;
                    final OAuthCredential credential =
                        GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    final UserCredential userCredential = await FirebaseAuth
                        .instance
                        .signInWithCredential(credential);
                    debugPrint('sign in success1');
                    final User? user = userCredential.user;
                    snackBar('successfully login', context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(userCredential.user!)),
                    );
                  }
                },
                child: Image.network('https://i.stack.imgur.com/JkSed.png')),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Attempt to sign in with Google
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // Get authentication credentials from the Google account
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;

        // Create a new credential for Firebase
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the credential
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        return userCredential;
      } else {
        // Handle sign-in error
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ACCOUNT',
          message: 'No Google account found for sign-in.',
        );
      }
    } catch (e) {
      // Handle sign-in error
      throw FirebaseAuthException(
        code: 'ERROR_GOOGLE_SIGN_IN_FAILED',
        message: 'Failed to sign in with Google: ${e.toString()}',
      );
    }
  }
}
