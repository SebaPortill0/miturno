import 'package:App/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:App/presentation/core/styles.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption
          .fold(() {}, 
          (either) => either.fold(
            (failure) {
              FlushbarHelper.createError(
                message: failure.map(
                  cancelledByUser: (_) => 'Cancelado', 
                  serverError: (_) => 'Error del servidor', 
                  emailAlreadyInUse: (_) => 'El email ya está en uso', 
                  invalidEmailAndPasswordConvination: (_) => 'Email y/o contraseña inválido/s',
                )
              );
            }, 
            (_) => {
              // TODO: Navigate
            }
          )
          );
      },
      builder: (context, state) {
        // Handling taps outside of textField for dismissing keyboard
        return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
                  child: Form(
            autovalidate: state.showErrorMessages,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(  
                        child: Image.asset('assets/main_image.png')
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        autocorrect: false,
                        onChanged: (value) => context
                          .bloc<SignInFormBloc>()
                          .add(SignInFormEvent.emailChanged(value)),
                        validator: (_) => context
                          .bloc<SignInFormBloc>()
                          .state 
                          .emailAddress
                          .value
                          .fold(
                            (f) => f.maybeMap(
                              invalidEmail: (_) => 'Email inválido', 
                              orElse: () => null
                            ), 
                            (r) => null,
                          ),
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Contraseña",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) => context
                          .bloc<SignInFormBloc>()
                          .add(SignInFormEvent.passwordChanged(value)),
                        validator: (_) => context
                          .bloc<SignInFormBloc>()
                          .state 
                          .password
                          .value
                          .fold(
                            (f) => f.maybeMap(
                              shortPassword: (_) => 'Contraseña demasiado corta', 
                              orElse: () => null
                            ), 
                            (r) => null,
                          ),
                      ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              color: lighterBlack,
                              textColor: white,
                              colorBrightness: Brightness.dark,
                              highlightElevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)
                              ),
                              child: Text("Iniciar sesión"),
                              onPressed: () {
                                context.bloc<SignInFormBloc>().add(
                                  const SignInFormEvent.signInWithEmailAndPasswordPressed()
                                );
                              },
                            ),
                          ),
                          horizontalSpaceTiny,
                          Expanded(
                            child: RaisedButton(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              color: lighterBlack,
                              textColor: white,
                              colorBrightness: Brightness.dark,
                              highlightElevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)
                              ),
                              child: Text("Registrarse"),
                              onPressed: () {
                                context.bloc<SignInFormBloc>().add(
                                  const SignInFormEvent.registerWithEmailAndPasswordPressed()
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("Mas información", style: TextStyle(color: lightGrey)),
              ]),
            )
          ),
        );
      },
    );
  }
}