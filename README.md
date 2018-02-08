Simple JSP viewer
======================================

> Serve JSPs in an easy way for quick-editing

## Why 
Sometimes front-enders need to edit jsps without having 
access to the actual application server to test it out.
This tool enables us to see the result, and also reference
any system properties needed by setting them in a 
properties file.

I created this in my time as part of Making Waves to ease and enhance my 
front-end development experience when working with 
the login jsps for Norgesgruppen. Their login service was basically one servlet
that chose the right jsp to compile and the right css, etc, [from parameters in
the url](https://oauth.norgesgruppen.no/login/trumf?clientid=trumfdeploy&kjede=trumf&cssurl=https%3A%2F%2Fwww.trumf.no%2Fstatic%2Fstyles%2Fmain.css).

The built-in servlet in this tool does just that, making
it possible to test out all the permutations. Earlier, this was essentially
coding in the dark - creating a static html and supplying it without any 
knowledge of how it ended up in the end (a source of many bugs).

## Who uses this?
After I created this it was spread internally in Making Waves, and even some 
other external consultants working for Norgesgruppen. I have no idea if someone
else have found it useful (drop me a note!).

## Usage
`view-jsp ./jsp-dir [session-props.txt [system-props.txt]]`

This will fire up a server on port 8080 on localhost that
will display the jsp. You need to have `java` on the path.

Only the first argument is required.

### Setting session attributes
The `/session` path is available for easy manipulation of session attributes.
You only need to supply the path to the jsp you want to display as the `jsp` attribute,
and all other session vars can be set from the url.

Example:
```
http://localhost:8080/session?jsp=login_chainidno.jsp&cssurl=Static/styles/login.css
```

This will serve the jsp `/login_chainidno.jsp` and set the  session attribute `cssurl` to 
`Static/styles/login.css`.

#### Permanent settings using property files
You can also easily set session and system props using property files. The 
second argument given on the command line is the file containing session props
and the third is the system properties.


## Installation
Just issue `./build` to end up with a script that will reference the built jar file.
You can put this script `view-jsp` wherever you like in your `$PATH`, such as `/usr/local/bin/`.

## Dependencies
- For running: only Java (I think Java 7 will do)
- For building: Maven 3
