import 'package:counter_app_unit_test/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter:', () {
    test('value should start at 0', () {
      expect(Counter().value, 0);
    });
    test('Counter value should be incremented', () {
      final counter = Counter();
      //act
      counter.increment();
      //assert
      expect(counter.value, 1);
    });
    test('Counter value should be decremented', () {
      final counter = Counter();
      //act
      counter.decrement();
      //assert
      expect(counter.value, -1);
    });
  });
}
