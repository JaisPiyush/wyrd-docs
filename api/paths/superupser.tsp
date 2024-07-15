import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.SuperUserAPI;

@route("/interest-tag/")
@useAuth(BearerAuth)
interface InterestTagAPIView {
    op list(): ReadableInterestTag[];
    op read(@path pk: string): ReadableInterestTag | {@statusCode statusCode:404; };
    op create(@body tag: CreateInterestTag): ReadableInterestTag;
    @delete op delete(@path pk: string):void;
}