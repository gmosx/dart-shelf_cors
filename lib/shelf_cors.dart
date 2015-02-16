library shelf.middleware.cors;

import 'package:shelf/shelf.dart';

/// Creates middleware which adds [CORS headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)
/// to shelf responses. Also handles preflight (OPTIONS) requests.
Middleware addCorsHeaders({Map<String, String> corsHeaders}) {
  if (corsHeaders == null) {
    // By default allow access from everywhere.
    corsHeaders = {'Access-Control-Allow-Origin': '*'};
  }

  // Handle preflight (OPTIONS) requests by just adding headers and an empty
  // response.
  Response handleOptionsRequest(Request request) {
    if (request.method == 'OPTIONS') {
      return new Response.ok(null, headers: corsHeaders);
    } else {
      return null;
    }
  }

  Response addCorsHeaders(Response response) => response.change(headers: corsHeaders);

  return createMiddleware(requestHandler: handleOptionsRequest, responseHandler: addCorsHeaders);
}