public class TelegramUtility {
    
    public static String BOT_API = Label.Telegram_Bot_API_key;

    public static void sendMessage(Message message) {
        Http httpClient = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setEndpoint('https://api.telegram.org/bot' + BOT_API + '/sendMessage');
        String body = JSON.serialize(Message);
        
        request.setBody(body);
        System.debug('req:'+request.getBody());
        HttpResponse response = httpClient.send(request);
        System.debug('res:'+response.getBody());
    }
    

    public class Message {
        Public Long chat_id;
        Public String text;
        
        public Message(Long chat_id, String text) {
            this.chat_id = chat_id;
            this.text = text;
        }
        
    }
     

    public class mme {
        Public Integer peer ;
        //Public String text;
        
        public mme(Integer peer ) {
            this.peer  = peer ;
            //this.text = text;
        }
        
    }    
    
    public static void fetchHistory(integer chatId) {
        Http httpClient = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        request.setEndpoint('https://api.telegram.org/bot' + BOT_API + '/getMessages');
        //String body = JSON.serialize(Message);
        //request.setBody(body);
        HttpResponse response = httpClient.send(request);
        system.debug(response.getBody());
    }
}