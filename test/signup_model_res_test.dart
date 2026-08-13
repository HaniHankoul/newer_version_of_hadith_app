import 'package:flutter_test/flutter_test.dart';
import 'package:hadith_app/app/features/auth/sign_up/data/models/signup_model_res.dart';

void main() {
  test('signup response handles nullable API fields without throwing', () {
    final json = {
      'accessToken': 'token',
      'refreshToken': 'refresh',
      'tokenType': 'Bearer',
      'expiresIn': 3600,
      'user': {
        'id': '1',
        'name': 'User',
        'email': 'user@example.com',
        'avatarUrl': null,
        'status': null,
        'gender': 'male',
        'type': 'user',
        'birthDate': '1990-01-01',
      },
    };

    final response = Signupmodelresponse.fromJson(json);

    expect(response.accessToken, 'token');
    expect(response.user.avatarUrl, isEmpty);
    expect(response.user.status, isEmpty);
    expect(response.user.gender, 'male');
  });
}
