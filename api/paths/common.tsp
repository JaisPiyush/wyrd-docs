import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.CommonAPI;

@route("/interest-tag/")
op listInterestTags(@query("tag") tag?: string, @query("category") category?: string): CursorListResourcesResponse<ReadInterestTag[]>;

@route("/assessment_question/")
op listAssessmentQuestion(@query("question") question?: string, @query("question_type") question_type?: AssessmentQuestionType): CursorListResourcesResponse<ReadAssessmentQuestion[]>;

@route("/text_prompt")
op listTextPrompt(@query("category") category?: TextPromptCategory): CursorListResourcesResponse<ReadTextPrompt[]>;