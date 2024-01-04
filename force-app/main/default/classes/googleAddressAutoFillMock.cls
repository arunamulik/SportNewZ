global class googleAddressAutoFillMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"Place":"ABC City"}');
            response.setStatusCode(200);
            response.setStatus('OK');
       
        return response;
    }
}