import 'package:flutter/material.dart';

extension DoubleExtention on double {
  SizedBox get H => SizedBox(height: this);
  SizedBox get v => SizedBox(width: this);
}
