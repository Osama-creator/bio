// import 'package:dio/dio.dart';
// import 'package:queen/queen.dart';

// Object? extractError(dynamic data) {
//   if (data is Map) {
//     return data['error'];
//   }
//   return null;
// }

// void throwIfNot(int httpStatus, Response response) {
//   if (response.statusCode != httpStatus) {
//     throw extractError(response.data) ?? response.data as Object;
//   }
// }

// /// wrapper around dio to handlers api calls
// class HttpClient {
//   final Dio dio;

//   HttpClient(this.dio);

//   Response _validate(Response res) {
//     final badCodes = [
//       400,
//       401,
//       404,
//       422,
//       500,
//     ];
//     if (badCodes.contains(res.statusCode)) {
//       throw ApiError(
//         ((res.data as Map)['error'] as String?) ?? (res.data as Map).toString(),
//       );
//     }
//     return res;
//   }

//   /// sends a [GET] request to the given [url]
//   Future<Response> get(
//     String path, {
//     Map<String, dynamic> headers = const {},
//     Map<String, dynamic> query = const {},
//     bool attachToken = true,
//   }) async {
//     final res = await dio.get(
//       path,
//       queryParameters: query,
//       options: Options(
//         headers: {
//           'accept-lang': Lang.current.languageCode,
//           if (attachToken)
//             'authorization': 'Bearer ${Prefs.getString('token')}',
//           ...headers,
//         },
//       ),
//     );
//     return _validate(res);
//   }

//   Future<Response> post(
//     String path, {
//     Object body = const {},
//     Map<String, dynamic> headers = const {},
//     Map<String, dynamic> query = const {},
//     String? contentType,
//     bool attachToken = true,
//     ListFormat? listFormat,
//   }) async {
//     final res = await dio.post(
//       path,
//       data: body,
//       queryParameters: query,
//       options: Options(
//         listFormat: listFormat,
//         headers: {
//           'accept-lang': Lang.current.languageCode,
//           if (attachToken)
//             'authorization': 'Bearer ${Prefs.getString('token')}',
//           ...headers,
//         },
//         contentType: contentType,
//       ),
//     );
//     return _validate(res);
//   }

//   Future<Response> delete(
//     String path, {
//     Object body = const {},
//     Map<String, dynamic> headers = const {},
//     Map<String, dynamic> query = const {},
//     String? contentType,
//     bool attachToken = true,
//   }) async {
//     final res = await dio.delete(
//       path,
//       data: body,
//       queryParameters: query,
//       options: Options(
//         headers: {
//           'accept-lang': Lang.current.languageCode,
//           if (attachToken)
//             'authorization': 'Bearer ${Prefs.getString('token')}',
//           ...headers,
//         },
//         contentType: contentType,
//       ),
//     );
//     return _validate(res);
//   }

//   Future<Response> put(
//     String path, {
//     Object body = const {},
//     Map<String, dynamic> headers = const {},
//     Map<String, dynamic> query = const {},
//     String? contentType,
//     bool attachToken = true,
//   }) async {
//     final res = await dio.put(
//       path,
//       data: body,
//       queryParameters: query,
//       options: Options(
//         headers: {
//           'accept-lang': Lang.current.languageCode,
//           if (attachToken)
//             'authorization': 'Bearer ${Prefs.getString('token')}',
//           ...headers,
//         },
//         contentType: contentType,
//       ),
//     );
//     return _validate(res);
//   }
// }
