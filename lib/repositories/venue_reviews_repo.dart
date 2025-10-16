// GENERATED repository stubs for table: venue_reviews
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/venue_reviews.dart';

class VenueReviewsRepo {
  final SupabaseClient _db;
  VenueReviewsRepo(this._db);

  Future<List<VenueReviews>> list({int limit = 50, int offset = 0}) async {
    final res = await _db
        .from('venue_reviews')
        .select('*')
        .range(offset, offset + limit - 1)
        .order('created_at', ascending: false);
    final list = (res as List).cast<Map<String, dynamic>>();
    return list.map(VenueReviews.fromJson).toList();
  }

  Future<VenueReviews?> getById(dynamic id) async {
    final res = await _db
        .from('venue_reviews')
        .select('*')
        .eq('id', id)
        .maybeSingle();
    if (res == null) return null;
    return VenueReviews.fromJson(res);
  }

  // TODO: add create/update/delete with correct columns & RLS rules
}
