package com.servletListener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.pojo.model.Dog.Dog;

/**
 * Application Lifecycle Listener implementation class ListenerEg1
 *
 */
@WebListener
public class ListenerEg1 implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public ListenerEg1() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0) {
    	System.out.println("test listener");
       ServletContext sc = arg0.getServletContext();
       String ctx = (String)sc.getInitParameter("breed");
       System.out.println("ctx*****"+ctx);
       Dog d = new Dog(ctx);
       sc.setAttribute("dog", d);
       
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    }
	
}
