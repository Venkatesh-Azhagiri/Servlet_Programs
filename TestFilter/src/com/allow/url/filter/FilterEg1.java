package com.allow.url.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class FilterEg1
 */
public class FilterEg1 implements Filter {
	private ArrayList<String> urlList;
    /**
     * Default constructor. 
     */
    public FilterEg1() {
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
		System.out.println("list size*****"+urlList.size());
		if(urlList.contains(currentUrl)){
			allowedUrl = true;
		}
		
		if(!allowedUrl){
			System.out.println("testc");
			res.sendRedirect("sucess.jsp");
			
			//refer http://tutorials.jenkov.com/java-servlets/servlet-filters.html
			
		}
		chain.doFilter(request, response);
		
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
