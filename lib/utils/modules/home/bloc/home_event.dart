part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends HomeEvent {
  const LoadData();

  @override
  List<Object> get props => [];
}

class TopFavChange extends HomeEvent {
  final int index;
  const TopFavChange({required this.index});
  @override
  List<Object> get props => [index];
}
class CategoriesFavChange extends HomeEvent {
  final int index;
  const CategoriesFavChange({required this.index});
  @override
  List<Object> get props => [index];
}
class CategoriesShare extends HomeEvent {
  final int index;
  const CategoriesShare({required this.index});
  @override
  List<Object> get props => [index];
}
class EmptyMessage extends HomeEvent {
  const EmptyMessage();
}