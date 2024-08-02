import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

// import "../errors.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

model WriteSuccessfullResponse<T> {
    @statusCode code: 201;
    @body body: T;
};

model ReadResponse<T> {
    @statusCode code: 200;
    @body body: T;
};

alias ViewsetAuthorizedViewAPIErrors = UnauthorizedResponse | BadRequestResponse;
alias ViewsetAuthorizedDetailViewAPIErrors = ViewsetAuthorizedViewAPIErrors | NotFoundResponse;

alias ListResourcesResponse<T> = ReadResponse<T> | ViewsetAuthorizedViewAPIErrors;

@delete op DeleteResourceById<P extends string | integer, T = void>(@path pk: P): {@statusCode code: 201;} | ViewsetAuthorizedDetailViewAPIErrors;

@get op ReadResourceById<P extends string | integer, T>(@path pk: P): ReadResponse<T> | ViewsetAuthorizedDetailViewAPIErrors;
@get op ListResources<T>(): ReadResponse<T> | ViewsetAuthorizedViewAPIErrors;

@post op CreateResource<C, R>(@body body: C): WriteSuccessfullResponse<R> | ViewsetAuthorizedViewAPIErrors;
@patch op UpdateResourceById<P extends string | integer, C, R>(@path pk: P, @body body: C): WriteSuccessfullResponse<R> | ViewsetAuthorizedDetailViewAPIErrors;

@patch op UpdateResource<C,R>(@body body: C): WriteSuccessfullResponse<R> | ViewsetAuthorizedDetailViewAPIErrors;