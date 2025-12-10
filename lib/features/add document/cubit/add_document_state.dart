part of 'add_document_cubit.dart';

abstract class AddDocumentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddDocumentInitial extends AddDocumentState {}

class AddDocumentLoading extends AddDocumentState {}

class AddDocumentSuccess extends AddDocumentState {}

class AddDocumentError extends AddDocumentState {
  final String message;

  AddDocumentError({required this.message});

  @override
  List<Object?> get props => [message];
}