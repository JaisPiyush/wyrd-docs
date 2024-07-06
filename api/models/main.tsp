namespace WyrdModels;

/**
 * The DeviceCloudMessagingToken model stores the Firebase Cloud Messaging (FCM) 
 * device tokens of logged-in users. These tokens are essential for sending push 
 * notifications to the users' devices.
 * 
 */
model SetDeviceCloudMessagingToken {
    @doc("This field stores the unique device token provided by FCM. It is used to identify the device to which notifications should be sent. This field is the primary key for this model, ensuring each token is unique.")
    token: string;
}

model DeviceCloudMessagingToken extends SetDeviceCloudMessagingToken {
    @doc("This field establishes a relationship with the User model, indicating which user the device token belongs to.")
    user: string;
    
    @doc("This field automatically records the timestamp when the token record is created.")
    created_at: utcDateTime;

    @doc("This field automatically records the timestamp whenever the token record is updated.")
    updated_at: utcDateTime;

}