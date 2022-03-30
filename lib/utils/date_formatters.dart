String formatToDDMMYYYY(String date) {
  final _date = DateTime.parse(date);
  final month = _date.month < 10 ? "0${_date.month}" : _date.month;
  return "${_date.day}/$month/${_date.year}";
}
