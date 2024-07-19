import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.AccountAPI;

@withVisibility("create", "update")
model SetDeviceCloudMessagingToken {
    ...DeviceCloudMessagingToken
}

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

@route("/user/me/")
@useAuth(BearerAuth)
@get op me(): {
    @statusCode statusCode: 200;
    @body data: User
} | {
    @statusCode statusCode: 400 | 401;
};



@route("/")
@useAuth(BearerAuth)
interface DatingAccountAPIView {
    @doc("Fetch user's account detail.")
    op list(): {
        @body data: ReadableDatingAccount;
        @statusCode statusCode: 200;
    } | {@statusCode statusCode: 404 | 401;};

    op read(@path pk: string): {
        @body data: ReadableDatingAccount;
        @statusCode statusCode: 200;
    };

    op create(@body data: CreateDatingAccount) : {
        @body data: ReadableDatingAccount;
        @statusCode statusCode: 201;
    } | {@statusCode statusCode: 400 | 401;};
}

