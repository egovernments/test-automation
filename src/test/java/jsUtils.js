// providing a wait time which requires seconds as argument
function waitTimeSec(x) {
    karate.log('sleeping');
    java.lang.Thread.sleep(x * 1000);
}

//generating random string which requires character length as argument
function ranString(x) {
    return Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
}

//generating random number which requires no of digits as argument
function ranInteger(x) {
    if (x) {
        return new java.util.Random().nextInt(Math.pow(10, x));
    } else {
        return new java.util.Random().nextInt(100000000);
    }
}

//Get todays time in EPOCH format
function getCurrentEpochTime(){
    return new java.util.Date().getTime();
}
//Get tomorrows time in EPOCH format
function getTomorrowEpochTime(){
    return new Date(new java.util.Date().getTime() + (1000 * 60 * 60 * 24)).getTime();
}
//Get time in EPOCH format which requires no of days from as argument
function getEpochDate(days){
    return new Date(new java.util.Date().getTime() + (1000 * 60 * 60 * 24 * days)).getTime();
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

//Generating random mobile number which requires number of digits as argument
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
//Generating random string for a given character length using predefined characters
function ranString(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }

 function stringToInteger(x) {
    return parseInt(x);
}