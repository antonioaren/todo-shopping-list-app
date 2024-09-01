import "package:todo_shopping_list_app/presentation/providers/counter.dart";
import "package:test/test.dart";

void main() {
  group("CounterState", () {
    test("should increment the counter", () {
      final CounterState counterState = CounterState();
      counterState.incrementCounter();
      expect(counterState.getCurrent(), 1);
    });

    test("should decrement the counter", () {
      final CounterState counterState = CounterState();
      counterState.incrementCounter();
      counterState.decrementCounter();
      expect(counterState.getCurrent(), 0);
    });
  });
}
