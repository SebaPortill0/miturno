import 'package:App/domain/auth/auth_failure.dart';
import 'package:App/domain/auth/i_auth_facade.dart';
import 'package:App/domain/auth/user.dart';
import 'package:dartz/dartz.dart';
import 'package:App/domain/auth/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import './firebase_user_mapper.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthFacade(this._firebaseAuth);

  @override 
  Future<Option<User>> getSignedInUser() => _firebaseAuth.currentUser().
    then((firebaseUser) {
      return optionOf(firebaseUser?.toDomain());
    });

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress, 
    @required Password password}) async {
      final emailAddressString = emailAddress.getOrCrash();
      final passwordString = password.getOrCrash();
      try{
        await _firebaseAuth.createUserWithEmailAndPassword(email: emailAddressString, password: passwordString);
        return right(unit);
      } 
      on PlatformException catch(e) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return left(const AuthFailure.emailAlreadyInUse());
        } else {
          return left(const AuthFailure.serverError());
        }
      }
    }
  
  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress, 
    @required Password password}) async {
      final emailAddressString = emailAddress.getOrCrash();
      final passwordString = password.getOrCrash();
      try{
        await _firebaseAuth.signInWithEmailAndPassword(email: emailAddressString, password: passwordString);
        return right(unit); 
      } 
      on PlatformException catch(e) {
        if (e.code == 'ERROR_WRONG_PASSWORD' || e.code == 'ERROR_USER_NOT_FOUND') {
          return left(const AuthFailure.invalidEmailAndPasswordConvination());
        } else {
          return left(const AuthFailure.serverError());
        }
      }
  }

  @override 
  Future<void> signOut() => Future.wait([
    _firebaseAuth.signOut(),
  ]);
}