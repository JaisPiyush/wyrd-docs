

model User {
    // Phone number
    @key username: string;
    email?: string;
}

model DateRange {
    lower_date: plainDate;
    upper_date?: plainDate;
}

model GeoPoint {
    type: "Point";
    point: {
        x: float32;
        y: float32;
    };
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
    @visibility("read", "create")
    @key user: User;

    @visibility("read")
    created_at: utcDateTime;

}


@withVisibility("read")
model ReadDatingRoomOrganizer {
    ...DatingRoomOrganizer
}

@withVisibility("create")
model CreateDatingRoomOrganizer {
    ...DatingRoomOrganizer,
    email: string;
    first_name: string;
    last_name: string;
}

@withVisibility("update")
model UpdateDatingRoomOrganizer {
    ...DatingRoomOrganizer
}


model InterestTag {
    @visibility("read")
    @key id: int32;

    @visibility("read", "create")
    tag: string;

    @visibility("read", "create", "update")
    icon: string;

    @visibility("read", "create", "update")
    category: string;

    @visibility("hidden")
    embedding: float32[];
}

@withVisibility("read")
model ReadInterestTag {
    ...InterestTag
}

@withVisibility("create")
model CreateInterestTag {
    ...InterestTag
}

@withVisibility("update")
model UpdateInterestTag {
    ...InterestTag
}

enum AssessmentQuestionType {
    single_choice: "sc",
    multiple_choice: "mc",
    text: "txt"
}

/**
 * Assessment questions for asking user
 * 
 */
model AssessmentQuestion {
    @visibility("read")
    @key id: int32;

    @visibility("read", "create", "update")
    question_type: AssessmentQuestionType;

    @visibility("read", "create", "update")
    question: string;

    @visibility("read", "create", "update")
    description?: string;

    @visibility("read", "create", "update")
    options?: string[];
}

@withVisibility("read")
model ReadAssessmentQuestion {
    ...AssessmentQuestion
}

@withVisibility("create")
model CreateAssessmentQuestion {
    ...AssessmentQuestion
}

@withVisibility("update")
model UpdateAssessmentQuestion {
    ...AssessmentQuestion
}

model DatingProfileAssessmentQuestion {
    @visibility("read", "create")
    question: ReadAssessmentQuestion;

    @visibility("create")
    profile: DatingProfile;

    @visibility("read", "create", "update")
    answer: string;

    @visibility("read", "create", "update")
    selected_option_index?: int32;

    @visibility("hidden")
    embedding: float64[];
}

@withVisibility("read")
model ReadDatingProfileAssessmentQuestion {
    ...DatingProfileAssessmentQuestion
}

@withVisibility("create")
model CreateDatingProfileAssessmentQuestion {
    ...DatingProfileAssessmentQuestion
}

@withVisibility("update")
model UpdateDatingProfileAssessmentQuestion {
    ...DatingProfileAssessmentQuestion
}


enum MediaContentType {
    Image: "image",
    Video: "video",
    Audio: "audio"
}

/**
 * 
 */
model DatingProfileContentMedia<T extends MediaContentType> {
    @visibility("read")
    @key id: int32;

    @visibility("create")
    profile: DatingProfile;

    @visibility("read", "create",)
    content_type: T;

    @visibility("read", "create",)
    url: string;

    @visibility("read", "create",)
    caption?: string;

    @visibility("read", "create",)
    is_profile_picture: boolean = false;

    @visibility("read", "update")
    position: int8;

    @visibility("read")
    created_at?: utcDateTime;

    @visibility("read")
    updated_at?: utcDateTime;
}

@withVisibility("read")
model ReadDatingProfileContentMedia<T extends MediaContentType> {
    ...DatingProfileContentMedia<T>
}

@withVisibility("create")
model CreateDatingProfileContentMedia {
    ...DatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>
}

@withVisibility("update")
model UpdateDatingProfileContentMedia {
    ...DatingProfileContentMedia<MediaContentType.Audio | MediaContentType.Image | MediaContentType.Image>
}

model UpdateMediaPositions {
    new_positions: {
        id: int32;
        position: int8;
    }[];
}


enum TextPromptCategory {
    AboutMed: "about_me"
}

model TextPrompt {
    @visibility("read")
    @key id: int32;

    @visibility("read", "create", "update")
    question: string;

    @visibility("read", "create", "update")
    category: string;
}

@withVisibility("read")
model ReadTextPrompt {
    ...TextPrompt
}

@withVisibility("create")
model CreateTextPrompt {
    ...TextPrompt
}

@withVisibility("update")
model UpdateTextPrompt {
    ...TextPrompt
}

model DatingProfileTextPrompt {
    @visibility("read")
    @key id: int64;

    @visibility("read", "create")
    prompt: ReadTextPrompt;

    @visibility("create")
    profile: DatingProfile;

    @visibility("read", "create", "update")
    answer: string;
}

@withVisibility("read")
model ReadDatingProfileTextPrompt {
    ...DatingProfileTextPrompt
}

@withVisibility("create")
model CreateDatingProfileTextPrompt {
    ...DatingProfileTextPrompt
}

@withVisibility("update")
model UpdateDatingProfileTextPrompt {
    ...DatingProfileTextPrompt
}

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

enum Sexuality {
    Straight: "straight",
    Gay: "gay",
    Lesbian: "lesbian",
    Bisexual: "bisexual",
    Allosexual: "allosexual",
    Androsexual: "adnrosexual",
    Asexual: "asexual",
    Autosexual: "autosexual",
    Bicurious: "bicurious",
    Demisexual: "demisexual",
    // more to come
}


model DatingProfile {
    @visibility("read", "unexpv")
    @key user: User;

    @visibility("read", "create", "update", "unexpv")
    name: string;

    @visibility("read", "create", "update", "seo", "unexpv")
    dob: plainDate;

    @visibility("read", "create", "update", "seo", "unexpv")
    gender: Gender;

    @visibility("read", "create", "update", "unexpv")
    bio?: string;

    @visibility("read", "create", "update", "unexpv")
    subgender?: SubGendersInFemale | SubGendersInNonBinary | SubGendersInMale;

    @visibility("read", "update", "unexpv")
    show_subgender_on_profile: boolean = false;

    @visibility("read", "create", "update", "seo")
    interested_genders: Gender[];

    @visibility("read", "create", "update", "search_param", "unexpv")
    dating_intention: DatingIntention;

    @visibility("read", "create", "update", "seo", "unexpv")
    @maxItems(8)
    @minItems(5)
    interest_tags: ReadInterestTag[];

    @visibility("read", "expv")
    @minItems(1)
    @maxItems(6)
    medias: ReadDatingProfileContentMedia<MediaContentType.Image | MediaContentType.Video>[];

    @visibility("read", "unexpv")
    @maxItems(2)
    audios: ReadDatingProfileContentMedia<MediaContentType.Audio>[];

    @visibility("read", "unexpv")
    @maxItems(3)
    prompts: ReadDatingProfileTextPrompt[];

    @visibility("read")
    is_active: boolean;

    /**
     * `is_in_relationship` is marked by internal system indicating account's status of relationship.
     * This state variable will be used in Matching Pools to remove already in relationship accounts.
     */
    @visibility("read")
    is_in_relationship: boolean  = false;

    /**
     * 
     *  - 10 questions provided
     *  - 1 image & 2 media
     *  - bio written
     *  - 3 text prompts
     *  - 8 interest tags
     */
    @visibility("read")
    @maxValue(1.0)
    profile_completion_score: float32 = 0.0;

    @visibility("read", "update", "unexpv")
    sexuality?: Sexuality;

    @visibility("create", "update", "search_param")
    location_point: GeoPoint;

    @visibility("read", "create", "update", "search_param", "unexpv")
    @doc("Locality name")
    location: string;

    @visibility("read", "update", "unexpv")
    work?: string;

    @visibility("read", "update", "unexpv")
    job_title?: string;

    @visibility("read", "update", "unexpv")
    college?: string;

    @visibility("read", "update", "unexpv")
    education_level?: "Secondary School" | "Undergrad" | "Postgrad" | "Prefer not to say";

    @visibility("read", "update", "unexpv")
    hometown?: string;

    @visibility("read", "update", "search_param")
    search_range: int16 = 20000;

    @visibility("read", "update", "search_param")
    age_range: DateRange;

    @visibility("update", "seo")
    questions: ReadDatingProfileAssessmentQuestion[];

    
    @visibility("read")
    current_active_chats: int16 = 0;

    @visibility("read")
    matches_found_after_previous_cooldown: int16 = 0;

    @visibility("read")
    matching_quota: int16 = 5;

    @visibility("read")
    cool_down_expire_at?: utcDateTime;

    @visibility("read")
    is_profile_in_dating_pool: boolean = false;

    @visibility("hidden")
    question_embedding: float64[];


}

@withVisibility("read")
model ReadDatingProfile {
    ...DatingProfile
}

@withVisibility("unexpv")
model UnExposedReadDatingProfile {
    ...DatingProfile
}

@withVisibility("unexpv","expv")
model ExposedReadDatingProfile {
    ...DatingProfile
}


@withVisibility("create")
model CreateDatingProfile {
    ...DatingProfile
}

@withVisibility("update")
model UpdateDatingProfile {
    ...DatingProfile
}

@withVisibility("seo")
model SEODatingProfile {
    ...DatingProfile
}

@withVisibility("search_param")
model DatingPreferencesDatingProfile {
    ...DatingProfile
}


model ReadDatingProfileMatchingStatus {
    matching_quota: int16 = 5;
    matches_found_after_previous_cooldown: int16 = 0;
    cool_down_expire_at?: utcDateTime;
    is_matching_enabled: boolean = true;
    matching_disabled_reason?: "cool_down" | "blocked" | "unknown" | "finding_match";
    matching_disabled_reason_message?: string;
}

/**
 * 
 * start_date: Specifies the date when the dating room will start displaying matches. 
 * The dating room has a start_time, which defaults to 12 PM.
 * end_date: Automatically closes the dating room, removes it from search, and stops the matching process within the dating room on this date. 
 * All matches made before this date will persist.
 * start_time: The time of day when the dating room begins matching, defaulting to 12 PM.
 * end_time: By default, set to 12 PM. If end_date is not defined, the dating room remains in search indefinitely. 
 * If only end_time is provided, the dating room will be active for matching only between start_time and end_time each day. 
 * If the creator has enabled auto_flush_participants, the matching pool will be emptied at the end of each day at end_time.
 * Requirements: The room creator must specify either end_date or end_time to close the matching system or the dating room.
 * Visibility: A public dating room is searchable from the day of creation until end_date.
 * If location is undefined the dating room can be joined by anybody from anywhere in the world.
 * 
 */
model DatingRoom {
    @visibility("read", "search_param")
    @key id: int64;


    @visibility("detail_read")
    owner: ReadDatingRoomOrganizer;

    @visibility("read", "search_param")
    @doc("room is available for joining")
    is_active: boolean;

    @visibility("read", "create", "update")
    search_distance_range?: int32 = 20000;

    @visibility("read", "create", "update", "search_param")
    location?: GeoPoint;

    @visibility("read", "create", "update")
    venue_name?: string;

    @visibility("read", "create", "update")
    venue_address?: string;

    @visibility("read", "create", "update", "search_param")
    start_date: plainDate;

    @visibility("read", "create", "update")
    start_time: plainTime;

    @visibility("read", "create", "update")
    end_date?: plainDate;

    @visibility("read", "create", "update")
    end_time?: plainTime;

    @visibility("create", "update", "search_param")
    visibility: "public" | "private";

    @visibility("read", "create")
    @doc("cc: Common code. ucpu: Unique code per user.")
    entry_code_type: "cc" | "ucpu";

    @visibility("read", "create", "update", "search_param")
    name: string;

    @visibility("detail_read", "create", "update")
    description: string;

    @visibility("read", "create", "update")
    banner: string;

    @visibility("update")
    common_code?: string;

    @visibility("detail_read", "create", "update")
    images: string[];

    @visibility("detail_read", "create", "update")
    terms_and_conditions?: string[];

    @visibility("read")
    created_at: utcDateTime;

    @visibility("read")
    updated_at: utcDateTime;

    @visibility("read")
    @doc("Matching is online and participants can start matching instantly")
    is_matching_online: boolean;

    @visibility("read")
    participants_count: int64;

    @visibility("read", "search_param")
    is_participant: boolean = false;
    
}

@withVisibility("read")
model ReadDatingRoom {
    ...DatingRoom
}

@withVisibility("read", "detail_read")
model DetailReadDatingRoom {
    ...DatingRoom
}

@withVisibility("search_param")
model SearchParamDatingRoom {
    ...DatingRoom
}

@withVisibility("create")
model CreateDatingRoom {
    ...DatingRoom
}

@withVisibility("update")
model UpdateDatingRoom {
    ...DatingRoom
}


model DatingRoomParticipantsStats {
    start_date: plainDate;
    end_date?: plainDate;
    total_participants: int64;
    male_participants: int64;
    female_participants: int64;
    other_participants: int64;
    age_stats: {
        age_19_24: int64;
        age_25_34: int64;
        age_35_44: int64;
        age_45_: int64;
    }
}


model MatchingPool<T extends "rp" | "dr" = "rp"> {
    @visibility("read", "create")
    profile: string;

    @visibility("read", "create")
    dating_room?: int64;

    @visibility("read")
    pairing_type: T;
    
    @visibility("read")
    created_at: utcDateTime;
}

@withVisibility("read")
model ReadMatchingPool<T extends "rp" | "dr" = "rp"> {
    ...MatchingPool<T>
}

@withVisibility("create")
model CreateMatchingPool<T extends "rp" | "dr" = "rp"> {
    ...MatchingPool<T>
}

@withVisibility("read")
@doc("Matching pool store temporary data. Archive stores data of Matching Pools for later analysis.")
model ArchivedMatchingPool {
    ...MatchingPool,

    @visibility("read")
    @key id: int64;
}

model MatchingPairDatingProfileInfo {
    avatar: string;
    name: string;
    id: string;
}


model MatchingPair {
    @key id: string;
    pairing_type: "rp" | "dr";

    profile_1: MatchingPairDatingProfileInfo;

    profile_2: MatchingPairDatingProfileInfo;

    dating_room?: int64;

    archive_matching_pool_id: int64;

    is_profile_1_exposed: boolean = false;
    is_profile_2_exposed: boolean = false;

    @doc("Match pair is not disbanded")
    is_active: boolean;

    @doc("both participants have exchanged 1-1 messages")
    has_established_connection: boolean = false;

    is_in_relationship: boolean = false;

    @doc("chat has been frozen.")
    is_frozen: boolean = false;

    created_at: utcDateTime;

    updated_at: utcDateTime;

    latest_activity?: ReadMatchingPairProfileActivity;


}


enum MatchingPairProfileActivityType {
    ExposeProfile: "expose_profile",
    AcceptRelationship: "accept_relationship",
    RejectRealtionship: "reject_relationship",
    LeaveChat: "leave_chat"
}

model MatchingPairProfileActivity {
    @visibility("read")
    @key id: int64;

    @visibility("read")
    pair: int64;
    @visibility("read")
    profile: string;
    @visibility("read", "create")
    @doc("AcceptRelationship will set a schedule task to auto-delete pair if response was not provided.")
    activity: MatchingPairProfileActivityType;

    @visibility("read")
    created_at: utcDateTime;

}


@withVisibility("read")
model ReadMatchingPairProfileActivity {
    ...MatchingPairProfileActivity
}

@withVisibility("create")
model CreateMatchingPairProfileActivity {
    ...MatchingPairProfileActivity
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