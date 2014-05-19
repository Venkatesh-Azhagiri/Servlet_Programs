package com.scheduler.servlet;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.SimpleScheduleBuilder;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;

import com.scheduler.SchedulerQuartz;

/**
 * Servlet implementation class Servlet1
 */
public class Servlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Servlet1() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
   /* public void init(){
    	System.out.println("init1");
    	SchedulerFactory schFact = new org.quartz.impl.StdSchedulerFactory();
    	System.out.println("init");
    	try{
    	System.out.println("try");
    	Scheduler sched = schFact.getScheduler();
    	JobDetail job = new JobDetail("job1", "group1", Scheduler.class);
    	CronTrigger trigger = new CronTrigger("trigger1", "group1", "job1", "group1", "* 0/1 * * * ?");
    	sched.addJob(job, true);
    	sched.start();
    	}catch(Exception e){
    		System.out.println("exception");
    		e.printStackTrace();
    	}
    }*/
	
    @Override
	public void init() throws ServletException {
    	System.out.println("init1");
    	SchedulerFactory schFact = new org.quartz.impl.StdSchedulerFactory();
    	System.out.println("init");
    	try{
    	System.out.println("try");
    	Scheduler sched = schFact.getScheduler();
    	JobDetail job = JobBuilder.newJob(SchedulerQuartz.class)
    			.withIdentity("dummyJobName", "group1").build();
    	
    	Trigger trigger = TriggerBuilder
    			.newTrigger()
    			.withIdentity("dummyTriggerName", "group1")
    			.withSchedule(
    			    SimpleScheduleBuilder.simpleSchedule()
    				.withIntervalInSeconds(15).repeatForever())
    			.build();
    	//sched.addJob(job, true);
    	sched.start();
    	sched.scheduleJob(job, trigger);
    	
    	}catch(Exception e){
    		System.out.println("exception");
    		e.printStackTrace();
    	}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("get");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	
}
