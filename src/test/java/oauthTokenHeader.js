function() {
	var uuid = '' + java.util.UUID.randomUUID(); // convert to string
	//var dateTime = karate.get('dateTime'); // convert to string

	var locale = (karate.get('locale') != null) ? karate.get('locale') : 'en_IN';

	var out = { // so now the txid_header would be a unique uuid for each request
        locale: locale,
	};

	// out['referer'] = karate.get('authReferer');
	out['Content-Type'] = 'application/x-www-form-urlencoded';
	// out['webRequest.ContentType'] = 'application/x-www-form-urlencoded';
	// out['authority'] = karate.get('authorityHeader');
	out['authorization'] = 'Basic ' + karate.get('basicAuthorization');
	return out;
}