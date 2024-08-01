import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.SuperUserAPI;

// @route("/interest-tag/")
// @useAuth(BearerAuth)
// interface InterestTagAPIView {
//     op list(): ReadableInterestTag[];
//     op read(@path pk: string): ReadableInterestTag | {@statusCode statusCode:404; };
//     op create(@body tag: CreateInterestTag): ReadableInterestTag;
//     @delete op delete(@path pk: string):void;
// }

// @route("/profile-questions")
// @useAuth(BearerAuth)
// interface DatingProfileQuestionareAPIView {
//     op list(): ReadDatingProfileQuestionare[];
//     op read(@path id: int32): ReadDatingProfileQuestionare | {
//         @statusCode code: 404 | 401;
//     };
//     op create(@body question: CreateDatingProfileQuestionare): ReadDatingProfileQuestionare | {
//         @statusCode code: 401 | 400;
//     };

//     @delete op delete(@path pK: int32): void;
// }
