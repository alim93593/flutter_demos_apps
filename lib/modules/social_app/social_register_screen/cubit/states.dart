

// ignore_for_file: non_constant_identifier_names



abstract class SocialRegisterStates {}


class SocialRegisterIntialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialRegisterSuccessState extends SocialRegisterStates{}



class SocialRegisterChangePasswordVisibiltyState extends SocialRegisterStates{}


class SocialSuccessCreateUserState extends SocialRegisterStates{}
class SocialErrorCreateUserState extends SocialRegisterStates{
  final String error;
  SocialErrorCreateUserState(this.error);
}