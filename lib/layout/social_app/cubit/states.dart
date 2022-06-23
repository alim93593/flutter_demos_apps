abstract class SocialStates {}

class SocialIntialState extends SocialStates{}


class SocialLoadingGetUserState extends SocialStates{}
class SocialSuccessGetUserState extends SocialStates{}
class SocialErrorGetUserState extends SocialStates{
  final String error;
  SocialErrorGetUserState(this.error);
}

class SocialChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}


class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}


class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserLoadingUpdateState extends SocialStates{}

////create post
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}

class SocialCreatePostImageDeleteSuccess extends SocialStates{}