import 'package:equatable/equatable.dart';

class Pagination extends Equatable{
  final int page;
  final int pageSize;

  const Pagination({required this.page, required this.pageSize});

  Pagination copyWith({int? page, int? pageSize}) {
    return Pagination(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  int get offset => (page - 1) * pageSize;

  @override
  List<Object?> get props => [page, pageSize];
}