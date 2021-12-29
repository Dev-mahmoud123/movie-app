part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchTermChangedEvent extends SearchEvent {
  final String searchTerm;

  const SearchTermChangedEvent(this.searchTerm);

  @override
  List<Object?> get props => [searchTerm];
}
