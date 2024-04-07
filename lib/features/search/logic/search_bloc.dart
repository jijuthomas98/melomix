import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:melomix/features/core/data/model/song/song.dart';
import 'package:melomix/features/search/data/enums.dart';
import 'package:melomix/features/search/data/repository/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchRepository)
      : super(const SearchInitial(SearchFilter.songs, SearchStatus.idle)) {
    on<UpdateSearchFilter>(_onSearchFilterSelected);
    on<SearchForSongs>(_onSearchForSongs);
  }

  final SearchRepository _searchRepository;

  FutureOr<void> _onSearchFilterSelected(
      UpdateSearchFilter event, Emitter<SearchState> emit) {
    emit(SearchFilterUpdated(event.searchFilter, state.searchStatus));
    //fetch music items based on filter selected
    //emit 3 different states
  }

  FutureOr<void> _onSearchForSongs(
      SearchForSongs event, Emitter<SearchState> emit) async {
    try {
      List<Song> songs =
          await _searchRepository.searchForSongs(query: event.songName);
      print(songs);
    } catch (e) {
      emit(SongSearchError(state.searchFilter, state.searchStatus));
    }
  }
}
