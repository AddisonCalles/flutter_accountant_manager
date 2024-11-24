import 'package:accountant_manager/domain/entities/pagination.dart';
class AuditableFilter extends Pagination {
  final bool? isDeleted;
  final DateTime? startCreated;
  final DateTime? endCreated;
  const AuditableFilter({required super.page, required super.pageSize, this.startCreated, this.endCreated, this.isDeleted = false});

  @override
  List<Object?> get props => [startCreated, endCreated];
}