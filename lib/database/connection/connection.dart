import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openDriftDatabase() {
  return driftDatabase(name: 'cinewave_db');
}
