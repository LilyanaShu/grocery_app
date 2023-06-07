part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}

class HomeSuccessState extends HomeState{
  final List<ListModel> list;

  HomeSuccessState({required this.list});

}

class HomeErrorState extends HomeState{}

class HomeAddFavState extends HomeState{}

class HomeGotoCartActionState extends HomeActionState{}

class HomeGotoFavoritesActionState extends HomeActionState{
  final List<ListModel> favList;

  HomeGotoFavoritesActionState({required this.favList});
}

class HomeAddFavoritesActionState extends HomeActionState{
}

class HomeFavoriteRebuildState extends HomeState{
  final List<ListModel> list;
  HomeFavoriteRebuildState({required this.list});
}