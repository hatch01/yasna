import 'package:flutter/material.dart';

class Res {
  static String appBarTitle = "Notes";


  static List<Color> tileColors = [
    const Color(0xFFffab91),
    const Color(0xFFffcc80),
    const Color(0xFFe6ee9b),
    const Color(0xFF80deea),
    const Color(0xFFcf93d9),
    const Color(0xFF80cbc4),
    const Color(0xFFf48fb1),
  ];

  static Map<int, String> monthToName = {
    1: "Jan",
    2: "Fev",
    3: "Mar",
    4: "Avr",
    5: "Mai",
    6: "Juin",
    7: "Juil",
    8: "Aout",
    9: "Sept",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  static final tileTypes = [
    TileType.square,
    TileType.square,
    TileType.horRect,
    TileType.verRect,
    TileType.square,
    TileType.verRect,
    TileType.square,
  ];
}

enum TileType {
  square,
  verRect,
  horRect,
}
