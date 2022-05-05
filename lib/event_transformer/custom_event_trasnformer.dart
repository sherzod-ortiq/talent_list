import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

class CustomEventTransformer {
  static EventTransformer<E> throttleDroppable<E>({
    Duration duration = const Duration(milliseconds: 100),
  }) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }
}
