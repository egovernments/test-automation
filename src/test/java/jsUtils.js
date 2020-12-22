
function waitTimeSec(x) {
    karate.log('sleeping');
    java.lang.Thread.sleep(x * 1000);
}

function ranString(x) {
    return Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, x);
}

function ranInteger(x) {
    if (x) {
        return new java.util.Random().nextInt(Math.pow(10, x));
    } else {
        return new java.util.Random().nextInt(100000000);
    }
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