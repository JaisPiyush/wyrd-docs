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
  @useAuth(BearerAuth)
  namespace AccountAPI {}

  @route("/superuser")
  @useAuth(BearerAuth)
  namespace SuperUserAPI {
    
  }

  @route("/match")
  @useAuth(BearerAuth)
  namespace MatchAPI {}

  @route("/match/room/organizer")
  @useAuth(BearerAuth)
  namespace DatingRoomOrganizer {}
}