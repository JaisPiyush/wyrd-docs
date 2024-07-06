import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../errors.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.AccountAuthAPI;

model PhoneLoginBody {
    @doc("verifyIdToken provided by Firebase Phone Authentication. This token is used to retrieve the user's phone number.")
    token: string;
}

@route("/login/phone")
@post op login(@body data: PhoneLoginBody): {
    @body data: {
        token: string;
    };
    @statusCode statusCode: 201;
}| InvalidPhoneAuthenticationTokenError;