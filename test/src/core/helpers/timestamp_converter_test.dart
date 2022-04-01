import 'package:currency_converter/src/core/helpers/timestamp_converter.dart';
import 'package:test/test.dart';

void main() {
   test('Should return a DateTime from Timestamp', () {
    final date = TimestampHelper.toDateTime(1648760400); // 31/03/2022 18:00:00

    expect(date, isA<DateTime>());
    expect(date.day, equals(31));
    expect(date.month, equals(3));
    expect(date.year, equals(2022));
    expect(date.hour, equals(18));
  });
}