
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

/**
 * The InterestTags model stores interest tags and their associated vector embeddings. 
 * These tags represent various interests that users can select, 
 * and the vector embeddings are used to find people with similar interests.
 * 
 */
model InterestTag {
    /**
     * The primary key for the model, representing the interest tag.
     */
    @visibility("admin-read", "admin-create")
    @maxLength(50)
    @key tag: string;
    /**
     * A URL pointing to an icon that visually represents the interest tag.
     */
    @visibility("admin-read", "admin-create", "admin-update")
    icon?: string | null = null;

    /**
     * A vector embedding representing the interest tag, used for similarity searches.
     */
    @visibility("hidden")
    @maxItems(768)
    embedding: float[]
}


@withVisibility("admin-create")
model CreateInterestTag {
    ...InterestTag
}

@withVisibility("admin-read")
model ReadableInterestTag {
    ...InterestTag
}

@withVisibility("admin-update")
model UpdateableInterestTag {
    ...InterestTag
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
    // IntersexMan: "intersex-man",
    // IntersexWoman: "intersex-woman",
    Neutrols: "neutrols",
    Pangender: "pangender",
    Polygender: "polygender",
    // TransMan: "trans-man",
    // TransWoman: "trans-woman",
    // Transmasculine: "trans-masculine",
    // Transfemine: "trans-femine",
    Transgender: "transgender",
    TwoSpirit: "two-spirit",
    GenderFluid: "gender-fluid",
    GenderQuestioning: "gender-questioning",
    Genderqueer: "genderqueer",

}

enum Gender {
    ...SubGendersInMale,
    ...SubGendersInFemale,
    ...SubGendersInNonBinary
}

alias InterestedGender = Gender;

model Point {
    type: string = "Point";

    @maxItems(2)
    @minItems(2)
    point: float[];
}


model AgeRange {
    lower: int8;
    upper: int8;
}

const defaultAgeRange: AgeRange = #{
    lower: 19,
    upper: 28
};

model DatingAccount {
    @visibility("read")
    @doc("A one-to-one relationship with the User model.")
    @key account: string;

    @visibility("read", "create", "update")
    @doc("The name of the account holder.")
    name: string;

    @visibility("read", "create", "update")
    birth_date: plainDate;

    @visibility("read", "create", "update")
    @doc("A brief biography of the account holder.")
    bio: string;

    @visibility("read", "create", "update")
    @doc("The interest tags associated with the account.")
    interest_tags: string[];

    @visibility("read", "create", "update")
    @doc("The gender that the account holder is interested in.")
    gender: Gender;

    @visibility("read", "create", "update")
    @doc("The gender that the account holder is interested in. User can select upto 3 genders.")
    interested_genders: InterestedGender[];
    
    @visibility("read",  "update")
    is_online?: boolean;

    @visibility("read")
    is_active: boolean = true;

    @visibility("read")
    is_premium: boolean = false;

    /**
     * `is_in_relationship` is marked by internal system indicating account's status of relationship.
     * This state variable will be used in Matching Pools to remove already in relationship accounts.
     */
    @visibility("read")
    is_in_relationship: boolean = false;

    @visibility("read",  "update")
    avatar?: string| null = null;

    @visibility("read",  "update")
    @doc("The current place name of the account holder.")
    current_place?: string| null = null;

    @visibility("read",  "update")
    @doc("The hometown of the account holder.")
    hometown?: string| null = null;

    @visibility("read",  "update")
    @doc("The height of the account holder, stored in feet format (e.g., 6.9 or 6.11).")
    height?: float | null = null;

    @visibility("read",  "update")
    @doc("Search distance range in meters.")
    search_range?: int16 = 20000;

    @visibility("read",  "update")
    @doc("The age range that the account holder is interested in. default [19,28]")
    age_range?: AgeRange;

    @visibility("hidden")
    @maxItems(768)
    @minItems(768)
    embedding_bio?: float[] | null = null;
    

}

@withVisibility("read")
model ReadableDatingAccount {
    ...DatingAccount
}