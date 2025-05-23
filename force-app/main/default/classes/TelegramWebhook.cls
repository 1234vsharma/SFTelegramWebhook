@RestResource(urlMapping = '/telegramWebhook')
global class TelegramWebhook {
    
    @HTTPPOST
    global static void doPost() {
        
        Map<String, Object> dataReceived = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
        system.debug('dataReceived-->' + dataReceived);
        //Get user and message details
        Map<String, Object> message = (Map<String, Object>) dataReceived.get('message');
        Map<String, Object> chat = (Map<String, Object>) message.get('chat');
        Map<String, Object> fromUser = (Map<String, Object>) message.get('from');
        
        //Get user(Sender) Id
        system.debug('ABC-->'+fromUser.get('id'));
        Long userId = Long.valueOf(String.valueOf(fromUser.get('id')));
        system.debug('userId-->'+userId);
        String reply = '';
        
        //Find contact
        List<Contact> contacts = [SELECT id FROM Contact WHERE Telegram_User_ID__c = :userId];
        
        //If contact not found, create new contact
        if(contacts.size() == 0) {
            String firstName = String.valueOf(fromUser.get('first_name'));
            String lastname = String.valueOf(fromUser.get('last_name'));
            //firstName = 'ABC';
            //lastname = 'Testing';
            
            Contact contact = new Contact(FirstName = firstName, LastName = lastname, Telegram_User_ID__c = userId);
            insert contact;
            reply = 'Contact Created! You can now receive updates from Salesforce.\nThanks';
        } else {
            reply = 'You can receive updates from Salesforce.\nThanks';
        }
        
        //Send reply
        sendMessage(userId, reply);
    }
    
    @future(callout = true)
    private static void sendMessage(Long userId, String reply) {
        TelegramUtility.Message message = new TelegramUtility.Message(userId, reply);
        TelegramUtility.sendMessage(message);
    }
}