
import 'package:accountant_manager/application/ports/uuid_generator.dart';
import 'package:uuid/uuid.dart';

class UUIDDartGenerator extends UUIDGenerator {
  @override
  String generate() {
    return const Uuid().v4();
  }
}