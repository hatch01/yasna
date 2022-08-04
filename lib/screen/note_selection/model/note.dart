import 'package:flutter/material.dart';

class Note{
  DateTime date;
  String title;
  Color couleur;
  Note({required this.couleur, required this.date, required this.title});
}