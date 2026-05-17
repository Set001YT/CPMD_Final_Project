import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:flutter/foundation.dart';

QueryExecutor openDriftDatabase() {
  return DatabaseConnection.delayed(Future(() async {
    try {
      final response = await WasmDatabase.open(
        databaseName: 'cinewave_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );

      if (response.missingFeatures.isNotEmpty) {
        debugPrint(
            'Drift: missing optional features: ${response.missingFeatures}');
      }
      debugPrint(
          'Drift: opened web database via ${response.chosenImplementation}');
      return response.resolvedExecutor;
    } catch (e, st) {
      debugPrint('Drift web open failed: $e\n$st');
      rethrow;
    }
  }));
}
