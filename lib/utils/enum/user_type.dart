enum UserType {
  panchayat,
  vwsc,
  njmp,
  ftk,
}

extension UserTypeExtension on UserType {
  int get id {
    switch (this) {
      case UserType.panchayat:
        return 10001;
      case UserType.vwsc:
        return 10;
      case UserType.njmp:
        return 45;
      case UserType.ftk:
        return 46;
    }
  }

  String get name {
    switch (this) {
      case UserType.panchayat:
        return "Panchayat";
      case UserType.vwsc:
        return "VWSC";
      case UserType.njmp:
        return "NJMP";
      case UserType.ftk:
        return "SHGs / FTK Trained Women";
    }
  }
}