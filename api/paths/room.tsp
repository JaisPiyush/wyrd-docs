import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
namespace WyrdAPI.RoomAPI;

@route("")
interface DatingRoomAPIView {
    @doc("search & filter dating rooms.")
    @get op list(
        @query("id") id?: string,
        @query("is_active") is_active?: boolean = true,
        @query("location") location?: string;
        @query("start_date") start_date?: plainDate,
        @query("visibility") visibility?: "public" | "private" = "public",
        @query("name") name?: string,
        @query("is_participant") is_participant?: boolean = false,
    ): CursorListResourcesResponse<ReadDatingRoom[]>;

    @doc("fetch detailed info about a particular dating room.")
    op read is ReadResourceById<int64, DetailReadDatingRoom>;

}

@route("/organizer/room")
interface DatingRoomOrganizer {
    @doc("fetch all the dating room created by the organizer.")
    op list is CursorListResources<ReadDatingRoom[]>;

    @doc("fetch a particular dating room with detailed information.")
    op read is ReadResourceById<int64, DetailReadDatingRoom>;

    @doc("create a dating room.")
    op create is CreateResource<CreateDatingRoom, DetailReadDatingRoom>;

    @doc("update dating room fields.")
    op update is UpdateResourceById<int64, UpdateDatingRoom, DetailReadDatingRoom>;

    @route("/{roomId}/stats/participants")
    @doc("fetch participants related stats of a dating room.")
    @get getParticipantsStats(
        @path roomId: string,
        @query("start_date") start_date: plainDate,
        @query("end_date") end_date: plainDate
    ): ListResourcesResponse<DatingRoomParticipantsStats>
}