import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Options for our cache
final cacheOptionsProvider = Provider<CacheOptions>((ref) {
  return CacheOptions(
    // A default store is required for interceptor.
    // MemCacheStore is an in-memory store.
    // For more robust caching, you could use a HiveCacheStore from dio_cache_interceptor_hive_store.
    store: MemCacheStore(),

    // The policy for caching responses.
    // Cache for 1 hour, and force refresh if the request is older than 7 days.
    policy: CachePolicy.forceCache,
    
    // Default max-age of cache entries.
    maxStale: const Duration(hours: 1),

    // We prioritize high-performance and stale data is acceptable in this app.
    priority: CachePriority.high,
  );
});

// Provider for the cache interceptor itself
final dioCacheInterceptorProvider = Provider<DioCacheInterceptor>((ref) {
  final cacheOptions = ref.watch(cacheOptionsProvider);
  return DioCacheInterceptor(options: cacheOptions);
});