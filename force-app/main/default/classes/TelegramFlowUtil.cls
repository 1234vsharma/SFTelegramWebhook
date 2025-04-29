public with sharing class TelegramFlowUtil {
  @InvocableMethod(label = 'Sends Telegram Notification' description='Takes telegramUserId and messageBody')
  public static List<Results> sendTelegramNotification (List<Requests> requestList) {
    List<Results> resultsList = new List<Results>();
    for (Requests request : requestList) {
        
     TelegramCmpRemoter.sendMessage(request.contactId, request.telegramMessage);
     Results res= new Results();
        res.isSuccess= true;
         //Add Result to the results List at the same position as the request is in the requests List
      resultsList.add(res);
    }
    return resultsList;
  }

  public class Requests {
    @InvocableVariable(label='Contact Id'  Description='Message will be send to Telegram_User_ID__c on this contact' required=true)
    public String contactId;
    @InvocableVariable(label='Telegram Message' description='Message Body that will be sent to telegram' required=true)
    public String telegramMessage;
  }

  public class Results {
    @InvocableVariable(label='Is Success' required=false)
        public Boolean isSuccess;
  }
}