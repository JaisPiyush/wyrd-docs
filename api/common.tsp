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

model UpdateWriteSuccessfulResponse<T> {
    @statusCode code: 202;
    @body body: T
}

model ReadResponse<T> {
    @statusCode code: 200;
    @body body: T;
};

model CursorReadResponse<T> {
    @statusCode code: 200;
    @body body: {
        next: string | null = null;
        previous: string | null = null;
        results: T
    }
}

alias ViewsetAuthorizedViewAPIErrors = UnauthorizedResponse | BadRequestResponse;
alias ViewsetAuthorizedDetailViewAPIErrors = ViewsetAuthorizedViewAPIErrors | NotFoundResponse;

alias ListResourcesResponse<T> = ReadResponse<T> | ViewsetAuthorizedViewAPIErrors;
alias CursorListResourcesResponse<T> = CursorReadResponse<T> | ViewsetAuthorizedViewAPIErrors;
alias WriteResourceResponse<T> = WriteSuccessfullResponse<T> | ViewsetAuthorizedViewAPIErrors;
alias WriteDetailResourceResponse<T> = WriteSuccessfullResponse<T> | ViewsetAuthorizedDetailViewAPIErrors;
alias UpdateResourceResponse<T> = UpdateWriteSuccessfulResponse<T> | ViewsetAuthorizedDetailViewAPIErrors;

@delete op DeleteResourceById<P extends string | integer, T = void>(@path id: P): {@statusCode code: 202;} | ViewsetAuthorizedDetailViewAPIErrors;

@get op ReadResourceById<P extends string | integer, T>(@path id: P): ReadResponse<T> | ViewsetAuthorizedDetailViewAPIErrors;
@get op ListResources<T>(): ListResourcesResponse<T>;

@get op CursorListResources<T>(): CursorListResourcesResponse<T>;

@post op CreateResource<C, R>(@body body: C): WriteSuccessfullResponse<R> | ViewsetAuthorizedViewAPIErrors;
@patch op UpdateResourceById<P extends string | integer, C, R>(@path id: P, @body body: C): UpdateResourceResponse<R>;

@patch op UpdateResource<C,R>(@body body: C): UpdateResourceResponse<R>;