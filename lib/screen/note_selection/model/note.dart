import 'package:flutter/material.dart';

class Note{
  DateTime date;
  String title;
  Color couleur;
  Key key;
  Note({required this.couleur, required this.date, required this.title, required this.key});
}