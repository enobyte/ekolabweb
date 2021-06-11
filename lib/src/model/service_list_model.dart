import 'package:flutter/material.dart';

class ServiceList {
  String cardTitle;
  IconData icon;
  int tasksRemaining;
  double taskCompletion;

  ServiceList(
      this.cardTitle, this.icon, this.tasksRemaining, this.taskCompletion);
}
