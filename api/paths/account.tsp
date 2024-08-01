import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.AccountAPI;

// @route("/interest-tags")
// @useAuth(BearerAuth)
// @get op list(): {
//     @body tags: ReadableInterestTag[];
//     @statusCode statusCode: 200;
// } | {
//     @statusCode statusCode: 401 | 500;
// };

// @route("/device/token")
// @doc("set FCM device token for notification")
// @useAuth(BearerAuth)
// @post op set(@body data: SetDeviceCloudMessagingTokenModel): {
//     @statusCode status: 201 | 401 | 400;
// };


// @route("/me")
// @useAuth(BearerAuth)
// @get op read(): {
//     @body user: User;
//     @statusCode status: 200;
// } | {@statusCode status: 401 | 400;};

// @route("/dating/profile")
// @useAuth(BearerAuth)
// interface DatingProfileAPI {
//     @post op create(@body profile: CreateDatingProfile): {
//         @body profile: ReadableDatingProfile;
//         @statusCode status: 201;
//     } | {
//         @statusCode status: 401 | 400;
//     };

//     @get op read(): ReadableDatingProfile;

//     @put op update(@body data: UpdateDatingProfileModel | SetDatingPreferencesModel): {
//         @statusCode status: 201;
//         @body profile: ReadableDatingProfile;
//     } | {
//         @statusCode status: 401 | 400;
//     };

// }