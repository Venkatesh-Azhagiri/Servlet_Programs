package com.session.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet Filter implementation class SessionFilter
 */
public class SessionFilter implements Filter {
	private ArrayList<String> urlList;
    /**
     * Default constructor. 
     */
    public SessionFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	
	
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		 
		String currentUrl= req.getServletPath();
		System.out.println("current url****"+currentUrl);
		boolean allowedUrl = false;
		System.out.println("list size*****"+urlList);
		if(urlList.contains(currentUrl)){
			System.out.println("contains");
			allowedUrl = true;
		}
		RequestDispatcher rd  = req.getRequestDispatcher("error.do");
		if(!allowedUrl){
			System.out.println("testc");
			/*System.out.println("testc");
			res.sendRedirect("sucess.jsp");*/
			rd.forward(req, res);			
			//refer http://tutorials.jenkov.com/java-servlets/servlet-filters.html
			
		}else{
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		String allowedUrl = fConfig.getInitParameter("allow");
		System.out.println("allowedUrl**** "+allowedUrl);
		StringTokenizer st = new StringTokenizer(allowedUrl, ",");
		urlList = new ArrayList<String>();
		while(st.hasMoreTokens()){
			urlList.add(st.nextToken());
			
		}
		
		
		
	}

}
