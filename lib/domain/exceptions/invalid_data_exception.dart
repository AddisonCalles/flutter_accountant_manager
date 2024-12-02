import 'package:accountant_manager/domain/exceptions/domain_exception.dart';

class InvalidDataException extends DomainException {
  InvalidDataException(super.message);
}
