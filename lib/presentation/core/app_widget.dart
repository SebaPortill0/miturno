import 'package:App/application/auth/auth_bloc.dart';
import 'package:App/injection.dart';
import 'package:App/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:App/presentation/sign_in/sign_in_page.dart';
import 'package:App/presentation/core/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        ),
      ],
      child: MaterialApp(
        builder: ExtendedNavigator(router: Router()),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: mainBlack,
        ),
        home: SignInPage(),
      ),
    );
  }
}