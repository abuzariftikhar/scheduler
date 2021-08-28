import 'package:flutter/material.dart';
import 'package:scheduler/models/Timeline.dart';
import 'package:scheduler/repository/TimelineRepository.dart';

class BookingScreenBloc extends ChangeNotifier {
  TimelineRepository _timelineRepository = TimelineRepositoryImpl();

  List<int> occupiedTimeline = [];
  List<int> currentTimelineSelection = [];
  List<TimeOfDay> totalTimeSlots = [];
  bool isLoading = false;
  int shopOpeningTimeIndex = 40;
  int shopClosingTimeIndex = 92;
  int widgetIndex = 0;
  int previousIndex = -1;
  int paymentIndex = -1;
  int totalSlotsRequired = 5;

  void update() {
    notifyListeners();
  }

  void reset() {
    widgetIndex = 0;
    previousIndex = 0;
    paymentIndex = -1;
    currentTimelineSelection.clear();
  }

  void makeTimeSlots() {
    totalTimeSlots.clear();
    var slot = TimeOfDay(hour: 00, minute: 0);
    while (slot.before(TimeOfDay(hour: 23, minute: 61))) {
      totalTimeSlots.add(slot);
      slot = slot.add(minutes: 15);
    }
  }

  Future loadOccupiedTimelinesByDate(DateTime date) async {
    occupiedTimeline.clear();
    isLoading = true;
    var _list = await _timelineRepository.getOccupiedTimelinesByDate(date);
    _list.map((e) => e.timelineSpan.forEach((element) {
          occupiedTimeline.add(element);
        }));
    isLoading = false;
    notifyListeners();
  }

  Future postTimeline(Timeline timeline) async {
    isLoading = true;
    await _timelineRepository.createTimeline(timeline);
    isLoading = false;
    notifyListeners();
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compare(TimeOfDay other) {
    return this.inMinutes() - other.inMinutes();
  }

  int inMinutes() {
    return this.hour * 60 + this.minute;
  }

  bool before(TimeOfDay other) {
    return this.compare(other) < 0;
  }

  bool after(TimeOfDay other) {
    return this.compare(other) > 0;
  }

  TimeOfDay add({required int minutes}) {
    final total = this.inMinutes() + minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }
}
