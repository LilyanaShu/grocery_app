part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{

}

class HomeFavoritesIconClickedEvent extends HomeEvent{
  final ListModel favClicked;

  HomeFavoritesIconClickedEvent({required this.favClicked});
}

class HomeRemoveFavClickedEvent extends HomeEvent{
  final ListModel favRemove;

  HomeRemoveFavClickedEvent({required this.favRemove});
}

class HomeCartIconClickedEvent extends HomeEvent{
  final ListModel cartClicked;

  HomeCartIconClickedEvent({required this.cartClicked});
}

class HomeFavoritesPageEvent extends HomeEvent{
  final List<ListModel> favList;

  HomeFavoritesPageEvent({required this.favList});
}

class HomeCartPageEvent extends HomeEvent{

}