import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;


public class MapExample {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Map<String, String> geneMap = new LinkedHashMap<String, String>();
		
		geneMap.put("ABCA13", "Head and neck cancer");
		geneMap.put("ABCB5", "Head and neck cancer");
		geneMap.put("ABI3", "Head and neck cancer");
		geneMap.put("ADAMTS16", "Head and neck cancer");
		for(Map.Entry<String, String> map:geneMap.entrySet()){
			if(map.getKey().equalsIgnoreCase("ADAMTS16")){
				
			}
		}
	
	

	}

}
