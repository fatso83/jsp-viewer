Simple JSP viewer
======================================

> Serve JSPs in an easy way for quick-editing

## Why 
Sometimes front-enders need to edit jsps without having 
access to the actual application server to test it out.
This enables us to see the result, and also reference
any system properties needed by setting them in a 
properties file.

## Usage
`view-jsp ./jsp-dir`

This will fire up a server on port 8080 on localhost that
will display the jsp. You need to have `java` on the path.

### Setting session attributes
The `/session` path is available for easy manipulation of session attributes.
You only need to supply the path to the jsp you want to display as the `jsp` attribute,
and all other session vars will be set from the url.

Example:
```
http://localhost:8080/session?jsp=login_chainidno.jsp&cssurl=Static/styles/login.css
```

This will serve the jsp `/login_chainidno.jsp` and set the  session attribute `cssurl` to 
`Static/styles/login.css`.


## Installation
Just issue `./build` to end up with a script that will reference the built jar file.
You can put this script `view-jsp` wherever you like in your `$PATH`, such as `/usr/local/bin/`.

## Dependencies
- For running: only Java (I think Java 7 will do)
- For building: Maven 3
