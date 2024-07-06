import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.AccountAPI;


@route("/device")
@useAuth(BearerAuth)
interface DeviceCloudMessagingTokenAPIView {
    /**
     * Registers a new FCM token for the user. 
     * This token will be used to send push notifications to the user's device.
     * 
     */
    @post op set(@body token: SetDeviceCloudMessagingToken): {
        @body success: {
            success: boolean;
        };
        @statusCode statusCode: 201
    } | {
        @statusCode statusCode: 400
    } | UnauthorizedUserError;

    /**
     * 
     * Deletes the specified FCM token associated with the user. 
     * This stops the server from sending push notifications to 
     * the device associated with the deleted token.
     * 
     */
    @delete op delete is DeleteResourceById;

}