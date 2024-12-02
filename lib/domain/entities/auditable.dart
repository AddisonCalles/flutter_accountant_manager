import 'package:equatable/equatable.dart';

abstract class Auditable extends Equatable{
  final String? uuid;
  final DateTime? created;
  final DateTime? updated;
  final DateTime? deleted;
  final DateTime? serverCreated;
  final DateTime? serverUpdated;
  final bool? pendingSync;
  const Auditable({
    this.uuid,
    this.created,
    this.updated,
    this.deleted,
    this.serverUpdated,
    this.serverCreated,
    this.pendingSync,
  });
}