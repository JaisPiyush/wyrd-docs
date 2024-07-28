import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.MatchAPI;


@route("/match/status")
@useAuth(BearerAuth)
@get op getProfileMatchStatus(): {
    @body data: AccountMatchingStatus;
    @statusCode status: 200;
} | {
    @statusCode status: 401 | 400;
};