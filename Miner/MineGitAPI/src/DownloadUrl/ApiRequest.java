package DownloadUrl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;


import java.util.ArrayList;
import java.util.List;

public class ApiRequest {
	static ArrayList<SuspectProjects> projects=new ArrayList<SuspectProjects>();
	private final String USER_AGENT = "Mozilla/5.0";
	static String Path = "D:\\CorpusTest\\";
	static String langaugeG="Python";//Php,JavaScript,Java,Python,C#
	static String path="Python(1000-2000)";
	public static void writeToExcelFileDependency(ArrayList<SuspectProjects> listNotes, String excelFilePath)
			throws IOException {
		Workbook workbook = new HSSFWorkbook();
		Sheet sheet = workbook.createSheet();

		int rowCount = 0;

		for (SuspectProjects suspectProjects : listNotes) {
			Row row = sheet.createRow(++rowCount);
			writeDependency(suspectProjects, row);
		}

		try (FileOutputStream outputStream = new FileOutputStream(excelFilePath)) {
			workbook.write(outputStream);
		} finally {
			workbook.close();
		}
	}



	private static void writeDependency(SuspectProjects suspects, Row row) {
		Cell cell = row.createCell(1);
		cell.setCellValue(suspects.getFullname());

		cell = row.createCell(2);
		cell.setCellValue(suspects.getLanguage());

		cell = row.createCell(3);
		cell.setCellValue(suspects.creationDate);

		cell = row.createCell(4);
		cell.setCellValue(suspects.getUpdateDate());
		cell = row.createCell(5);
		cell.setCellValue(suspects.getStars());
		cell = row.createCell(6);
		cell.setCellValue(suspects.getWatchers());
		cell = row.createCell(7);
		cell.setCellValue(suspects.getOpen_issues_count());
		cell = row.createCell(8);
		cell.setCellValue(suspects.getSize());
		cell = row.createCell(9);
		cell.setCellValue(suspects.getSubscribers_count());
		cell = row.createCell(10);
		cell.setCellValue(suspects.getNetwork_count());
		String Languages="";
		String Counts="";
		for(int i=0;i<suspects.getLangaugeCount().size();i++){
			Languages+=suspects.getLangaugeCount().get(i).getName();
			Counts+=suspects.getLangaugeCount().get(i).getCount();
			if(i!=suspects.getLangaugeCount().size()-1){
				Languages+="/";
				Counts+="/";
				}
		}
		cell = row.createCell(11);
		cell.setCellValue(Languages);
		cell = row.createCell(12);
		cell.setCellValue(Counts);
		
		

				
	}

	/*
	 * @param Path=Storage Place for Corpus
	 * 
	 * @param LowerStarLimit = start Limit of Stars for Request
	 * 
	 * @param HigherStarLimit = Upper Limit of Star for Request
	 * 
	 * @param MaxStarLimit = Threshold limit
	 * 
	 * @param intervalLimit Interval Limit for Stars
	 */
	@SuppressWarnings("rawtypes")
	public static void main(String[] args) throws Exception {

		ApiRequest http = new ApiRequest();
		String acessToken ="badfac65e4e63fe72432f28bba6a729eff2db1ea";//"6394ffc8cd19c69af2706d59eb29d728b836c883";// "e504327b313af069d5744f0941244e650c257288";//"af13c51fa3b9d9ca95267a291cd36edb3ba32503" 
		String acessTokenSecond = "e6079cb8e5fa8076fa62b841f48c7bdf278739dd";//"d5aaf179249f5934bd1fa17b2aa2aec35e1d1b88"; 
		boolean alternate = true;
		int page = 1;
		int LowerStarLimit = 850;
		int HigherStarLimit = 950;
		int MaxStarLimit = 2500;
		Double count = 1.0;
		boolean first_time = true;
		int intervalLimit = 100;
		/*if (args.length == 5) {
		
			Path = args[0];
			LowerStarLimit = Integer.parseInt(args[1]);
			HigherStarLimit = Integer.parseInt(args[2]);
			MaxStarLimit = Integer.parseInt(args[3]);
			intervalLimit = Integer.parseInt(args[4]);

		}*/
  int i=0;
		try {
			while (HigherStarLimit <= MaxStarLimit) {
				
				if (count <= 0 || page == 10) {// If All Projects with in a
												// Criteria are done move to
												// next one
					LowerStarLimit = HigherStarLimit;
					HigherStarLimit += intervalLimit;
					page = 1;
					first_time = true;
				} else if (!first_time) {
					page++;
					System.out.println("Page:" + page + " Count: " + count);

				}
				String token = "";
				if (alternate)
					token = acessToken;
				else
					token = acessTokenSecond;
				alternate = !alternate;
				// TimeUnit.SECONDS.sleep(1);//Sleep for 1 Second
				Thread.sleep(100);
				String projectsReturnedJson = http.sendGet("https://api.github.com/search/repositories", token,
						"bearer", page, 100, LowerStarLimit, HigherStarLimit, "Maven");

				if (projectsReturnedJson.length() > 2) {
					Map proectsReturnedObject = new Gson().fromJson(projectsReturnedJson, Map.class);
					if (first_time) {// Get the count of Returned Objects only
										// for the first Page
						count = (Double) proectsReturnedObject.get("total_count");
						System.out.println("Count: " + count);
						first_time = false;
					}
					// Pages on the basis of Count
					for (int j = 0; j < ((ArrayList) proectsReturnedObject.get("items")).size(); j++) {
						// Go through Each Project returned on a Page
						//Main Link
						String releasesUrl = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("releases_url");
						String name = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items")).get(j))
								.get("name");
						String fullname = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items")).get(j))
								.get("full_name");
						
						String htmlUrl = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("html_url");
						String creationDate = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("created_at");
						String updateDate = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("updated_at");
						Double stars = (Double) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("stargazers_count");
						Double forks = (Double) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("forks");
						Double Scores = (Double) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("score");
						Double Watchers = (Double) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("watchers_count");
						Double open_issues_count = (Double) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("open_issues_count");
						Double size = (Double) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("size");
						String language = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("language");
						String languages_url = (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("languages_url");
						
				//	System.out.println( "languagesURL :"+languages_url);//+" network_count:"+network_count);
					
                        String urlOfProject= (String) ((LinkedTreeMap) ((ArrayList) proectsReturnedObject.get("items"))
								.get(j)).get("url");
                        
						String urlOfProjectWithAcessToken;
						if (alternate)
							urlOfProjectWithAcessToken = urlOfProject + "?" + "access_token=" + acessToken;
						else
							urlOfProjectWithAcessToken = urlOfProject + "?" + "access_token=" + acessTokenSecond;
						alternate = !alternate;
						// TimeUnit.SECONDS.sleep(1);//Sleep for 1 Second
						Thread.sleep(10);
						String projectsReturnedJsonFromLink ="";
						try{
						projectsReturnedJsonFromLink = http.sendGetReleases(urlOfProjectWithAcessToken);
						}
						catch(Exception e){
							continue;
						}
					//	 System.out.println(projectsReturnedJsonFromLink);
						Map proectsReturnedObjectFromLink = new Gson().fromJson(projectsReturnedJsonFromLink, Map.class);
						LinkedTreeMap lkm=((LinkedTreeMap) ( proectsReturnedObjectFromLink));
						Double subscribers_count = (Double) lkm.get("subscribers_count");
						Double network_count = (Double) lkm.get("network_count");
						//System.out.println("Subscriber :"+subscribers_count+" Network Count: "+network_count);
						String extraUrlWithToken="";
						if (alternate)
							extraUrlWithToken = languages_url + "?" + "access_token=" + acessToken;
						else
							extraUrlWithToken = languages_url + "?" + "access_token=" + acessTokenSecond;
						alternate = !alternate;
						Thread.sleep(100);

						 projectsReturnedJsonFromLink = http.sendGetReleases(extraUrlWithToken);
						 //System.out.println(projectsReturnedJsonFromLink);
						 List<LanguageCount> langaugeCount= new  ArrayList<LanguageCount>();
                        boolean flag=true;
						Map languages = new Gson().fromJson(projectsReturnedJsonFromLink, Map.class);
						for (Object eachLanguage : languages.entrySet())
						{
							int indexOfEqual=eachLanguage.toString().indexOf("=");
							if(indexOfEqual!=-1){
								
						    String eachLanguageName=eachLanguage.toString().substring(0, indexOfEqual);
						    Double eachLanguageCount= Double.parseDouble((eachLanguage.toString().substring( indexOfEqual+1)));
						    if(eachLanguageName!=null&&language.toLowerCase()!=null)
						    if(!eachLanguageName.toLowerCase().equals(language.toLowerCase()))
						    	{
						    	langaugeCount.add(new LanguageCount(eachLanguageName,eachLanguageCount));
						    	flag=!flag;
						    	}
						  
						//    System.out.println("Name: "+eachLanguageName +"----"+"Count:"+eachLanguageCount);
						    		
						}}
						if(flag){
							langaugeCount.add(new LanguageCount("0",0.0));
							  
						}
						SuspectProjects sp=new SuspectProjects(releasesUrl, name, fullname, htmlUrl, creationDate,
								updateDate,  stars,  forks,  Scores,  Watchers,  open_issues_count,
								 size,  language,  subscribers_count,  network_count,
								 langaugeCount) ;
						projects.add(sp);
						
						writeToExcelFileDependency(projects,"D:\\Scrapped("+path+").xls");
						print_Suspects(sp);
						i++;
						if(i==600)
							return;
					}
				}
				count -= 100;// Move To Next Page

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}
final static void print_Suspects(SuspectProjects sp){
	
	System.out.println(" Name :"+sp.getFullname()+" Creation Date:"+
sp.getCreationDate()+" Update Date"+sp.getUpdateDate()+" Stars: "+sp.getStars()
+" Forks:"+sp.getForks()+" Scores:"+sp.getScores()+" Watchers:"+sp.getWatchers()+" OpenIssues:"+sp.getOpen_issues_count()
+" Size:"+sp.getSize()+" Language:"+sp.getLanguage()
+" SubscriberCount:"+sp.getSubscribers_count()+" NetworkCount: "+sp.getNetwork_count());
	System.out.println(" Language:"+sp.getLanguage());
	System.out.println("Langauges Count: ");
	for(int i=0;i<sp.getLangaugeCount().size();i++){
		System.out.print(sp.getLangaugeCount().get(i).getName()+"---"+sp.getLangaugeCount().get(i).getCount()+"    ");
	}
	
System.out.println("\n----------");
}	
	/*
	 * Downloads The zip File with the Given version Name in The Given Folder
	 * 
	 * @param file
	 * 
	 * @param Folder
	 * 
	 * @param version
	 */
	
	/*
	 * Builds The Search Querry String Access Token Oath Autentication
	 * @param access_token
	 * @param token_type
	 * @param page
	 * @param per_page
	 * @param StarLowerLimit
	 * @param StarHigherLimit
	 * @param langauge
	 */
	String URI_BUILDER(String access_token, String token_type, int page, int per_page, int StarLowerLimit,
			int StarHigherLimit, String language) {
		String URI = "";
		URI += "access_token" + "=" + access_token;
		URI += "&";
		URI += "token_type" + "=" + token_type;
		URI += "&";
		URI += "page" + "=" + String.valueOf(page);
		URI += "&";
		URI += "per_page" + "=" + String.valueOf(per_page);
		URI += "&";
		URI += "q" + "=";
		// Comment The next Two Lines Here in case of Everything
		 URI += "language:"+langaugeG + "%20";
		//URI += "language:" + language + "%20";
		URI += "stars:" + String.valueOf(StarLowerLimit) + ".." + String.valueOf(StarHigherLimit);
		return URI;
	}

	/*
	 * Send Get Request to Releases
	 */
	// HTTP GET request
	private String sendGetReleases(String URL) throws Exception {
		String url = URL;
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("User-Agent", USER_AGENT);
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		return response.toString();
	}

	/*
	 * Sends Get Request to api_get_Repostiories
	 * @param access_token
	 * @param token_type
	 * @param page
	 * @param per_page
	 * @param StarLowerLimit
	 * @param StarHigherLimit
	 * @param langauge
	 */
	private String sendGet(String URL, String access_token, String token_type, int page, int per_page,
			int StarLowerLimit, int StarHigherLimit, String language) throws Exception {

		String url = URL;
		url += "?" + URI_BUILDER(access_token, token_type, page, per_page, StarLowerLimit, StarHigherLimit, language);// access_token=6394ffc8cd19c69af2706d59eb29d728b836c883&token_type=bearer&page=8&per_page=100&q=language:Java%20language:Maven%20stars:100..120";
		URL obj = new URL(url);
		System.out.println("\nURL--:" + url + "\n");
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("User-Agent", USER_AGENT);
		// int responseCode = con.getResponseCode();
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		return response.toString();
	}

}
