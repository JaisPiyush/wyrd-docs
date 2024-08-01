

model User {
    // Phone number
    username: string;
    email?: string;
}


/**
 * The DeviceCloudMessagingToken model stores the Firebase Cloud Messaging (FCM) 
 * device tokens of logged-in users. These tokens are essential for sending push 
 * notifications to the users' devices.
 * 
 */
model DeviceCloudMessagingToken {
    @visibility("read")
    @doc("This field establishes a relationship with the User model, indicating which user the device token belongs to.")
    user: string;

    @visibility("read", "create", "update")
    @doc("This field stores the unique device token provided by FCM. It is used to identify the device to which notifications should be sent. This field is the primary key for this model, ensuring each token is unique.")
    @key token: string;
    
    @doc("This field automatically records the timestamp when the token record is created.")
    @visibility("read")
    created_at: utcDateTime;

    @doc("This field automatically records the timestamp whenever the token record is updated.")
    @visibility("read")
    updated_at: utcDateTime;

}

@withVisibility("create")
model SetDeviceCloudMessagingTokenModel {
    ...DeviceCloudMessagingToken
}


model DatingRoomOrganizer {
    @visibility("read")
    user: User;


}


model InterestTag {
    @visibility("read", "create")
    tag: string;

    @visibility("read", "create", "update")
    icon: string;

    @visibility("read", "create", "update")
    category: string;

    embedding: float32[];
}

model DatingProfileAssessmentQuestion {}


enum MediaContentType {
    Image: "image",
    Video: "video",
    Audio: "audio"
}

/**
 * 
 */
model DatingProfileContentMedia<T extends MediaContentType> {
    @visibility("read", "create", "update")
    content_type: T;

    @visibility("read", "create", "update")
    url: string;

    @visibility("read", "create", "update")
    caption?: string;

    @visibility("read", "create", "update")
    is_profile_picture: boolean = false;

    @visibility("read", "update")
    position: int8;

    @visibility("read")
    created_at?: utcDateTime;

    @visibility("read")
    updated_at?: utcDateTime;
}

model DatingProfileTextPrompt {}

enum SubGendersInMale {
    Man: "man",
    Demimale: "demimale",   
    IntersexMan: "intersex-man",
    TransMan: "trans-man",
    Transmasculine: "trans-masculine"
}

enum SubGendersInFemale {
    Woman: "woman",
    Demifemale: "demifemale",
    IntersexWoman: "intersex-woman",
    TransWoman: "trans-woman",
    Transfemine: "trans-femine"
}

enum SubGendersInNonBinary {
    NonBinary: "non-binary",
    Agender: "agender",
    Bigender: "bigender",
    GenderNonConforming: "gender-non-conforming",
    GenderVariant: "gender-variant",
    Intersex: "intersex",
    Neutrols: "neutrols",
    Pangender: "pangender",
    Polygender: "polygender",
    Transgender: "transgender",
    TwoSpirit: "two-spirit",
    GenderFluid: "gender-fluid",
    GenderQuestioning: "gender-questioning",
    Genderqueer: "genderqueer",

}

enum Gender {
    Man: "man",
    Women: "women",
    Non_Binary: "non-binary"
}

enum DatingIntention {
    LongTerm: "lt",
    ShortTerm: "st",
    Casual: "cs",
    LongTermOpenToShort: "ltst",
    ShortTermOpenToLong: "stlt",
}


model DatingProfile {
    @visibility("read")
    user: User;

    @visibility("read", "create", "update")
    name: string;

    @visibility("read", "create", "update", "dating_dim")
    dob: plainDate;

    @visibility("read", "create", "update", "dating_dim")
    gender: Gender;

    @visibility("read", "create", "update")
    subgender?: SubGendersInFemale | SubGendersInNonBinary | SubGendersInMale;

    @visibility("read", "update")
    show_subgender_on_profile: boolean = false;

    @visibility("read", "create", "update", "dating_pref")
    interested_genders: Gender[];

    @visibility("read", "create", "update", "dating_pref")
    dating_intention: DatingIntention;

    @visibility("read", "create", "update", "dating_pref")
    @maxItems(8)
    @minItems(5)
    interest_tags: InterestTag[];

    @visibility("read")
    @minItems(1)
    @maxItems(6)
    medias: DatingProfileContentMedia<MediaContentType.Image | MediaContentType.Video>[];

    @visibility("read")
    @maxItems(2)
    audios: DatingProfileContentMedia<MediaContentType.Audio>[];


}





// /**
//  * The InterestTags model stores interest tags and their associated vector embeddings. 
//  * These tags represent various interests that users can select, 
//  * and the vector embeddings are used to find people with similar interests.
//  * 
//  */
// model InterestTag {
//     /**
//      * The primary key for the model, representing the interest tag.
//      */
//     @visibility("admin-read", "admin-create", "read")
//     @maxLength(50)
//     @key tag: string;
//     /**
//      * A URL pointing to an icon that visually represents the interest tag.
//      */
//     @visibility("admin-read", "admin-create", "admin-update", "read")
//     icon?: string | null = null;

//     /**
//      * A vector embedding representing the interest tag, used for similarity searches.
//      */
//     @visibility("hidden")
//     @maxItems(768)
//     embedding: float[]
// }


// @withVisibility("admin-create")
// model CreateInterestTag {
//     ...InterestTag
// }

// @withVisibility("admin-read")
// model ReadableInterestTag {
//     ...InterestTag
// }

// @withVisibility("admin-update")
// model UpdateableInterestTag {
//     ...InterestTag
// }


// enum SubGendersInMale {
//     Man: "man",
//     Demimale: "demimale",   
//     IntersexMan: "intersex-man",
//     TransMan: "trans-man",
//     Transmasculine: "trans-masculine"
// }

// enum SubGendersInFemale {
//     Woman: "woman",
//     Demifemale: "demifemale",
//     IntersexWoman: "intersex-woman",
//     TransWoman: "trans-woman",
//     Transfemine: "trans-femine"
// }

// enum SubGendersInNonBinary {
//     NonBinary: "non-binary",
//     Agender: "agender",
//     Bigender: "bigender",
//     GenderNonConforming: "gender-non-conforming",
//     GenderVariant: "gender-variant",
//     Intersex: "intersex",
//     // IntersexMan: "intersex-man",
//     // IntersexWoman: "intersex-woman",
//     Neutrols: "neutrols",
//     Pangender: "pangender",
//     Polygender: "polygender",
//     // TransMan: "trans-man",
//     // TransWoman: "trans-woman",
//     // Transmasculine: "trans-masculine",
//     // Transfemine: "trans-femine",
//     Transgender: "transgender",
//     TwoSpirit: "two-spirit",
//     GenderFluid: "gender-fluid",
//     GenderQuestioning: "gender-questioning",
//     Genderqueer: "genderqueer",

// }

// enum Gender {
//     Man: "man",
//     Women: "women",
//     Non_Binary: "non-binary"
// }

// enum InterestedGender {
//     ...Gender,
//     Everyone: "everyone"
// }

// model Point {
//     type: string = "Point";

//     @maxItems(2)
//     @minItems(2)
//     point: float[];
// }


// model AgeRange {
//     lower: plainDate;
//     upper: plainDate;
// }


// model BlockedDatingProfile {
//     @visibility("read")
//     blocker: User;
//     @visibility("read", "create")
//     blocked_user: User;
//     @visibility("read")
//     created_at: utcDateTime;
// }

// @withVisibility("create")
// model AddUserToBlockList {
//     ...BlockedDatingProfile
// }

// @withVisibility("read")
// model ReadableBlockList {
//     ...BlockedDatingProfile
// }


// enum PromptCategories {
//     AboutMe: "About Me",

// }

// model PromptQuestion {
//     @visibility("read")
//     id: string;
//     @visibility("read", "admin-create", "admin-update")
//     prompt: string;
//     @visibility("read", "admin-create", "admin-update")
//     prompt_description: string;
//     @visibility("read")
//     created_at: string;

// }

// @withVisibility("admin-create")
// model CreatePromptQuestion {
//     ...PromptQuestion
// }

// @withVisibility("admin-update")
// model UpdatePromptQuestion {
//     ...PromptQuestion
// }

// @withVisibility("read")
// model ReadablePromptQuestion {
//     ...PromptQuestion
// }

// model DatingProfilePrompt {
//     @visibility("read")
//     created_at: utcDateTime;
//     @visibility("read")
//     profile: DatingProfile;

//     @visibility("read", "create")
//     prompt: PromptQuestion;

//     @visibility("read", "create", "update")
//     answer: string;

// }

// @withVisibility("create")
// model CreateDatingProfilePrompt {
//     ...DatingProfilePrompt
// }

// @withVisibility("update")
// model UpdateDatingProfilePrompt {
//     ...DatingProfilePrompt
// }

// @withVisibility("read")
// model ReadDatingProfilePrompt {
//     ...DatingProfilePrompt
// }

// enum QuestionType {
//     SingleSelect: "single_select",
//     MultipleSelect: "multiple_select",
//     TextInput: "text_input"
    
// }

// model DatingProfileQuestionare {
//     @visibility("read")
//     id: int32;
//     @visibility("read", "admin-create", "admin-update")
//     question: string;
//     @visibility("read", "admin-create", "admin-update")
//     description?: string;

//     @visibility("read", "admin-create", "admin-update")
//     question_type: QuestionType;

//     @visibility("read", "admin-create", "admin-update")
//     selections?: string[];

// }

// @withVisibility("read")
// model ReadDatingProfileQuestionare {
//     ...DatingProfileQuestionare
// }

// @withVisibility("admin-create")
// model CreateDatingProfileQuestionare {
//     ...DatingProfileQuestionare
// }

// @withVisibility("admin-update")
// model UpdateDatingProfileQuestionare {
//     ...DatingProfileQuestionare
// }



// model DatingProfile {
//     @visibility("read")
//     @doc("A one-to-one relationship with the User model.")
//     @key account: string;

//     @visibility("read", "create", "update")
//     @doc("The name of the account holder.")
//     name: string;

//     @visibility("read", "create", "update")
//     dob: plainDate;

//     @visibility("read", "create", "update")
//     @doc("A brief biography of the account holder.")
//     bio: string;

//     @visibility("read", "create", "update", "dating_preferences")
//     @doc("The interest tags associated with the account.")
//     interest_tags: string[];

//     @visibility("read", "create", "update")
//     @doc("The gender that the account holder is interested in.")
//     gender: Gender;

//     @visibility("read", "create", "update")
//     sub_gender?: SubGendersInMale | SubGendersInFemale | SubGendersInNonBinary;

//     @visibility("read", "create", "update", "dating_preferences")
//     @doc("The gender that the account holder is interested in. User can select upto 3 genders.")
//     interested_genders: InterestedGender[];
    
//     @visibility("read",  "update")
//     is_online?: boolean;

//     @visibility("read")
//     is_active: boolean = true;

//     @visibility("read")
//     is_premium: boolean = false;

//     /**
//      * `is_in_relationship` is marked by internal system indicating account's status of relationship.
//      * This state variable will be used in Matching Pools to remove already in relationship accounts.
//      */
//     @visibility("read")
//     is_in_relationship: boolean = false;

//     @visibility("read")
//     @doc("profile is ready for dating?")
//     is_profile_complete: boolean = false;

//     @visibility("read",  "update")
//     avatar?: string| null = null;

//     @visibility("read",  "update")
//     @doc("The current place name of the account holder.")
//     current_place?: string| null = null;

//     @visibility("read", "update", "dating_preferences")
//     @doc("Lat long of current location")
//     current_location?: Point;

//     @visibility("read")
//     @doc("Current number of simultaneous matches. These matches exclude dating room matches.")
//     current_matches: int8;

//     @visibility("read")
//     @doc("Number of current active chats")
//     current_active_chats: int8;

//     @visibility("read",  "update")
//     @doc("The hometown of the account holder.")
//     hometown?: string| null = null;

//     // @visibility("read",  "update", "dating_preferences")
//     // @doc("The height of the account holder, stored in feet format (e.g., 6.9 or 6.11).")
//     // height?: float | null = null;

//     @visibility("read",  "update", "dating_preferences")
//     @doc("Search distance range in meters.")
//     search_range?: int16 = 20000;

//     @visibility("read",  "update", "dating_preferences")
//     @doc("The age range that the account holder is interested in. default [19,28]")
//     age_range?: AgeRange;

//     @visibility("hidden")
//     @maxItems(768)
//     @minItems(768)
//     embedding_bio?: float[];
    

// }



// @withVisibility("read")
// model ReadableDatingProfile {
//     ...DatingProfile
// }

// @withVisibility("create")
// model CreateDatingProfile {
//     ...DatingProfile
// }

// @withVisibility("update")
// model UpdateDatingProfileModel {
//     ...DatingProfile
// }

// @withVisibility("dating_preferences")
// model SetDatingPreferencesModel {
//     ...DatingProfile
// }

// enum DatingProfileMediaContentType {
//     Image: "image",
//     Video: "video",
//     Audio: "audio"
// }

// model DatingProfileMediaContent {
//     @visibility("read")
//     profile: DatingProfile;
//     @visibility("read", "create")
//     content_type: string;
//     @visibility("read", "create", "update")
//     caption?: string;
//     @visibility("read", "create")
//     url: string;
//     @visibility("read")
//     created_at: utcDateTime;
// }

// @withVisibility("create")
// model CreateDatingProfileMediaContent {
//     ...DatingProfileMediaContent
// }

// @withVisibility("update")
// model UpdateDatingProfileMediaContent {
//     ...DatingProfileMediaContent
// }

// @withVisibility("read")
// model ReadDatingProfileMediaContent {
//     ...DatingProfileMediaContent
// }


// enum MatchingDisabledReason {
//     Cooldown: "cool_down",
//     Blocked: "blocked",
//     Unknown: "unknown"
// }

// model AccountMatchingStatus {
//     current_matches_left: int8;
//     max_matching_quota: int8;
//     is_matching_enabled: boolean;
//     matching_disabled_reason?: MatchingDisabledReason;
//     cool_down_finish_at?: utcDateTime;
//     matching_disabled_reason_message?: string;

// }



// model DatingRoom {
//     @visibility("read", "join")
//     id: string;
//     @visibility("read", "update")
//     is_active: boolean;
//     @visibility("read", "create", "update")
//     start_at: utcDateTime;
//     @visibility("read", "create", "update")
//     end_at?: utcDateTime;
//     @visibility("read", "create", "update")
//     name: string;
//     @visibility("read", "create", "update")
//     banner: string;
//     @visibility("read", "create", "update")
//     description: string;
//     @visibility("read", "create", "update")
//     location: Point;
//     @visibility("read", "create", "update")
//     place_name: string;
//     @visibility("read", "update")
//     medias?: [{content_type: string, url: string}];
//     @visibility("read", "update", "join")
//     code: string;

//     @visibility("read")
//     created_at: utcDateTime;
//     @visibility("read")
//     updated_at: utcDateTime;

// }

// @withVisibility("create")
// model CreateDatingRoom {
//     ...DatingRoom
// }

// @withVisibility("read")
// model ReadDatingRoom {
//     ...DatingRoom
// }

// model DatingRoomQueryParam {
//     id?: string;
//     name?: string;
//     location?: Point;
//     start_at?: utcDateTime
// }

// @withVisibility("update")
// model UpdateDatingRoom {
//     ...DatingRoom
// }

// @withVisibility("join")
// model JoinDatingRoom {
//     ...DatingRoom
// }

// enum MatchPairType {
//     RandomPairing: "random_pairing",
//     DatingRoom: "dating_room"

// }



// model MatchingPair {
//     @visibility("read", "create")
//     accounts: DatingProfile[];
//     @visibility("read")
//     pairing_type: MatchPairType;
//     @visibility("read", "create")
//     matching_pool: MatchingPool;
//     @visibility("read", "create")
//     dating_room?: DatingRoom;
//     @visibility("read")
//     @doc("Matching pair is active. False value if pair disabanded.")
//     is_active: boolean;
//     @visibility("read", "update")
//     @doc("Pair has exchanged 1-1 messages.")
//     has_established_connection: boolean;
//     @visibility("read", "update")
//     @doc("Match is converted to relationship.")
//     is_in_relationship: boolean;

//     @doc("Match pair is frozen. The pair can only respond to prompts and cannot perform actions like chat.")
//     is_frozen: boolean;

//     @visibility("read")
//     @doc("latest activity")
//     latest_activity?: MatchingPairProfileActivity;

//     @visibility("read")
//     created_at: utcDateTime;
//     @visibility("read")
//     updated_at: utcDateTime;


// }

// @withVisibility("create")
// model CreateMatchingPair {
//     ...MatchingPair
// }


// @withVisibility("update")
// model UpdateMatchingPair {
//     ...MatchingPair
// }

// @withVisibility("read")
// model ReadMatchingPair {
//     ...MatchingPair
// }


// enum MatchingPairProfileActivityType {
//     ExposeProfile: "expose_profile",
//     AcceptRelationship: "accept_relationship",
//     RejectRealtionship: "reject_relationship",
//     LeaveChat: "leave_chat"
// }

// model MatchingPairProfileActivity {
//     @visibility("read")
//     pair: MatchingPair;
//     @visibility("read")
//     profile: DatingProfile;
//     @visibility("read", "create")
//     @doc("AcceptRelationship will set a schedule task to auto-delete pair if response was not provided.")
//     activity: MatchingPairProfileActivityType;

// }

// @withVisibility("create")
// model CreateMatchingPairProfileActivity {
//     ...MatchingPairProfileActivity
// }

// @withVisibility("read")
// model ReadMatchingPairProfileActivity {
//     ...MatchingPairProfileActivity
// }

// model MatchingPool {
//     @visibility("read")
//     profile: DatingProfile;
//     @visibility("read")
//     created_at: utcDateTime;
//     @visibility("read")
//     dating_room?: DatingRoom;

// }

// @withVisibility("read")
// model ReadMatchingPool {
//     ...MatchingPool
// }


// model Waitlist {
//     @visibility("read", "create")
//     email: string;
//     @visibility("read", "create")
//     message?: string;
//     @visibility("read")
//     created_at: utcDateTime;
// }

// @withVisibility("read")
// model ReadWaitlist {
//     ...Waitlist
// }

// @withVisibility("create")
// model JoinWaitlist {
//     ...Waitlist
// }