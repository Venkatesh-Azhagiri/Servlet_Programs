package com.scigenom.util;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.zip.GZIPInputStream;
import java.util.zip.ZipInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.namespace.QName;

import org.apache.xmlbeans.XmlCursor;
import org.apache.xmlbeans.XmlError;
import org.apache.xmlbeans.XmlException;
import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlOptions;

import com.scigenom.webservices.employeeDetailRQ.EmployeeDetailRQDocument;
import com.scigenom.webservices.employeeDetailRQ.EmployeeDetailRQDocument.EmployeeDetailRQ;
import com.scigenom.webservices.employeeDetailRS.EmployeeDetailRSDocument;
import com.scigenom.webservices.employeeDetailRS.EmployeeDetailRSDocument.EmployeeDetailRS;
import com.scigenom.webservices.employeeDetailRS.EmployeeDetailRSDocument.EmployeeDetailRS.EmployeeInfo;
import com.scigenom.webservices.employeeDetailRS.EmployeeDetailRSDocument.EmployeeDetailRS.EmployeeInfo.Employee;

public class MeganWSUtil {

	public StringBuilder returnReqXMLStringFrmStream(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("Megan Class test6");
		StringBuilder strRequestXml = new StringBuilder();
		try {
			String strReqXML = "";
			InputStream inpXML = req.getInputStream();
			// InputStream inpXML =
			// IOUtils.toInputStream(req.getParameter("data").toString());
			GZIPInputStream GinpXML = null;
			ZipInputStream zipIn = null;
			BufferedInputStream bis = null;

			String encoding = req.getHeader("content-encoding");
			req.setCharacterEncoding("UTF-8");
			String strEncodedType = req.getCharacterEncoding();

			bis = new BufferedInputStream(inpXML);
			System.out.println("inpXML****" + inpXML);
			//System.out.println("bis***" + bis.read());
			/*
			 * Reading the xml file content from input stream
			 */
			int x;
			while ((x = bis.read()) != -1) {
				// System.out.println("x***"+x);
				strRequestXml.append((char) x);
			}
			if (strRequestXml != null) {
				System.out.println("before string***"
						+ strRequestXml.toString());
				strReqXML = URLDecoder.decode(strRequestXml.toString(),
						strEncodedType);
				strRequestXml = new StringBuilder();
				strRequestXml.append(strReqXML);
				System.out.println("strRequestXml s***"
						+ strRequestXml.toString());
			}

			bis.close();
			inpXML.close();

		} catch (Exception e) {
			System.out.println("catch block****");
			e.printStackTrace();
		}
		try {
			EmployeeDetailRQ employeeDetailRQ = validateEmployeeDetailRQXml(strRequestXml.toString());
			printOutput(getEmployeeInfoResponseDocument(employeeDetailRQ.getEmployeeInfo().getEmployee().getEmployeeID()), req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strRequestXml;
	}

	public EmployeeDetailRQ validateEmployeeDetailRQXml(
			String employeeDetailRQXml) throws XmlException {

		ArrayList validationErrors = new ArrayList();// contains validation
														// errors
		XmlOptions validationOptions = new XmlOptions();// used for validation
		validationOptions.setErrorListener(validationErrors);
		EmployeeDetailRQDocument employeeDetailRQDocument; // request xml
															// document
		boolean isValid = false; // contains true if its valid
		StringBuilder strXMLErBld = new StringBuilder(); // contains xml errors
		XmlError xmlErr = null; // contains xml errors


			employeeDetailRQDocument = EmployeeDetailRQDocument.Factory
					.parse(employeeDetailRQXml);

			isValid = employeeDetailRQDocument.validate(validationOptions);

			

				// getting the bean from jar file
				EmployeeDetailRQDocument.EmployeeDetailRQ employeeDetailRQBean = employeeDetailRQDocument
						.getEmployeeDetailRQ();

				
				return employeeDetailRQBean;
			

			/*strXMLErBld = new StringBuilder(
					"\n The Cancellation Ws Request XML Error Details as follows, \n ");
			for (int i = 0; i < validationErrors.size(); i++) {
				xmlErr = (XmlError) validationErrors.get(i);
				strXMLErBld
						.append("\t Message: " + xmlErr.getMessage() + "\n ");
				if (xmlErr.getObjectLocation() != null) {
					strXMLErBld.append("\t Error Tag: "
							+ xmlErr.getObjectLocation().getDomNode()
									.getNodeName() + "\n ");
				}
			}

			xmlErr = null;
			validationErrors = null;
			throw new XmlException("Invalid Cancellation Request XML"
					+ strXMLErBld.toString());

		} catch (XmlException xmlExp) {

			throw new XmlException("Cancellation Request XML is Invalid:"
					+ xmlExp.toString());
		}*/

	}
	
	public EmployeeDetailRS validateEmployeeDetailRSXml(
			String employeeDetailRSXml) throws XmlException {

		ArrayList validationErrors = new ArrayList();// contains validation
														// errors
		XmlOptions validationOptions = new XmlOptions();// used for validation
		validationOptions.setErrorListener(validationErrors);
		EmployeeDetailRSDocument employeeDetailRSDocument; // request xml
															// document
		boolean isValid = false; // contains true if its valid
		StringBuilder strXMLErBld = new StringBuilder(); // contains xml errors
		XmlError xmlErr = null; // contains xml errors

		try {

			employeeDetailRSDocument = EmployeeDetailRSDocument.Factory
					.parse(employeeDetailRSXml);

			isValid = employeeDetailRSDocument.validate(validationOptions);

			if (isValid) {

				// getting the bean from jar file
				EmployeeDetailRSDocument.EmployeeDetailRS employeeDetailRSBean = employeeDetailRSDocument
						.getEmployeeDetailRS();

				if (employeeDetailRSBean == null) {

				}
				return employeeDetailRSBean;
			}

			strXMLErBld = new StringBuilder(
					"\n The Cancellation Ws Request XML Error Details as follows, \n ");
			for (int i = 0; i < validationErrors.size(); i++) {
				xmlErr = (XmlError) validationErrors.get(i);
				strXMLErBld
						.append("\t Message: " + xmlErr.getMessage() + "\n ");
				if (xmlErr.getObjectLocation() != null) {
					strXMLErBld.append("\t Error Tag: "
							+ xmlErr.getObjectLocation().getDomNode()
									.getNodeName() + "\n ");
				}
			}

			xmlErr = null;
			validationErrors = null;
			throw new XmlException("Invalid Cancellation Request XML"
					+ strXMLErBld.toString());

		} catch (XmlException xmlExp) {

			throw new XmlException("Cancellation Request XML is Invalid:"
					+ xmlExp.toString());
		}

	}
	
	public String getEmployeeInfoResponseDocument(int employeeId) {
		EmployeeDetailRSDocument employeeDetailRSDocument = EmployeeDetailRSDocument.Factory.newInstance();
		addSchemaLocation(employeeDetailRSDocument, "http://www.scigenom.com/Webservices/EmployeeDetailRS/megan/webservice/EmployeeDetailRS.xsd");
		EmployeeDetailRS employeeDetailsRS = employeeDetailRSDocument.addNewEmployeeDetailRS();
		EmployeeInfo employeeInfo = employeeDetailsRS.addNewEmployeeInfo();
		Employee employee = employeeInfo.addNewEmployee();
		if(employeeId == 100) {
			employee.setID(new Byte("100"));
			employee.setName("Muthu Narayanan");
			employee.setEmailAddress("muthun@scigenom.com");
			employee.setMobileNo(94437);
		} else if (employeeId == 101) {
			employee.setID(new Byte("101"));
			employee.setName("Venkatesh");
			employee.setEmailAddress("venkatesha@scigenom.com");
			employee.setMobileNo(94437);
		} else if (employeeId == 102) {
			employee.setID(new Byte("102"));
			employee.setName("Mohanasundaram");
			employee.setEmailAddress("mohanasundaramh@scigenom.com");
			employee.setMobileNo(94437);
		}
		try {
			validateEmployeeDetailRSXml(employeeDetailRSDocument.toString());
		} catch (XmlException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return  employeeDetailRSDocument.toString();
		
		
	}
	
	 public void printOutput(String strResponse, HttpServletRequest req,
	            HttpServletResponse res) throws Exception {
	       
	        //Code changed for case id:12028 starts here
	        StringBuffer strRes =new StringBuffer();
	        String strXmlVerTxt ="<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
	        
	       
	        strRes.append(strXmlVerTxt).append(strResponse);
	      
	        if (strResponse == null) {
	            throw new Exception("Response Not Available");
	        } else {
	                res.setContentType("text/xml");
	                System.out.println("**********");
	        		System.out.println(strRes);
	        		System.out.println("**********");
	                PrintWriter pw = res.getWriter();
	                pw.println(strRes);
	          
	          
	        }
	    }
	 
	 
	 public void addSchemaLocation(XmlObject xmlObject, String location) {
			XmlCursor cursor = xmlObject.newCursor();
			if (cursor.toFirstChild()) {

				cursor.setAttributeText(new QName("http://www.w3.org/2001/XMLSchema-instance",
						"schemaLocation"), location);

			}
		}

}
