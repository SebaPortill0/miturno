import 'package:App/domain/auth/auth_failure.dart';
import 'package:App/domain/auth/user.dart';
import 'package:App/domain/auth/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';


abstract class IAuthFacade {

  Future<Option<User>> getSignedInUser();
  
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    @required EmailAddress emailAddress,
    @required Password password,
  });

  Future<void> signOut();

}