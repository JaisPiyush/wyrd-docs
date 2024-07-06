import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

alias UnauthorizedUserError = {
    @statusCode statusCode: 401;
    @body error: {
        message: "User is not authorized. Try logging again.";
        code: 401; 
    };
};