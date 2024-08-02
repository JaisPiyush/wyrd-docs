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
    op list is ListResources<ReadDatingRoom>;
    op read is ReadResourceById<int64, DetailReadDatingRoom>;
    op create is CreateResource<CreateDatingRoom, DetailReadDatingRoom>;
    op update is UpdateResourceById<int64, UpdateDatingRoom, DetailReadDatingRoom>;

    @route("/{roomId}/stats/participants")
    @get getParticipantsStats(
        @path roomId: string,
        @query("start_date") start_date: plainDate,
        @query("end_date") end_date: plainDate
    ): ListResourcesResponse<DatingRoomParticipantsStats>
}