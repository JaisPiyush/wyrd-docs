import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.DatingRoomOrganizer;

@route("")
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