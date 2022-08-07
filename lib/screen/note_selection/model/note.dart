import 'package:flutter/material.dart';

class Note{
  DateTime date;
  String title;
  Color couleur;
  String path;
  Key key;
  Note({required this.couleur, required this.date, required this.title, required this.key,required this.path});
}