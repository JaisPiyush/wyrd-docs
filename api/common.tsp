import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

// import "../errors.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

op DeleteResourceById(@path pk: string): {
    @statusCode statusCode: 200 | 404 | 401 | 400;
};