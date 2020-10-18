import 'package:flutter_bloc_notes/models/models.dart';
import 'package:flutter_bloc_notes/repositories/repositories.dart';

abstract class BaseNoteRepository extends BaseRepository {
  Future<Note> addNote({Note note});
  Future<Note> updateNote({Note note});
  Future<Note> deleteNote({Note note});
  Stream<List<Note>> streamNotes({String userId});
}
