// timer_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int> {
  final int initialSeconds;
  Timer? _timer;

  TimerCubit(this.initialSeconds) : super(initialSeconds) {
    _start();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 1) {
        emit(state - 1);
      } else {
        timer.cancel();
        emit(0); 
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    stop();
    return super.close();
  }
}
