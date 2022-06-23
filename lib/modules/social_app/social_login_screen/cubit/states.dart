


abstract class SocialLoginStates {}


class SocialLoginIntialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialLoginSuccessState extends SocialLoginStates{
  final String uId;
  SocialLoginSuccessState(this.uId);
}


class SocialChangePasswordVisibiltyState extends SocialLoginStates{}