function() {
	var uuid = '' + java.util.UUID.randomUUID(); // convert to string
	//var dateTime = karate.get('dateTime'); // convert to string

	var locale = (karate.get('locale') != null) ? karate.get('locale') : 'en_IN';

	var out = { // so now the txid_header would be a unique uuid for each request
        locale: locale,
	};

	out['authority'] = karate.get('authorityHeader');
	out['Content-Type'] = 'application/json';
	return out;
}

