import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:untitled/auth/domain/repository.dart';

class AuthRepoImplement extends AuthRepo
{
  @override
  Future loginWithFacebook() async{
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    throw UnimplementedError();
  }

  @override
  Future loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

}