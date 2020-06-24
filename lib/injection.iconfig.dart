// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:App/infrastructure/core/firebase_injectable_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:App/infrastructure/auth/firebase_auth_facade.dart';
import 'package:App/domain/auth/i_auth_facade.dart';
import 'package:App/infrastructure/clients/client_repository.dart';
import 'package:App/domain/clients/i_client_respository.dart';
import 'package:App/infrastructure/services/service_repository.dart';
import 'package:App/domain/services/i_service_repository.dart';
import 'package:App/infrastructure/users/user_repository.dart';
import 'package:App/domain/user_data/i_user_repository.dart';
import 'package:App/application/services/service_form/service_form_bloc.dart';
import 'package:App/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:App/application/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  g.registerLazySingleton<FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  g.registerLazySingleton<Firestore>(() => firebaseInjectableModule.firestore);
  g.registerLazySingleton<IAuthFacade>(
      () => FirebaseAuthFacade(g<FirebaseAuth>()));
  g.registerFactory<ServiceFormBloc>(
      () => ServiceFormBloc(g<IServiceRepository>()));
  g.registerFactory<SignInFormBloc>(() => SignInFormBloc(g<IAuthFacade>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(
        g<IAuthFacade>(),
        g<IUserRepository>(),
        g<IClientRepository>(),
        g<IServiceRepository>(),
      ));

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<IClientRepository>(
        () => ClientRepository(g<Firestore>()));
    g.registerLazySingleton<IServiceRepository>(
        () => ServiceRepository(g<Firestore>()));
    g.registerLazySingleton<IUserRepository>(
        () => UserRepository(g<Firestore>()));
  }
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}
