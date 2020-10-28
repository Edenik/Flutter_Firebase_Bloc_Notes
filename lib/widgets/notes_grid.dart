import 'package:flutter/material.dart';
import 'package:flutter_bloc_notes/models/models.dart';
import 'package:intl/intl.dart';

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  final void Function(Note) onTap;

  const NotesGrid({@required this.notes, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 40.0,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          final Note note = notes[index];
          return _buildNote(note);
        }, childCount: notes.length),
      ),
    );
  }

  _buildNote(Note note) {
    return GestureDetector(
      onTap: () => onTap(note),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  note.content,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              Text(
                DateFormat.yMd().add_jm().format(note.timestamp),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        color: note.color,
      ),
    );
  }
}
