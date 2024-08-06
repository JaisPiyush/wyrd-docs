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
// @doc("fetch all interest tags.")
// op list is ListResources<ReadInterestTag[]>;

@route("/profile/interest-tags")
@doc("fech all interest tags selected by the user")
op read is ReadResourceById<int32, ReadInterestTag[]>;

@route("/device/token")
@doc("set FCM device token for notification")
@post op set(@body data: SetDeviceCloudMessagingTokenModel): {
    @statusCode status: 201 | 401 | 400;
};


@route("/profile/text_prompt/")
interface DatingProfileTextPromptAPIView {
    @doc("fetch all text prompts")
    op list is CursorListResources<ReadTextPrompt[]>;

    @doc("create a dating profile text prompt by user with answer.")
    op create is CreateResource<CreateDatingProfileTextPrompt, ReadDatingProfileTextPrompt>;

    @doc("fetch all the dating profile text prompts.")
    op read is ReadResourceById<string, ReadDatingProfileTextPrompt[]>;

    @doc("update answer of the text prompt.")
    op update is UpdateResourceById<int64, UpdateDatingProfileTextPrompt, ReadDatingProfileTextPrompt>;

    @doc("remove a text prompt.")
    op delete is DeleteResourceById<int64>;
}

@route("/profile/media/")
interface DatingProfileMediaAPIView {
    @doc("fetch all the medias of dating profile")
    op list is ListResources<ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>[]>;
    
    @doc("add a new media to dating profile. Image & video combined will be 6 media and 3 audio media is allowed.")
    op create is CreateResource<CreateDatingProfileContentMedia, ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>>;
    
    // @doc("position of the media can be changed. Only for images & video.")
    // op read is ReadResourceById<int32, ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>>;
    
    @doc("change positions of media. only for images & videos and only image can occupy index position 0.")
    @patch op updatePositions(
        @body body: UpdateMediaPositions
    ): WriteResourceResponse<ReadDatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>[]>;
    
    @doc("remove a media. Min 1 image is required.")
    op delete is DeleteResourceById<int32>;

}

@route("/profile/assessment-question/")
interface DatingProfileAssessmentQuestionAPIView {
    @doc("fetch all assessment questions answered byt the user.")
    @get op list(): CursorListResourcesResponse<ReadDatingProfileAssessmentQuestion[]>;

    
    @doc("answer assessment question")
    op create is CreateResource<CreateDatingProfileAssessmentQuestion, ReadDatingProfileAssessmentQuestion>;

    @doc("update answer of already answered question.")
    op update is UpdateResourceById<int64, UpdateDatingProfileAssessmentQuestion, ReadDatingProfileAssessmentQuestion>;
}


@route("/profile")
interface DatingProfileAPIView {
    @doc("fetching the dating profile of the user.")
    op list is ListResources<ReadDatingProfile>;

    /**
     * 
     * Fetch the dating profile of another user.
     * Based on whether the requested profile is exposed or not, Exposed or UnExposed dating profile will be returned.
     * 
     */
    op read is ReadResourceById<string, UnExposedReadDatingProfile | ExposedReadDatingProfile>;

    @doc("create the dating profile")
    op create is CreateResource<CreateDatingProfile, ReadDatingProfile>;

    @doc("update the dating profile.")
    op update is UpdateResource<UpdateDatingProfile, ReadDatingProfile>;
}

@route("/profile/dating_preferences")
interface DatingProfileDatingPreferencesAPIView {
    @doc("fetch the dating preferences of the dating profile.")
    op list is ListResources<DatingPreferencesDatingProfile>;

    @doc("update the dating preferences of the dating profile")
    op update is UpdateResource<DatingPreferencesDatingProfile, DatingPreferencesDatingProfile>;
}


@route("/profile/blocklist")
interface BlockListAPIView{
    @doc("fetch all blocked profile ")
    op list is CursorListResources<ReadBlockList[]>;

    @doc("block all the profiles.")
    op create is CreateResource<CreateBlockList[], ReadBlockList[]>;

    @doc("unblock the profiles")
    @delete delete(@body body: CreateBlockList[]): {@statusCode code: 202;} | ViewsetAuthorizedDetailViewAPIErrors;

}