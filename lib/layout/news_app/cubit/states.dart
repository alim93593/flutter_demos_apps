

abstract class NewsStates{}

class NewsIntialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}


class NewsBussinesLoadingState extends NewsStates{}

class NewsBussinesErrorState extends NewsStates{
  final String error;
  NewsBussinesErrorState(this.error);
}

class NewsBussinesSuccessState extends NewsStates{}


class NewsSportsLoadingState extends NewsStates{}

class NewsSportsErrorState extends NewsStates{
  final String error;
  NewsSportsErrorState(this.error);
}

class NewsSportsSuccessState extends NewsStates{}


class NewsScineceLoadingState extends NewsStates{}
class NewsScineceErrorState extends NewsStates{
  final String error;
  NewsScineceErrorState(this.error);
}
class NewsScineceSuccessState extends NewsStates{}

class NewsSearchLoadingState extends NewsStates{}
class NewsSearchErrorState extends NewsStates{
  final String error;
  NewsSearchErrorState(this.error);
}
class NewsSearchSuccessState extends NewsStates{}