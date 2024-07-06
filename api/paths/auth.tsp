import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";


using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI;

model PhoneLoginBody {
    phone_number: string;
    token: string;
}

@route("/account/auth/login/phone")
@post op login(@body data: PhoneLoginBody): {
    @body data: {
        token: string;
    }
};