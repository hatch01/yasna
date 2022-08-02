import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yasna/screen/note_selection/component/res.dart';

import '../controller/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final int id;
  final TileType tileType;

  const NoteTile({
    Key? key,
    required this.note,
    required this.tileType,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print("click on ${note.title}");
        }
      },
      child: Container(
        // margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        // width: 100.w,
        height: 50.h,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Res.tileColors[id % 7],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: tileType == TileType.horRect
                  ? const EdgeInsets.only(right: 100)
                  : null,
              child: Text(
                note.title,
                maxLines: _getMaxLines(tileType),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${note.date.day} ${Res.monthToName[note.date.month]} ${note.date.year}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getMaxLines(TileType tileType) {
    switch (tileType) {
      case TileType.square:
        return 4;
      case TileType.verRect:
        return 8;
      case TileType.horRect:
        return 3;
    }
  }
}
