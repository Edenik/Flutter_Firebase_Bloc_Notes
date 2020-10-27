part of 'note_detail_bloc.dart';

abstract class NoteDetailEvent extends Equatable {
  const NoteDetailEvent();

  @override
  List<Object> get props => [];
}

class NoteLoaded extends NoteDetailEvent {
  final Note note;
  const NoteLoaded({@required this.note});

  @override
  List<Object> get props => [note];

  @override
  String toString() => 'NoteLoaded { note: $note }';
}

class NoteContentUpdated extends NoteDetailEvent {
  final String content;
  const NoteContentUpdated({@required this.content});

  @override
  List<Object> get props => [content];

  @override
  String toString() => 'NoteContentUpdated { content: $content }';
}

class NoteColorUpdated extends NoteDetailEvent {
  final Color color;
  const NoteColorUpdated({@required this.color});

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'NoteColorUpdated { color: $color }';
}

class NoteAdded extends NoteDetailEvent {}

class NoteSaved extends NoteDetailEvent {}

class NoteDeleted extends NoteDetailEvent {}
