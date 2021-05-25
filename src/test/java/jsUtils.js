function waitTimeSec(x) {
    karate.log('sleeping');
    java.lang.Thread.sleep(x * 1000);
}

function ranString(x) {
    return Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
}

/**
 * Generates random integer
 * @param {no of digits} x
 * @returns random integer
 */
function ranInteger(x) {
    if (x) {
        return new java.util.Random().nextInt(Math.pow(10, x));
    } else {
        return new java.util.Random().nextInt(100000000);
    }
}

/**
 * Generates a random number between 0(inclusive) and length of an array(exclusive)
 * @param {length of an array} length 
 */
function randomNumber(length) {
    var number =  Math.floor(Math.random() * length);
    if(number>=length){
        number = length -1;
    }else if(number==0){
        number = 1
    }
    return number; 
}

/**
 * Generates todays date/time in epoch format
 * @returns todays date/time
 */
function getCurrentEpochTime(){
    return new java.util.Date().getTime();
}

function getCurrentTime(){
      var simpleDateFormat = new java.text.SimpleDateFormat("HH:mm");
    return simpleDateFormat.format(new java.util.Date().getTime());
}


function getCurrentDate1(){
    var simpleDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
    return simpleDateFormat.format(new java.util.Date());
}

function getCurrentDate2(){
    var simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    return simpleDateFormat.format(new java.util.Date());
}
/**
 * Generates tomorrows date/time in epoch format
 * @returns tomorrows date/time
 */
function getTomorrowEpochTime(){
    return new Date(new java.util.Date().getTime() + (1000 * 60 * 60 * 24)).getTime();
}

/**
 * Generates date/time in epcoh format
 * @param {no of days in future from now} days
 * @returns date/time in epoch format
 */
function getEpochDate(days){
    return new Date(new java.util.Date().getTime() + (1000 * 60 * 60 * 24 * days)).getTime();
}

function getDate1(days){
    var simpleDateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
    var cal = java.util.Calendar.getInstance();
    cal.add(java.util.Calendar.DATE, days);
    return simpleDateFormat.format(cal.getTime());
}


function getPastEpochDate(days){
    return new Date(new java.util.Date().getTime() - (1000 * 60 * 60 * 24 * days)).getTime();
}

function validateAddress(request, response){

if(request.Property.address.city == karate.jsonPath(response,"$.Properties[*].address.city")[0] && 
	request.Property.address.doorNo == karate.jsonPath(response,"$.Properties[*].address.doorNo")[0] && 
	request.Property.address.locality.code == karate.jsonPath(response,"$.Properties[*].address..code")[0] && 
	request.Property.address.locality.area == karate.jsonPath(response,"$.Properties[*].address..area")[0]){
	return true;
	} else {
	
	return false;
	}
}

/**
 * Generates random mobile number
 * @param {no fo digits} x
 * @returns random mobile number
 */
function randomMobileNumGen(x)
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

/**
 * Generates random string using predefined character set
 * @param {character length of string} length
 * @returns random string
 */
function randomString(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }

 /**
 * Converts string to an integer
 * @param {string} x
 * @returns converted integer
 */
 function stringToInteger(x) {
    return parseInt(x);
}
function intergerToString(x) {
    return x.toString();
}
/**
 * Fetched data based upon the environment selected
 * @param {String} rootParam 
 * @param {String} key
 * @returns Value based upon the root param and key provided 
 */
function getDataBasedOnEnvironment(rootParam, key) {
   var envProperties = karate.read('file:envYaml/' + env + '/' + env +'.yaml');
   var data =  karate.jsonPath(envProperties, "$."+ rootParam +"."+ key +"")
    return data;
}
/**
 * Generates random emailid
 * @param {character length of string} x
 * @returns random string with email domain
 */
function ranEmailId(x) {
    var name = Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
    return name + '@gmail.com'
}

/**
 * Generates current date with dd/mm/yyyy format
 * @returns today date
 */
function todayDate(){
    var today = new Date();
    var dd = String(today.getDate());
    var mm = String(today.getMonth() + 1);
    var yyyy = today.getFullYear();
    today = dd + '/' + mm + '/' + yyyy;
    return today;
}

/**
 * Generates current date with dd-mm-yyyy format
 * @returns today date
 */
function currentDate(){
    var today = new Date();
    var dd = String(today.getDate());
    var mm = String(today.getMonth() + 1);
    var yyyy = today.getFullYear();
    today = dd + '-' + mm + '-' + yyyy;
    return today;
}
function yesterdayDate(){
    var yesterday = new Date();
    yesterday.setDate(yesterday.getDate()-1);
    var dd = String(('0' + (yesterday.getDate()+1)).slice(-2));
    var mm = String(('0' + (yesterday.getMonth()+1)).slice(-2));
    var yyyy = yesterday.getFullYear();
    yesterday = dd + '-' + mm + '-' + yyyy;
    return yesterday;
}

function generateUUID(){
    var uuid = '' + java.util.UUID.randomUUID();
    return uuid
}

/** To validate expected result and actual result with dynamic value
 * response: will get after execution
 * constant: constant value in constant yaml file
 */
function toGetDynamicValueFromResponse(response, constant)
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

/** To replace comma and validate the response */
function toReplaceComma(responseMessage)
{
    responseMessage = responseMessage.replaceAll("'","");
    return responseMessage;
}
/**
 * Check specifically 'active' field value
 * @param {filtered array of response} filteredArrayOfResponse 
 * @param {values needs to be matched} valueToBeMatched 
 * @returns true if success otherwise false
 */
function deterMineActiveFieldValue(filteredArrayOfResponse, valueToBeMatched){
    var flag = false;
    for(var index=0; index<filteredArrayOfResponse.size(); index++){
        if(filteredArrayOfResponse[index].active === valueToBeMatched)
            return flag = true;
            else
            return flag;
        }
}

function extractLagsData(data){
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

//Comparer Function    
function GetSortOrder(prop) {    
    return function(a, b) {    
        if (a[prop] > b[prop]) {    
            return 1;    
        } else if (a[prop] < b[prop]) {    
            return -1;    
        }    
        return 0;    
    }    
}

function compareOffsetMovement(dataBefore, dataAfter){
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

function randomFloat(x) {
    if (x) {
        return new java.util.Random().nextFloat();
    } else {
        return new java.util.Random().nextFloat(100000000);
    }
}

function replaceString(stringText,texttoReplace,textToReplaceWith)
{
    text = stringText.replaceAll(texttoReplace,textToReplaceWith);
    return text;
   }


function jsonToString(obj) {
    var myJSON = JSON.stringify(obj);
    return myJSON
}