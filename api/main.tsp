import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

import "./paths";



using TypeSpec.Http;
using TypeSpec.Rest;

@service({
  title: "Wyrd Internal API",
})
@server("https://example.com", "Single server endpoint")
namespace WyrdAPI {
  @route("/account/auth")
  namespace AccountAuthAPI {}

  @route("/account")
  namespace AccountAPI {}

  @route("/superuser")
  namespace SuperUserAPI {
    @route("/interest-tag/")
    @useAuth(BearerAuth)
    interface InterestTagAPIView {
        op list(): ReadableInterestTag[];
        op read(@path pk: string): ReadableInterestTag | {@statusCode statusCode:404; };
        op create(@body tag: CreateInterestTag): ReadableInterestTag;
        @delete op delete(@path pk: string):void;
    }
  }

  @route("/match")
  @useAuth(BearerAuth)
  namespace MatchAPI {}
}