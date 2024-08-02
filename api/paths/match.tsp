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
    op list is ListResources<ReadMatchingPool<"rp">>;
    op read is ReadResourceById<int64, ReadMatchingPool<"dr">>;
    
    @post op join(@body dating_room?: int64): WriteDetailResourceResponse<ReadMatchingPool>;
    @delete op leave(@body dating_room?: int64): {@statusCode code: 201} | ViewsetAuthorizedDetailViewAPIErrors;

    @route("/room/{roomId}")
    @get getMatchingProfiles(): ListResourcesResponse<ExposedReadDatingProfile[]>;
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
