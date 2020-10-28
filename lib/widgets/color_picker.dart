import 'package:flutter/material.dart';
import 'package:flutter_bloc_notes/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPicker extends StatelessWidget {
  final NoteDetailState state;
  final List<Color> colors;

  const ColorPicker({@required this.state, @required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: colors.map((color) {
          bool isSelected = state.note != null && state.note.color == color;
          return GestureDetector(
            onTap: () => context
                .bloc<NoteDetailBloc>()
                .add(NoteColorUpdated(color: color)),
            child: Container(
              width: 30.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: isSelected
                      ? Border.all(color: Colors.black, width: 2.0)
                      : null),
            ),
          );
        }).toList(),
      ),
    );
  }
}
