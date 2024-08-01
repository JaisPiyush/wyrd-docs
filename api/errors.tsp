import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

alias UnauthorizedUserError = {
    @statusCode statusCode: 401;
    @body error: {
        detail: "User is not authorized. Try logging again.";
    };
};


alias InvalidPhoneAuthenticationTokenError = {
        @statusCode code: 400;
        @body error: {
            detail: "verifyIdToken is invalid."
    };  
};

// alias ResourceNotFoundError<M extends valueof string | void > = {
//     @statusCode code: 404;
//     @body error: {
//         detail: typeof M
//     }
// };

