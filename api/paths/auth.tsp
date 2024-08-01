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

@route("/login/phone/")
@post op login(@body data: PhoneLoginBody): {
    @body data: {
        access: string;
        refresh: string;
    };
    @statusCode statusCode: 201;
}| InvalidPhoneAuthenticationTokenError | NotFoundResponse;


@route("/token/refresh/")
@useAuth(BearerAuth)
@post op refresh(
    @body data: {
        refresh: string
    }
) : WriteSuccessfullResponse<{token: string}> | BadRequestResponse;

@route("/logout")
@useAuth(BearerAuth)
@doc("logout user in backend and remove device token")
@delete op logout(): {
    @statusCode status: 201 | 400;
};