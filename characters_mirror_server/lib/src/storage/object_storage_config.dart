import 'dart:io';

final class ObjectStorageConfig {
  const ObjectStorageConfig({
    required this.host,
    required this.bucket,
    required this.accessKey,
    required this.secretKey,
    required this.useSsl,
    this.port,
    this.region,
    this.pathStyle,
  });

  final String host;
  final int? port;

  final String bucket;
  final String accessKey;
  final String secretKey;

  final bool useSsl;
  final String? region;
  final bool? pathStyle;

  factory ObjectStorageConfig.fromEnvironment({
    Map<String, String>? environment,
  }) {
    final env = environment ?? Platform.environment;

    final rawEndpoint = _required(env, 'S3_ENDPOINT');
    final explicitUseSsl = _optionalBool(env, 'S3_USE_SSL');

    final endpoint = _parseEndpoint(
      rawEndpoint,
      defaultUseSsl: explicitUseSsl ?? true,
    );

    final endpointUseSsl = switch (endpoint.scheme) {
      'https' => true,
      'http' => false,
      _ => throw StateError(
          'Unsupported S3 endpoint scheme: ${endpoint.scheme}',
        ),
    };

    if (explicitUseSsl != null && explicitUseSsl != endpointUseSsl) {
      throw StateError(
        'S3_USE_SSL conflicts with the scheme in S3_ENDPOINT.',
      );
    }

    return ObjectStorageConfig(
      host: endpoint.host,
      port: endpoint.hasPort ? endpoint.port : null,
      bucket: _required(env, 'S3_BUCKET'),
      accessKey: _required(env, 'S3_ACCESS_KEY'),
      secretKey: _required(env, 'S3_SECRET_KEY'),
      useSsl: endpointUseSsl,
      region: _optional(env, 'S3_REGION'),
      pathStyle: _optionalBool(env, 'S3_PATH_STYLE'),
    );
  }

  static Uri _parseEndpoint(
    String value, {
    required bool defaultUseSsl,
  }) {
    final normalized = value.contains('://')
        ? value
        : '${defaultUseSsl ? 'https' : 'http'}://$value';

    final uri = Uri.tryParse(normalized);

    if (uri == null || uri.host.isEmpty) {
      throw StateError(
        'S3_ENDPOINT is not a valid endpoint: $value',
      );
    }

    if (uri.path.isNotEmpty && uri.path != '/') {
      throw StateError(
        'S3_ENDPOINT must not contain a path: $value',
      );
    }

    if (uri.hasQuery || uri.hasFragment) {
      throw StateError(
        'S3_ENDPOINT must not contain query parameters or a fragment.',
      );
    }

    return uri;
  }

  static String _required(
    Map<String, String> environment,
    String name,
  ) {
    final value = environment[name]?.trim();

    if (value == null || value.isEmpty) {
      throw StateError(
        'Required environment variable $name is not set.',
      );
    }

    return value;
  }

  static String? _optional(
    Map<String, String> environment,
    String name,
  ) {
    final value = environment[name]?.trim();

    if (value == null || value.isEmpty) {
      return null;
    }

    return value;
  }

  static bool? _optionalBool(
    Map<String, String> environment,
    String name,
  ) {
    final value = _optional(environment, name);

    if (value == null) {
      return null;
    }

    return switch (value.toLowerCase()) {
      'true' || '1' || 'yes' => true,
      'false' || '0' || 'no' => false,
      _ => throw StateError(
          '$name must be true or false, got: $value',
        ),
    };
  }
}
