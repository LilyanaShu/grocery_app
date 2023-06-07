import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/list_data.dart';
import '../../../models/list_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeFavoritesIconClickedEvent>(homeFavoritesIconClickedEvent);
    on<HomeRemoveFavClickedEvent>(homeRemoveFavClickedEvent);
    on<HomeCartIconClickedEvent>(homeCartIconClickedEvent);
    on<HomeFavoritesPageEvent>(homeFavoritesPageEvent);
    on<HomeCartPageEvent>(homeCartPageEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadingState());
    //print('Initial Home');
    //await Future.delayed(Duration(seconds: 3));
    emit(HomeSuccessState(list: ListData.listData.map((e) =>
        ListModel(id: e['id'], name: e['name'], desc: e['description'],
            price: e['price'].toString(), imgUrl: e['image'], fav: e['fav']
        )).toList(),));
  }

  FutureOr<void> homeFavoritesIconClickedEvent(HomeFavoritesIconClickedEvent event, Emitter<HomeState> emit) {
    //print('Fav clicked');
     //print(event.favClicked.fav);

    // if(event.favClicked.fav) {
    //   if(!favData.contains(event.favClicked.id)){
    //     favData.add(event.favClicked);}
    // } else {
    //   favData.removeWhere((element) => element.id == event.favClicked.id);
    // }
     final index = ListData.listData.indexWhere((element) => element.containsValue(event.favClicked.id));
    //print(index);
    ListData.listData[index].update('fav', (value) => event.favClicked.fav);

    emit(HomeSuccessState(list: ListData.listData.map((e) =>
        ListModel(id: e['id'], name: e['name'], desc: e['description'],
            price: e['price'].toString(), imgUrl: e['image'], fav: e['fav']
        )).toList(),
    ));
  }

  FutureOr<void> homeRemoveFavClickedEvent(HomeRemoveFavClickedEvent event, Emitter<HomeState> emit) {
    final index = ListData.listData.indexWhere((element) => element.containsValue(event.favRemove.id));
    ListData.listData[index].update('fav', (value) => event.favRemove.fav);
    emit(HomeSuccessState(list: ListData.listData.map((e) =>
        ListModel(id: e['id'], name: e['name'], desc: e['description'],
            price: e['price'].toString(), imgUrl: e['image'], fav: e['fav']
        )).toList(),
    ));
    emit(HomeFavoriteRebuildState(list: ListData.listData.where((element) => element['fav'] == true).map((e) =>
        ListModel(id: e['id'], name: e['name'], desc: e['description'],
            price: e['price'].toString(), imgUrl: e['image'], fav: e['fav']
        )).toList(),
    ));
  }

  FutureOr<void> homeCartIconClickedEvent(HomeCartIconClickedEvent event, Emitter<HomeState> emit) {
    //print('Cart clicked');
  }

  FutureOr<void> homeFavoritesPageEvent(HomeFavoritesPageEvent event, Emitter<HomeState> emit) {
    //print('Fav page clicked');
    emit(HomeGotoFavoritesActionState(favList: event.favList.where((element) => element.fav).toList()));
  }

  FutureOr<void> homeCartPageEvent(HomeCartPageEvent event, Emitter<HomeState> emit) {
    //print('Cart page clicked');
    emit(HomeGotoCartActionState());
  }

}
