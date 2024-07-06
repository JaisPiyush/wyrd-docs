import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI;

@route("/account/device")
@useAuth(BearerAuth)
interface DeviceCloudMessagingTokenAPIView {
    @post op set(@body token: WyrdModels.SetDeviceCloudMessagingToken): {
        @body success: boolean;
        @statusCode statusCode: 201
    } | {
        @statusCode statusCode: 400
    } | UnauthorizedUserError;


}