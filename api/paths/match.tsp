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
op getProfileMatchingStatus is ListResources<ReadDatingProfileMatchingStatus>;

@route("/dating_room")
interface DatingRoomAPIView {
    @get op list(
        @query("id") id?: string,
        @query("is_active") is_active?: boolean = true,
        @query("location") location?: string;
        @query("start_date") start_date?: plainDate,
        @query("visibility") visibility?: "public" | "private" = "public",
        @query("name") name?: string,
        @query("is_participant") is_participant?: boolean = false,
    ): ListResourcesResponse<ReadDatingRoom[]>;
    op read is ReadResourceById<string, DetailReadDatingRoom>;

}

@route("/pool")
interface MatchingPoolAPIView {
    // @doc("Returns the find the matching pool instance data. Returns empty array if profile in not in matching pool.")
    // op list is ListResources<ReadMatchingPool<"rp">[]>;
    // @doc("Returns dating room matching pool instance. Throws 404 if profile is not present in the matching pool.")
    // op read is ReadResourceById<int64, ReadMatchingPool<"dr">>;
    
    @doc("join the matching pool. User can select matching pool of dating room, otherwise they will join common pool. It will return 400 on duplicate entry.")
    @post op join(@body dating_room?: int64): WriteDetailResourceResponse<ReadMatchingPool>;
    
    @doc("leave the matching pool.")
    @delete op leave(@body dating_room?: int64): {@statusCode code: 201} | ViewsetAuthorizedDetailViewAPIErrors;

    @route("/room/{roomId}")
    @doc("get all the matching profiles in a dating room.")
    @get getMatchingProfiles(@path roomId: string): ListResourcesResponse<ExposedReadDatingProfile[]>;
}

@route("/pair")
interface MatchingPairAPIView {
    op list is ListResources<MatchingPair[]>;

    @route("/get-chat-token/")
    @get op getChatToken(): {
        @body body: {
            token: string;
        };
        @statusCode code: 200;
    } | ViewsetAuthorizedDetailViewAPIErrors;
}

@route("/pair/{id}/activity/")
interface MatchingPairProfileAcitivityAPIView {
    @post op create(@path id: string, @body data: CreateMatchingPairProfileActivity): WriteDetailResourceResponse<ReadMatchingPairProfileActivity>
}
