

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<String> fileList = getImagesFromPath(0, 0, "");
		//System.out.println("imagePath*****"+fileList);
		RequestDispatcher rd = request.getRequestDispatcher("gallery.jsp");
		request.setAttribute("imagesLocationList", fileList);
		rd.forward(request, response);
		
	}
	public List<String> getImagesFromPath (int samNum, int rootNum, String relativePath){
		List<String> fileList = new ArrayList<String>();
		Properties properties = new Properties();
		InputStream inputStream = Servlet1.class.getResourceAsStream("application.properties");
		try {
			properties.load(inputStream);
		} catch (IOException e) {
			//System.out.println("exception****");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("properties****"+properties);
		if (properties == null) return null;
		String imagePath  = properties.get("image-path").toString();
		//System.out.println("imagePathj*****"+imagePath);
		File folder = new File(imagePath);
		
		//System.out.println("called****"+folder.isDirectory());
		if(folder.isDirectory()){
			//System.out.println("true");
			File[] listOfFiles = folder.listFiles();
			for (int i = 0; i < listOfFiles.length; i++){		 
			   if (listOfFiles[i].isFile()){
				   //System.out.println("image path*****"+"image"+imagePath+listOfFiles[i].getName());
				   fileList.add("image"+imagePath+listOfFiles[i].getName());
			   }
			 }
		}
		return fileList;
	}
	
	/*
	 	public List<String> getImagesFromPath (String samNum, String relPath){
		List<String> fileList = new ArrayList<String>();
		Properties properties = dbConPool.getConf(SamDBConfigConstants.APP_PROPERTY_FILE_NAME);
		if (properties == null) return null;
		String imagePath  = properties.get("samdb-image-path").toString();
		String context = properties.get("folder-prefix").toString();
		
		File folder = new File(imagePath + relPath + context+samNum);
		
		System.out.println("called***"+"NUM-"+samNum);
		if(folder.isDirectory()){
			System.out.println("true");
			File[] listOfFiles = folder.listFiles();
			for (int i = 0; i < listOfFiles.length; i++){		 
			   if (listOfFiles[i].isFile()){
				   fileList.add("image"+imagePath+relPath+context+String.valueOf(samNum)+"/" + listOfFiles[i].getName());
			   }
			 }
		}
		return fileList;
	}
	 */
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
