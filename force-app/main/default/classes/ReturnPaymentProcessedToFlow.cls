public class ReturnPaymentProcessedToFlow {
    public static List<String> msgToFlow=new List<String>();
    List<Integer> cntToFlow=new List<Integer>();

    @invocablemethod(label='Send message')

    public static List<String> sendMsg(List<String> req)
    {
       msgToFlow.addAll(req);
        return msgToFlow;
        
    }


}