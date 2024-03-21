// Joseph Reidy created the Filterscreen class to create a specific screen for the user to filter data, to be displayed subsequently on the main screen.

 public class Filterscreen
 {
   private ArrayList<Widget> filterWidgets;
   private int startDay = 0;
   private int startMonth = 0;
   private int startYear = 0;
   private int stopDay = 31;
   private int stopMonth = 12;
   private int stopYear = 3000;
   Filterscreen()
   {
     /*
     int startDay = EARLIESTDAY;
     int startMonth = EARLIESTMONTH;
     int startYear = EARLIESTYEAR;
     int stopDay = LASTDAY;
     int stopMonth = LASTMONTH;
     int stopYear = LASTYEAR;
     */
     filterWidgets = new ArrayList<>();
     
   }
   
   void draw()
   {
     text("Start Date: " + dateDisplay(startDay, startMonth, startYear), 2, 2);
     text("End Date" + dateDisplay(stopDay, stopMonth, stopYear),200,00);
   }
   void dateInput()
   {
     //code for user to input date  - startday,month,years and stopday,month,year is updated accordingly
   }
   
   String dateDisplay(int days, int months, int years)
   {
     return("" + days + "/" + months + "/" + years);
   }
   
   void widgetAdd(Widget newWidget)
   {
     filterWidgets.add(newWidget);
   }
   
   
   // get methods - Joseph Reidy 17:24 14/03/2024
   int getStartDay()
   {
     return startDay;
   }
   int getStartMonth()
   {
     return startMonth;
   }
   int getStartYear()
   {
     return startYear;
   }
   int getStopDay()
   {
     return startDay;
   }
   int getStopMonth()
   {
     return startMonth;
   }
   int getStopYear()
   {
     return startYear;
   }
 
 }
