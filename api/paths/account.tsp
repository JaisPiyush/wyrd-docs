import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.AccountAPI;

@route("/interest-tags")
op list is ListResources<ReadInterestTag[]>;

@route("/device/token")
@doc("set FCM device token for notification")
@post op set(@body data: SetDeviceCloudMessagingTokenModel): {
    @statusCode status: 201 | 401 | 400;
};


@route("/profile/text_prompt/")
interface DatingProfileTextPromptAPIView {
    op list is ListResources<ReadDatingProfileTextPrompt[]>;
    op create is CreateResource<CreateDatingProfileTextPrompt, ReadDatingProfileTextPrompt>;
    op read is ReadResourceById<int64, ReadDatingProfileTextPrompt>;
    op delete is DeleteResourceById<int64>;
}

@route("/profile/media/")
interface DatingProfileMediaAPIView {
    op list is ListResources<ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>[]>;
    op create is CreateResource<CreateDatingProfileContentMedia, ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>>;
    op read is ReadResourceById<int32, ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>>;
    op delete is DeleteResourceById<int32>;

}


@route("/profile")
interface DatingProfileAPIView {
    op list is ListResources<ReadDatingProfile>;
    @doc("Based on whether the requested profile is exposed or not, Exposed or UnExposed dating profile will be returned.")
    op read is ReadResourceById<string, UnExposedReadDatingProfile | ExposedReadDatingProfile>;
    op create is CreateResource<CreateDatingProfile, ReadDatingProfile>;
    op update is UpdateResource<UpdateDatingProfile, ReadDatingProfile>;
}

@route("/profile/dating_preferences")
interface DatingProfileDatingPreferencesAPIView {
    op list is ListResources<DatingPreferencesDatingProfile>;
    op update is UpdateResource<DatingPreferencesDatingProfile, DatingPreferencesDatingProfile>;
}
