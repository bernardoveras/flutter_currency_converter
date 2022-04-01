class TimestampHelper {
  const TimestampHelper._();

  static DateTime toDateTime(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}
