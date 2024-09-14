import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String timestampToTime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  DateFormat formatter = DateFormat('h:mm a');

  return formatter.format(dateTime);
}
