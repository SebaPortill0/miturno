part of 'sign_in_form_bloc.dart';

@freezed 
abstract class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    @required EmailAddress emailAddress,
    @required Password password,
    @required bool showErrorMessages,
    @required bool isLoginSubmitting,
    @required bool isRegisterSubmitting,
    @required Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption,
  }) = _SignInFormState;

  factory SignInFormState.initial() => SignInFormState(
    emailAddress: EmailAddress(''),
    password: Password(''),
    showErrorMessages: false,
    isLoginSubmitting: false,
    isRegisterSubmitting: false,
    authFailureOrSuccessOption: none(),
  );
}