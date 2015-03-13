//Downloaded from http://bl.ocks.org/matt-bernhardt/7443a60c67dd69d231d5

/* HTML Scraper via jSoup
 * ---
 * This takes a URL (at url in setup() )
 * and crawls the returned markup via the pattern defined in doc.select()
 * This version then dumps the resulting content into a text file
 * for further processing with Google Refine
 */
 
// Import libraries
import org.jsoup.safety.*;
import org.jsoup.examples.*;
import org.jsoup.helper.*;
import org.jsoup.*;
import org.jsoup.parser.*;
import org.jsoup.select.*;
import org.jsoup.nodes.*;
import java.io.IOException;

// Objects
PrintWriter output; // output file

// Init global variables
String url = "http://www.mlssoccer.com/schedule?month=all&year=2015&club=all&competition_type=46&broadcast_type=all&op=Search&form_id=mls_schedule_form";
int intYear = 2015;
ArrayList<Object> arrGames = new ArrayList<Object>();

void setup() {
  size(200,200);
  println("Setup started");
  
  scrapeSchedule();
  
  println("Setup finished");
}

void keyPressed() {
  // Abort operation
  println("!!! Abort - key pressed");
  exit(); // stops the program
}

void draw() {
  background(255);
}

void scrapeSchedule() {
  
  // create objects
  File input = new File("C:\\Users\\mjbernha\\Documents\\Processing\\html_scraper_schedule\\schedule_2015.html");
  Document doc;
  output = createWriter("schedule.csv");

  try {
    doc = Jsoup.parse(input, "UTF-8", "http://www.mlssoccer.com");
    // doc = Jsoup.connect(url).get();
  } catch (Exception e) {
    print(e);
    doc = null;
  }

  Elements page = doc.select("div.schedule-page");
    
  Elements games = page.select("h3, table tbody tr");
  
  String date = "";
  String time = "";
  String hTeam = "";
  String aTeam = "";
  String venue = "";
  
  for (Element element : games) {
    if(element.outerHtml().contains("h3")) {
      date = element.html();
    } else {
      time = element.select("div.field-game-date-start-time").html();
      hTeam = element.select("td.home-team div.field-home-team").html();
      aTeam = element.select("td.away-team div.field-away-team").html();
      venue = element.select("div.field-competition-venue").not("span.competition").html().replace("<span class=\"competetion\">MLS Regular Season</span>\n<br />at ","");
      output.println("\"" + date + " " + time + "\"," + hTeam + "," + aTeam + "," + venue);  
    }

  }
  
  println("fetched");
  output.flush();
  output.close();
}
