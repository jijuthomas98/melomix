part of 'music_player_bloc.dart';

@freezed
class MusicPlayerEvent with _$MusicPlayerEvent {
  const factory MusicPlayerEvent.halfCollapse() = HalfCollapse;
  const factory MusicPlayerEvent.play() = Play;
  const factory MusicPlayerEvent.stop() = Stop;
}
