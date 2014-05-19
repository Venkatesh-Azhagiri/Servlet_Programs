package com.scheduler.mail;
import java.io.StringWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.springframework.mail.javamail.JavaMailSenderImpl;


public class Mail {
	public void sendMail() throws Exception{
		String  server = "smtp.gmail.com";
		int port = 465;
		final String usr = "noreply@scigenom.com";
		final String pwd = "noreply!@#";
	 Properties props = new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.socketFactory.port", "465");
	props.put("mail.smtp.socketFactory.class",
			"javax.net.ssl.SSLSocketFactory");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.port", "465");
	

	Session session = Session.getDefaultInstance(props,
		new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(usr,pwd);
			}
		});
	try {
		JavaMailSenderImpl mail = new JavaMailSenderImpl();
		mail.setHost("smtp.gmail.com");
		mail.setPort(465);
		mail.setUsername(usr);
		mail.setPassword(pwd);
		
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress("from@no-spam.com"));
		message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse("venkatesha@scigenom.com"));
		message.setSubject("Testing Subject1");
		VelocityEngine ve = new VelocityEngine();
		ve.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
		ve.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
        ve.init();
        /*  next, get the Template  */
        Template t = ve.getTemplate( "/helloworld.vm" );
        /*  create a context and add data */
        VelocityContext context = new VelocityContext();
        context.put("name", "venkatesh");
        /* now render the template into a StringWriter */
        StringWriter writer = new StringWriter();
        t.merge( context, writer );
		message.setText(writer.toString());

		Transport.send(message);

		System.out.println("Done");

	} catch (MessagingException e) {
		throw new RuntimeException(e);
	}
	
	}
	
	

}
