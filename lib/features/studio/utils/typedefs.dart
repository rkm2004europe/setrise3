library;

import 'package:flutter/material.dart';

typedef Microseconds = int;
typedef StudioId = String;
typedef FractionalFps = ({int num, int den});
typedef Dpi = double;

extension MicrosecondsExt on Microseconds {
  Duration get duration => Duration(microseconds: this);
  double get seconds => this / 1e6;
}

Microseconds microseconds(int value) => value;
Microseconds fromSeconds(double seconds) => (seconds * 1e6).round();
