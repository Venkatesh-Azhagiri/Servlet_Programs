package com.scheduler;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.scheduler.mail.Mail;

public class SchedulerQuartz implements Job{
   

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		System.out.println("test scheduler running");
		
		Mail  m = new Mail();
		try {
			 m.sendMail();
			} catch (Exception e) {
			System.out.println("mail sending exception*****");
			e.printStackTrace();
		}
		
	}
}
