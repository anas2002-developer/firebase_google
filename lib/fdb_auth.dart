import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> Fdb_Google() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication?.idToken,
    accessToken: googleSignInAuthentication?.accessToken,
  );

  final userCredential = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  //checking

  assert(!user!.isAnonymous);
  assert(await user?.getIdToken() != null);

  final User? currentUser = await _auth.currentUser;
  assert(currentUser?.uid == user?.uid);

  print(user);

  return user;
}