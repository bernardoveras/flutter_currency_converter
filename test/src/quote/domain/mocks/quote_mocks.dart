import 'package:currency_converter/src/quote/domain/entities/quote_entity.dart';
import 'package:currency_converter/src/quote/domain/repositories/quote_repository.dart';
import 'package:mocktail/mocktail.dart';

class QuoteRepositoryMock extends Mock implements IQuoteRepository {}

class QuoteEntityMock extends Mock implements QuoteEntity {}