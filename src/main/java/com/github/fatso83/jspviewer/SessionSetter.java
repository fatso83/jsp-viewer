package com.github.fatso83.jspviewer;

import java.util.Map;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Paths;
import java.net.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Properties;

import org.apache.jasper.servlet.*;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.jetty.jsp.JettyJspServlet;

public class SessionSetter extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        HttpSession session = req.getSession();
        Map<String,String[]> paramMap = req.getParameterMap();
        String jsp = null;

        for( Map.Entry<String, String[]> e : paramMap.entrySet() ) {
            String key = e.getKey();
            String val = e.getValue()[0];
            session.setAttribute(key, val);

            if(key.equals("jsp")) {
                jsp = val;
            }
        }

        if( jsp == null) { 
            throw new ServletException("Missing required param jsp");
        }

        req.getRequestDispatcher(jsp).forward(req,resp);
    }
}
