/// Constants used throughout the train reservation app that don't require localization.
class AppConstants {
  /// List of train station names in Korean.
  /// Used in station selection screens and displaying routes.
  static const stationNames = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ];

  /// Letters representing seat columns in train cars.
  /// Used for seat selection and displaying seat information.
  static const colLetters = ['A', 'B', 'C', 'D'];

  static const korailUrl = 'https://www.korail.com/';
}
