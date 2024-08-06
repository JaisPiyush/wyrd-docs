import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.MatchAPI;

@route("/profile/status")
@doc("fetch current roster matching status of the user. It contains details like button enable status and matching quotas.")
op getProfileMatchingStatus is ListResources<ReadDatingProfileMatchingStatus>;



@route("/pool")
interface MatchingPoolAPIView {
    // @doc("Returns the find the matching pool instance data. Returns empty array if profile in not in matching pool.")
    // op list is ListResources<ReadMatchingPool<"rp">[]>;
    // @doc("Returns dating room matching pool instance. Throws 404 if profile is not present in the matching pool.")
    // op read is ReadResourceById<int64, ReadMatchingPool<"dr">>;
    
    @doc("join the matching pool. User can select matching pool of dating room, otherwise they will join common pool. It will return 400 on duplicate entry.")
    @post op join(@body body: {
        dating_room?: int64
    }): WriteDetailResourceResponse<ReadMatchingPool>;
    
    @doc("leave the matching pool.")
    @delete op leave(@body body: {
        dating_room?: int64
    }): {@statusCode code: 202} | ViewsetAuthorizedDetailViewAPIErrors;

    @route("/room/{roomId}")
    @doc("get all the matching profiles in a dating room.")
    @get getMatchingProfiles(@path roomId: string): CursorListResourcesResponse<ExposedReadDatingProfile[]>;
}

@route("/pair")
interface MatchingPairAPIView {
    @doc("fetch all the active pairs of the dating profile.")
    op list is CursorListResources<MatchingPair[]>;

    @route("/get-chat-token/")
    @doc("fetch chat token")
    @get op getChatToken(): {
        @body body: {
            token: string;
        };
        @statusCode code: 200;
    } | ViewsetAuthorizedDetailViewAPIErrors;
}

@route("/pair/{id}/activity/")
interface MatchingPairProfileAcitivityAPIView {
    @doc("perform actions like profile exposure, accepting/rejecting relationship.")
    @post op create(@path id: string, @body data: CreateMatchingPairProfileActivity): WriteDetailResourceResponse<ReadMatchingPairProfileActivity>
}
