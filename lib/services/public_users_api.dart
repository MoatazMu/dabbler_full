import 'dart:convert';
import 'package:http/http.dart' as http;

class PublicUsersApi {
  static const String baseUrl =
      'https://ekmhrxdwgegxkdkdukgq.functions.supabase.co';

  static Future<String?> fetchDisplayNameById(String userId) async {
    final uri = Uri.parse('$baseUrl/public-users?id=$userId');
    final res = await http.get(uri);
    if (res.statusCode != 200) return null;

    final Map<String, dynamic> json = jsonDecode(res.body);
    final data = (json['data'] as List?) ?? [];
    if (data.isEmpty) return null;
    return data.first['display_name'] as String?;
  }
}
