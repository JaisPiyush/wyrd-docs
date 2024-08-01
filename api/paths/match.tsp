import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "../models";
import "../errors.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace WyrdAPI.MatchAPI;




// @route("/match/status")
// @useAuth(BearerAuth)
// @get op getProfileMatchStatus(): {
//     @body data: AccountMatchingStatus;
//     @statusCode status: 200;
// } | {
//     @statusCode status: 401 | 400;
// };

// @route("/rooms")
// @useAuth(BearerAuth)
// interface UserDatingRoomAPIView {
//     @get op list(@query params: DatingRoomQueryParam): {
//         @statusCode status: 200;
//         @body rooms: ReadDatingRoom[];
//     } | {
//         @statusCode status: 401 | 400;
//     };

//     @get op read(@path id: string): {
//         @body room: ReadDatingRoom;
//         @statusCode status: 200
//     } | {
//         @statusCode status: 400 | 401 | 404;
//     };

//     @post op join(@path id: string, @body body: {
//         code: string;
//     }): {
//         @statusCode status: 201 | 400 | 401 | 404;
//     };

//     @delete op leave(@path id: string): {
//         @statusCode status: 200 | 400 | 401 | 404;
//     };
// }

// @route("/org/rooms")
// @useAuth(BearerAuth)
// interface OrganizersDatingRoomAPIView {
//     @get op list(): {
//         @body data: ReadDatingRoom[];
//         @statusCode status: 200;
//     } | {
//         @statusCode status: 400 | 401;
//     };

//     @get op read(@path id: string): {
//         @body room: ReadDatingRoom;
//         @statusCode status: 200
//     } | {
//         @statusCode status: 400 | 401 | 404;
//     };

//     @post op create(@body room: CreateDatingRoom): {
//         @body room: ReadDatingRoom;
//         @statusCode status: 201;
//     } | {
//         @statusCode status: 400 | 401;
//     };

//     @put op update(@body room: UpdateDatingRoom): {
//         @body room: ReadDatingRoom;
//         @statusCode status: 201;
//     } | {
//         @statusCode status: 400 | 401;
//     };

//     @delete op delete(@path id: string): {
//         @statusCode status: 200 | 400 | 401;
//     };

// }

// @route("/pair")
// @useAuth(BearerAuth)
// interface UserMatchingPairAPIView {
//     @get op list(): {
//         @body data: ReadMatchingPair[];
//         @statusCode status: 200;
//     } | {
//         @statusCode status: 400 | 401;
//     };

//     @get op read(@path id: string): {
//         @body data: ReadMatchingPair;
//         @statusCode status: 200;
//     } | {
//         @statusCode status: 400 | 401 | 404;
//     };

//     /**
//      * - ExposeProfile: expose the profile of user.
//      * - AcceptRelationship: 
//      *      1. Set `is_frozen` to true.
//      *      2. If other account has already created this activity, then convert the pair to relationship.
//      * - RejectRelationship: Remove the matching pair. It's an option appearing only after pair is frozen.
//      * - LeaveChat: Remove the matching pair.
//      */
//     @post
//     op action(@path id: string, @body data: CreateMatchingPairProfileActivity): {
//         @body data: ReadMatchingPair | null;
//         @statusCode code: 201;
//     } | {
//         @statusCode code: 400 | 401 | 404;
//     };
// }

// @route("/pair/{pairId}/activity")
// @useAuth(BearerAuth)
// interface UserMatchingPairProfileActivityAPIView {
//     @get op list(@path pairId: string, @query("activity") activity?: MatchingPairProfileActivityType, @query("profile") profile: string): {
//         @statusCode status: 200;
//         @body data: ReadMatchingPairProfileActivity[];
//     } | {
//         @statusCode code: 400 | 401 | 404;
//     };

    

// }