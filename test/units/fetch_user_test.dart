import 'package:flutter_boilerplate/models/user_model.dart';
import 'package:flutter_boilerplate/services/apis/sample.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../mocks/http_client.mocks.dart';

void main() {
  group('fetchUser', () {
    test('returns an User if the http call completes successfully', () async {
      final client = MockClient();

      when(
        client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
        ),
      ).thenAnswer(
        (_) async => http.Response('{"id": "a", "name": "Jay"}', 200),
      );

      expect(await fetchUser(client), isA<UserModel>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(
        client.get(
          Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(fetchUser(client), throwsException);
    });
  });
}
