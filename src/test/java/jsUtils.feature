Feature: JavaScript Utils Feature

Background:
    * print js utils background
    * def waitTimeSec = 
    """
        function(x) {
    karate.log('sleeping');
    java.lang.Thread.sleep(x * 1000);
}
    """

    * def ranString = 
    """
        function (x) {
    return Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
}
    """

    * def ranInteger = 
    """
        function (x) {
    if (x) {
        return new java.util.Random().nextInt(Math.pow(10, x));
    } else {
        return new java.util.Random().nextInt(100000000);
    }
}
    """

    * def randomNumber = 
    """
        function (length) {
    var number =  Math.floor(Math.random() * length);
    if(number>=length){
        number = length -1;
    }else if(number==0){
        number = 1
    }
    return number; 
}
    """
    * def getCurrentEpochTime = 
    """
        function (){
    return new java.util.Date().getTime();
}
    """
    * def getCurrentDate1 = 
    """
        function (){
    var simpleDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
    return simpleDateFormat.format(new java.util.Date());
}
    """
    * def getTomorrowEpochTime = 
    """
        function (){
    return new Date(new java.util.Date().getTime() + (1000 * 60 * 60 * 24)).getTime();
}
    """
}
    * def  = 
    """
        function (days){
    return new Date(new java.util.Date().getTime() + (1000 * 60 * 60 * 24 * days)).getTime();
}
    """
    * def getDate1 = 
    """
        function (days){
    var simpleDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
    var cal = java.util.Calendar.getInstance();
    cal.add(java.util.Calendar.DATE, days);
    return simpleDateFormat.format(cal.getTime());
}
    """
    * def getPastEpochDate = 
    """
        function (days){
    return new Date(new java.util.Date().getTime() - (1000 * 60 * 60 * 24 * days)).getTime();
}
    """
    * def randomMobileNumGen = 
    """
        function (x)
{
    var tenMultiplier = Math.pow(10, x)
    var randNo,mostSigDigit= 0;
    //while(continuIter){
        while (mostSigDigit == 0){
            randNo = Math.random();
            var mostSigDigit = Math.floor(randNo * 10);
        }
        var randMobNo = Math.floor(randNo * tenMultiplier);
        var intVsl = parseInt(randMobNo);
        //if(intVsl > (tenMultiplier-1)){
        //    continuIter = false;
       // }
    //}    
    return intVsl;
}
    """
    * def randomString = 
    """
        function (length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }
    """
    * def stringToInteger = 
    """
        function (x) {
    return parseInt(x);
}
    """
    * def ranEmailId = 
    """
        function ranEmailId(x) {
    var name = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
    return name + '@gmail.com'
}
    """
    * ef todayDate = 
    """
        function (){
    var today = new Date();
    var dd = String(today.getDate());
    var mm = String(today.getMonth() + 1);
    var yyyy = today.getFullYear();
    today = dd + '/' + mm + '/' + yyyy;
    return today;
}
    """
    * def currentDate = 
    """
        function (){
    var today = new Date();
    var dd = String(today.getDate());
    var mm = String(today.getMonth() + 1);
    var yyyy = today.getFullYear();
    today = dd + '-' + mm + '-' + yyyy;
    return today;
}
    """
    * def yesterdayDate = 
    """
        function (){
    var yesterday = new Date();
    yesterday.setDate(yesterday.getDate()-1);
    var dd = String(('0' + (yesterday.getDate()+1)).slice(-2));
    var mm = String(('0' + (yesterday.getMonth()+1)).slice(-2));
    var yyyy = yesterday.getFullYear();
    yesterday = dd + '-' + mm + '-' + yyyy;
    return yesterday;
}
    """
    * def generateUUID = 
    """
        function (){
    var uuid = '' + java.util.UUID.randomUUID();
    return uuid
}
    """
    * def toGetDynamicValueFromResponse = 
    """
        function (response, constant)
{        
        var responseArray = response.split("  ", 3);   
        var messageStringArray = responseArray[2];
        var tokenValue = messageStringArray.split(" ",1);
        response = response.replace(tokenValue,'$token');
        if(response === constant)
         return true;
        else
         return false;

}
    """ 
    * def deterMineActiveFieldValue = 
    """
    function (filteredArrayOfResponse, valueToBeMatched){
    var flag = false;
    for(var index=0; index<filteredArrayOfResponse.size(); index++){
        if(filteredArrayOfResponse[index].active === valueToBeMatched)
            return flag = true;
            else
            return flag;
        }
}
    """
    * def extractLagsData = 
    """
        function (data){
    var lagData = [];
    for(var i=0;i<data.size();i++){
        lagData.push({
            "partition_id" : data[i].partition_id,
            "current_offset"  : data[i].current_offset
        });
    }
    lagData.sort(GetSortOrder("partition_id"));
    return lagData;
}
    """
    * def GetSortOrder = 
    """
        function (prop) {    
    return function(a, b) {    
        if (a[prop] > b[prop]) {    
            return 1;    
        } else if (a[prop] < b[prop]) {    
            return -1;    
        }    
        return 0;    
    }    
}
    """
    * def compareOffsetMovement = 
    """
        function (dataBefore, dataAfter){
    var offsetDiff = [];
    for(var i=0;i<dataBefore.size();i++){
        var diff = ((dataAfter[i].current_offset - dataBefore[i].current_offset) * 100) / dataBefore[i].current_offset;
        // var diff = dataAfter[i].current_offset - dataBefore[i].current_offset
        offsetDiff.push({
            "partition_id" : data[i].partition_id,
            "offset_diff"  : diff
        });
    }
    return offsetDiff;
}
    """
    * def randomFloat = 
    """
        function (x) {
    if (x) {
        return new java.util.Random().nextFloat();
    } else {
        return new java.util.Random().nextFloat(100000000);
    }
}
    """
    * def replaceString = 
    """
        function (stringText,texttoReplace,textToReplaceWith)
{
    text = stringText.replaceAll(texttoReplace,textToReplaceWith);
    return text;
   }
    """
    * def jsonToString = 
    """
        function (obj) {
    var myJSON = JSON.stringify(obj);
    return myJSON
}
    """
    * def toReplaceComma = function (responseMessage){responseMessage = responseMessage.replaceAll("\'","");return responseMessage;}

    Scenario: JavaScript functions
        * print 'Using Javascript Functions'
    