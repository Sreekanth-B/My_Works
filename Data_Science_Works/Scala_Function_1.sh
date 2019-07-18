# Below function gives date which is 7 days past present date


spark-shell --conf spark.ui.port=2021<<EOF

import java.util.{Date,Calendar}

def getBeforeDate(maxDate: java.util.Date,days: Int): String = {
    var maxcal: Calendar = Calendar.getInstance()
    maxcal.setTime(maxDate)
    maxcal.add(Calendar.DATE, - days)
    val dateStringBefore48Weeks_X = maxcal.get(Calendar.YEAR)  + "-" + ( maxcal.get(Calendar.MONTH) +1) + "-" + maxcal.get(Calendar.DATE)
    dateStringBefore48Weeks_X
  }


val date= new Date

getBeforeDate(date,7)
