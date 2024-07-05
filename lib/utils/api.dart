import 'dart:convert';

import 'package:coursedog_app/models/course.dart';
import 'package:coursedog_app/models/favourite_course.dart';
import 'package:coursedog_app/models/favourite_events.dart';
import 'package:coursedog_app/models/response/current_planning_term_response.dart';
import 'package:coursedog_app/models/response/login_response.dart';
import 'package:coursedog_app/models/term.dart';
import 'package:coursedog_app/models/user.dart';
import 'package:coursedog_app/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://localhost:9292';

Future<LoginResponse> login(String email) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/v1/general/mobile-login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email}),
  );

  if (response.statusCode == 200) {
    final loginReponse = LoginResponse.fromJson(jsonDecode(response.body));
    return loginReponse;
  } else {
    throw Exception('Failed to login');
  }
}

Future<User> verifyMagicCode(String email, String code) async {
  final response = await http.post(
    Uri.parse('$apiUrl/api/v1/general/verify-magic-code'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, 'code': code}),
  );

  if (response.statusCode == 200) {
    final verifyMagicCodeResponse =
        User.fromJson(jsonDecode(response.body)['user']);
    return verifyMagicCodeResponse;
  } else {
    throw Exception('Failed to verify magic code');
  }
}

Future<CurrentPlanningTermResponse?> fetchCurrentPlanningTerm(
    String school) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return null;
  }

  final response = await http.get(
      Uri.parse('$apiUrl/api/v1/$school/general/currentPlanningTerm'),
      headers: {'MobileCode': user.magicCode});

  if (response.statusCode == 200) {
    return CurrentPlanningTermResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch user');
  }
}

Future<List<Term>?> fetchTerms(String school) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return null;
  }

  final response = await http.get(
      Uri.parse('$apiUrl/api/v1/$school/general/terms'),
      headers: {'MobileCode': user.magicCode});

  if (response.statusCode == 200) {
    final List<dynamic> terms = jsonDecode(response.body)['terms'] ?? [];
    return terms.map((term) => Term.fromJson(term)).toList();
  } else {
    throw Exception('Failed to fetch terms');
  }
}

Future<List<Course>> fetchCourses(
    {required String school,
    required Term term,
    String? searchQuery = '',
    List<String> listOfCourseIds = const []}) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return [];
  }

  List<Map<String, String>> filters = listOfCourseIds
      .map((courseId) => {
            "id": "code-course",
            "name": "_id",
            "inputType": "text",
            "group": "course",
            "type": "is",
            "value": courseId
          })
      .toList();

  String encodedBody = jsonEncode(
      <String, dynamic>{'condition': 'or', 'filters': filters.toList()});

  final response = await http.post(
      Uri.parse(
          '$apiUrl/api/v1/$school/courses-search/${term.year}/${term.semester}?searchQuery=$searchQuery%24filters&includeRelatedData=true'),
      body: encodedBody,
      headers: {
        'MobileCode': user.magicCode,
        'Content-Type': 'application/json; charset=UTF-8'
      });

  if (response.statusCode == 200) {
    final List<dynamic> courses =
        jsonDecode(response.body)['courses'].values.toList() ?? [];
    return courses.map((course) => Course.fromJson(course)).toList();
  } else {
    throw Exception('Failed to fetch courses');
  }
}

Future<List<FavouriteCourse>> fetchFavouriteCourses(String school) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return [];
  }

  final response = await http.get(
      Uri.parse('$apiUrl/api/v1/$school/sm/students/favourites?type=course'),
      headers: {'MobileCode': user.magicCode});

  if (response.statusCode == 200) {
    final List<dynamic> favouriteCourses = jsonDecode(response.body) ?? [];
    return favouriteCourses
        .map((favouriteCourse) => FavouriteCourse.fromJson(favouriteCourse))
        .toList();
  } else {
    throw Exception('Failed to fetch favourite courses');
  }
}

Future<List<FavouriteEvent>> fetchFavouriteEvents(String school) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return [];
  }

  final response = await http.get(
      Uri.parse('$apiUrl/api/v1/$school/sm/students/favourites?type=event'),
      headers: {'MobileCode': user.magicCode});

  if (response.statusCode == 200) {
    final List<dynamic> favouriteEvents = jsonDecode(response.body) ?? [];
    return favouriteEvents
        .map((favouriteEvent) => FavouriteEvent.fromJson(favouriteEvent))
        .toList();
  } else {
    throw Exception('Failed to fetch favourite events');
  }
}

Future<FavouriteCourse?> addCourseFavourite(String school,
    {required String courseId,
    required String sectionId,
    required String termId}) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return null;
  }

  var response = await http.post(
    Uri.parse('$apiUrl/api/v1/$school/sm/students/favourites'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'MobileCode': user.magicCode
    },
    body: jsonEncode(<String, dynamic>{
      'type': 'course',
      'entityInfo': {
        'courseId': courseId,
        'sectionId': sectionId,
        'termId': termId
      }
    }),
  );

  if (response.statusCode == 201) {
    return FavouriteCourse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add course favourite');
  }
}

Future<void> removeCourseFavourite(String school, String favouriteId) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return;
  }

  await http.delete(
    Uri.parse('$apiUrl/api/v1/$school/sm/students/favourites/$favouriteId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'MobileCode': user.magicCode
    },
  );
}

Future<FavouriteEvent?> addEventFavourite(String school, String eventId) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return null;
  }

  var response = await http.post(
    Uri.parse('$apiUrl/api/v1/$school/sm/students/favourites'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'MobileCode': user.magicCode
    },
    body: jsonEncode(<String, dynamic>{
      'type': 'event',
      'entityInfo': {'eventId': eventId}
    }),
  );

  if (response.statusCode == 201) {
    return FavouriteEvent.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add event favourite');
  }
}

Future<void> removeEventFavourite(String school, String favouriteId) async {
  User? user = GetStorage().read(userKey) != null
      ? User.fromJson(GetStorage().read(userKey))
      : null;

  if (user == null) {
    Get.offAllNamed('/login');
    return;
  }

  await http.delete(
    Uri.parse('$apiUrl/api/v1/$school/sm/students/favourites/$favouriteId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'MobileCode': user.magicCode
    },
  );
}
