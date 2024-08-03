import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.SuperUserAPI;

@route("/interest-tag/")
interface InterestTagAPIView {
    op list(@query("tag") tag?: string, @query("category") category?: string): CursorListResourcesResponse<ReadInterestTag[]>;
    op read is ReadResourceById<string, ReadInterestTag>;
    op create is CreateResource<CreateInterestTag, ReadInterestTag>;
    op update is UpdateResourceById<string, UpdateInterestTag, ReadInterestTag>;
    op delete is DeleteResourceById<string>;
}

@route("/dating_room/organizer/")
interface DatingRoomOrganizerAPIView {
    op list is CursorListResources<ReadDatingRoomOrganizer[]>;
    op read is ReadResourceById<string, ReadDatingRoomOrganizer>;
    op create is CreateResource<CreateDatingRoomOrganizer, ReadDatingRoomOrganizer>;
    op delete is DeleteResourceById<string>;
}

@route("/assessment_question/")
interface AssessmentQuestionAPIView {
    op list(@query("question") question?: string, @query("question_type") question_type?: AssessmentQuestionType): CursorListResourcesResponse<ReadAssessmentQuestion[]>;
    op create is CreateResource<CreateAssessmentQuestion, ReadAssessmentQuestion>;
    op read is ReadResourceById<int32, ReadAssessmentQuestion>;
    op delete is DeleteResourceById<int32>;
}


@route("/text_prompt/")
interface TextPromptAPIView {
    op list(@query("category") category?: TextPromptCategory): CursorListResourcesResponse<ReadTextPrompt[]>;
    op create is CreateResource<CreateTextPrompt, ReadTextPrompt>;
    op read is ReadResourceById<int32, ReadTextPrompt>;
    op delete is DeleteResourceById<int32>;
}