part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class FetchNotes extends NotesEvent {}

class UpdateNotes extends NotesEvent {
  final List<Note> notes;

  const UpdateNotes({@required this.notes});

  @override
  List<Object> get props => [notes];

  @override
  String toString() => 'UpdateNotes { notes: $notes }';
}
