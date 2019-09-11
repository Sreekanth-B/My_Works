
// Below are the User Defined Functions to Convert the column values into new Measurements

// By using the each Funtion it will create Object where we can use it directly on Spark the data frame
	
================================================================================================================================================================================================

==============================================================================================================================================

def   convert= udf{
    (sourceUnit:String, paramName:String, actualValue:String) =>
     val finalresult=  (sourceUnit, paramName, actualValue) match {
        case (null|"NULL"|"null"|"",null|"NULL"|"null"|"",null|"NULL"|"null"|"")=>null
        case(x ,null|"NULL"|"null"|"" , y)=>null
        case(x ,y , null|"NULL"|"null"|"")=>null
        case( null|"NULL"|"null"|"" ,x , y)=>actualValue
        case _=>{
          if(targetUnitMap.contains(paramName)) {
            val tgt_Unit = targetUnitMap(paramName)
            var value: String = actualValue.toString.replaceAll(",", ".")

            val tryResult=Try((sourceUnit, tgt_Unit) match {
              case ("KPA"|"KPA_A"|"KPA_G", "KPA_G"|"KPA"|"KPA_A") => value
              case ("KPA_A"|"KPA"|"KPA_G", "INHG") => Pressure.kpaToInhg(value)
              case ("KPA"|"KPA_G"|"KPA_A", "PSI") => Pressure.kpaToPsi(value)
              case ("KPA"|"KPA_G"|"KPA_A", "BAR" | "BAR_A") => Pressure.kpaTobar(value)
              case ("INHG"|"INH", "KPA_G"|"KPA_A"|"KPA") => Pressure.inhgToKpa(value)
              case ("INHG"|"INH", "PSI") => Pressure.inhgToKpa(value)
              case ("MMHG","KPA_G"|"KPA_A"|"KPA") => Pressure.mmhgToKpa(value)
              case ("PSI"|"PSIA", "KPA_G"|"KPA_A"|"KPA") => Pressure.psiToKpa(value)
              case ("BAR" | "BAR_A", "BAR" | "BAR_A") => value
              case ("BAR"|"BAR_A", "KPA_G"|"KPA_A"|"KPA") => Pressure.barToKpa(value)
              case ("BAR" | "BAR_A", "PSI") => Pressure.barToPsi(value)
              case ("PSI","BAR" | "BAR_A") => Pressure.psiTobar(value)

              case ("INH2O", "KPA_G"|"KPA_A"|"KPA") => Pressure.inh2oToKpa(value)
              case ("INH2O", "PSI") => Pressure.inh2oToPsi(value)

              case("P"|"PERCENT"|"PERC"|"PERCE"|"PE"|"PERCENT","PERCENT") => value

              case ("KM" |"K"|"KM/HR"|"KMPH", "KM" |"KMPH") => value
              case ("MI" | "MPH", "KM" | "KM/HR"|"KMPH") => Speed.miToKm(value)
              case ("KM" | "KM/HR", "MI" | "MPH") => Speed.kmToMi(value)
              case ("M","KM") => Speed.mToKm(value)
              case ("REVS/MI","REVS/KM"|"REVSPKM") => Speed.revspmiTorevspkm(value)
              case ("KM/L","KMPL")=>value

              case ("GAL", "L"|"LITRE") => Volume.galToL(value)
              case ("L", "GAL") => Volume.lToGal(value)
              case ("IGAL", "L"|"LITRE") => Volume.iGalToL(value)
              case ("IGAL", "GAL") => Volume.iGalToGal(value)
              case("L","LITRE")=>value

              case ("MI/GAL"|"MPG", "KM/L"|"KMPL") => Distance.miPerGalToKmPerL(value)
              case ("MI/IGAL","KM/L"|"KMPL")=>Distance.miPerIGalToKmPerL(value)
              case ("KM/L", "MI/GAL") => Distance.kmPerLToMiPerGal(value)
              case ("L/100 KM","KMPL")=> Distance.ltsper100kmtoKmpl(value)

              case ("°C" | "DEG_C"|"C", "°C" | "DEG_C") => value
              case ("°F" | "DEG_F" |"F", "°C" | "DEG_C") => Temperature.fToC(value)
              case ("°C" | "DEG_C"|"C", "°F" | "DEG_F") => Temperature.cToF(value)

              case ("RP"|"RPM", "RPM") => value
              case ("KPRM", "RPM") => Torque.KprmToRpm(value)
              case ("RPM"|"RP"|"R", "KRPM") => Torque.rpmToKRpm(value)

              case ("FT3/S", "M3/S"|"CUMECS") => Distance.cubFtPSecToCubMPSec(value)
              case("M3/S","CUMECS")=>value

              case ("SECOND" | "S", "HOURS") => Time.secToHr(value)
              case ("HHHHHH:MM:SS" | "HH:MM:SS" | "HHHHHH:MM" | "HHHHHH" | "HHHH" |
                    "HHHHHH:MM:" | "HH" | "HHHHHH:" | "HHHHHH:M", "HOURS") => Time.timeToHr(value)
              case ("HHHHHH:MM:SS" | "HH:MM:" | "HH:MM:S" | "HH:" | "HHHHH"| "HH:MM:SS" | "HHHHHH:MM" | "HHHHHH" | "HHHH" |
                    "HHHHHH:MM:" | "HH" | "HHHHHH:" | "HHHHHH:M"|"HRS"|"HHH"|"HHHHHH:MM:S", "SECOND"|"S") => Time.timeToSec(value)

              case ("HP"|"H", "KW") => Power.hpToKw(value)
              case ("KW", "HP") => Power.kwToHp(value)
              case ("PS", "KW") => Power.psTokw(value)

              case ("V"|"VOLT"|"VOLTAGE","VOLT")=>value
              case ("S","SECOND")=>value
              case ("FT*LB","N_M") => Torque.ftPLbToNpM(value)
              case ("FT*LBF/S","N_MPSECOND") => Torque.ftPLbToNpM(value)
              case ("KGF*M","N_M") => Torque.kgFMToNpM(value)
              case ("N*M/S" ,"N_MPSECOND" ) => value
              case (x,y) if x.equalsIgnoreCase(y) => value
              case _ => null
            }
            )
            val result:String=tryResult match {
              case Success(v) =>
                if(v==null){
                  println("conversion formula not present",sourceUnit,tgt_Unit,paramName,actualValue)
                }
                v
              case Failure(e) =>
                println("conversion error Info from the exception: " +  e.getMessage,sourceUnit,tgt_Unit,paramName,actualValue)
                null
            }
            result
          }else
          {
            actualValue
          }
        }
      }
      finalresult
	}

	
================================================================================================================================================================================================
	  

def   convertToEnglish= udf{
    (sourceUnit:String, actualValue:String) =>
      val finalresult=  (sourceUnit, actualValue) match {
        case (null|"NULL"|"null"|"",null|"NULL"|"null"|"")=>null
        case(null|"NULL"|"null"|"" , y)=>null
        case(x ,null|"NULL"|"null"|"")=>null
        case _=>{
          if(metricToEnglishMap.contains(sourceUnit)) {
            val tgt_Unit = metricToEnglishMap.get(sourceUnit).mkString
            var value: String = actualValue.toString.replaceAll(",", ".")

            val tryResult=Try((sourceUnit, tgt_Unit) match {

              case (x,y) if x.equalsIgnoreCase(y) => value
              case ("KM" | "KM/HR"|"KMPH","MI" | "MPH") => Speed.kmToMi(value)
              case ("L"|"LITRE", "GAL") => Volume.lToGal(value)
              case ("SEC" | "S", "HOURS") => Time.secToHr(value)
              case ("KMPL", "MPGAL") => Distance.kmPerLToMiPerGal(value)
              case _ => null
            }
            )
            val result:String=tryResult match {
              case Success(v) =>
                if(v==null){
                  println("conversion formula not present",sourceUnit,tgt_Unit,actualValue)
                }
                v
              case Failure(e) =>
                println("conversion error Info from the exception: " +  e.getMessage,sourceUnit,tgt_Unit,actualValue)
                null
            }
            result
          }else
          {
            actualValue
          }
        }
      }
      finalresult
  }

 
================================================================================================================================================================================================

object Pressure extends Serializable{
    def inh2oToKpa(value: String): String =(value.toDouble * 0.2490).toString
    def mmhgToKpa(value: String): String= (value.toDouble *  0.1333).toString
    def barToKpag(value: String):String = ((value.toDouble * 100)-101.3).toString
    def psiToKpag(value: String):String = ((value.toDouble * 6.894)-101.3).toString
    def kpaToKpag(value: String): String =(value.toDouble - 101.3).toString
    def inhgToKpag(value: String): String =((value.toDouble * 3.386) - 101.3).toString
    def inhgToKpa(value:String):String = (value.toDouble * 3.386).toString
    def inhgToPsi(value:String):String = (value.toDouble * 0.49).toString
    def kpaToInhg(value:String):String = (value.toDouble * 0.2952).toString
    def barToKpa(value:String):String = (value.toDouble * 100).toString
    def kpaTobar(value:String):String = (value.toDouble / 100).toString
    def barToPsi(value:String):String = (value.toDouble * 14.50).toString
    def psiTobar(value:String):String = (value.toDouble / 14.50).toString
    def inh2oToPsi(value:String):String = (value.toDouble * 0.036).toString
    def psiToKpa(value:String):String = (value.toDouble * 6.894).toString
    def kpaToPsi(value:String):String = (value.toDouble * 0.145).toString
  }

  object Speed extends Serializable{
    def miToKm(value:String):String = (value.toDouble * 1.609).toString
    def mToKm(value:String):String= (value.toDouble*0.001).toString
    def kmToMi(value:String):String = (value.toDouble * 0.6213).toString
    def revspmiTorevspkm(value:String) :String = (value.toDouble / 1.609).toString
  }

  object Volume extends Serializable{
    def galToL(value:String):String = (value.toDouble * 3.785).toString
    def lToGal(value:String):String = (value.toFloat * 0.2641).toString
    def iGalToL(value:String):String = (value.toDouble * 1.2009 * 3.785).toString
    def iGalToGal(value:String):String = (value.toFloat * 1.2009).toString

  }

  object Temperature extends Serializable{
    def fToC(value:String):String = ((value.toDouble - 32) / 1.8).toString
    def cToF(value:String):String = ((value.toDouble * 9) / 5 + 32).toString

  }

  object Distance extends Serializable{
    def ltsper100kmtoKmpl(value: String): String = if(value.toDouble == 0.0) null else (100 / value.toDouble).toString
    def miPerGalToKmPerL(value:String):String = (value.toDouble * 0.425).toString
    def kmPerLToMiPerGal(value:String):String = (value.toDouble * 2.35214583).toString  //1 kpl = 2.352 US mpg
    def cubFtPSecToCubMPSec(value:String):String = (value.toDouble * 0.0283168).toString
    def miPerIGalToKmPerL(value:String):String = (value.toDouble*0.354).toString
  }

  object Time extends Serializable {
    def secToHr(value: String): String = (value.toDouble / 3600).toString
    def timeToHr(value: String): String = {
      val hhmmss = "\\d+:\\d+:\\d+".r
      val hhmm = "\\d+:\\d+:?".r
      val hh="\\d+.?\\d*:?".r
      value match {
        case hhmmss() => {
          val Array(hour, min, sec) = value.split(":")
          hour.toDouble + (min.toDouble/60.0) + (sec.toDouble/3600).toString
        }
        case hhmm() => {
          val Array (hour, min) = value.split(":")
          (hour.toDouble + (min.toDouble/60.0)).toString

        }
        case hh() => {
          val Array(hour) = value.split(":")
          hour.toDouble.toString
        }
        case _ => null
      }
    }
    //"HHHHHH:MM:SS" | "HH:MM:SS" | "HHHHHH:MM" | "HHHHHH" | "HHHH" |
    //                  "HHHHHH:MM:" | "HH" | "HHHHHH:" | "HHHHHH:M"
    def timeToSec(value: String): String = {
      val hhmmss = "\\d+:\\d+:\\d+".r
      val hhmm = "\\d+:\\d+:?".r
      val hh="\\d+.?\\d*:?".r
      value match {
        case hhmmss() => {
          val Array(hour, min, sec) = value.split(":")
          ((hour.toDouble*3600 )+ (min.toDouble*60.0) + sec.toDouble).toString
        }
        case hhmm() => {
          val Array (hour, min) = value.split(":")
          ((hour.toDouble*3600) + (min.toDouble*60.0)).toString

        }
        case hh() => {
          val Array(hour) = value.split(":")
          (hour.toDouble*3600).toString
        }
        case _ => null
      }
    }
  }
  object Power extends Serializable{
    def kwToHp(value:String):String = (value.toDouble * 1.3597).toString //1 kW = 1.359622 hp Metric HorsePower
    def hpToKw(value:String):String = (value.toDouble * 0.7457).toString
    def psTokw(value:String):String = (value.toDouble * 0.7355).toString
  }

  object Torque extends Serializable{
    def rpmToKRpm(value: String): String = (value.toDouble / 1000).toString
    def ftPLbToNpM(value:String):String = (value.toDouble * 1.36).toString
    def kgFMToNpM(value:String):String =  (value.toDouble * 9.807).toString
    def KprmToRpm(value:String):String = (value.toDouble * 1000).toString
  }
}


================================================================================================================================================================================================

EXAMPLE TO USE EACH FUNCTION BY CREATING THE USER DEFINED FUNCTION :


def lToGal = udf((value:String) => {

if (value != null) 
(value.toFloat * 0.2641).toString
else 
value
    })


def kmToMi = udf((value:String) => {

if (value != null) 
(value.toDouble * 0.6213).toString
else 
value
    })


def kmPerLToMiPerGal = udf((value:String) => {

if (value != null) 
(value.toDouble * 2.35214583).toString
else 
value
    })



def secToHr = udf((value:String) => {

if (value != null) 
(value.toDouble * 2.35214583).toString
else 
value
    })


=== Function to calculate the percentage value


    def getPercent = udf((param1: Double, param2: Double) => {
      val percent = param1*100 / param2
      if(percent != null && percent <= 100) percent        
      else 100.00
    })


================================================================================================================================================================================================

// USING THE ABOVE FUNCTIONS ON THE SPARK DATAFRAME:

// Creating Dataframe from hive table

val InfoDF = spark.sql("select * from database.table")


val InfoCalDF = InfoDF.withColumn("ConVerted_Column_1",lToGal($"Old_Column_1")).
      withColumn("ConVerted_Column_2",lToGal($"Old_Column_2")).
	  withColumn("ConVerted_Column_3", kmToMi($"Old_Column_3")).
      withColumn("ConVerted_Column_4", kmToMi($"Old_Column_4")).
	  withColumn("ConVerted_Column_5" , secToHr($"Old_Column_5")).
      withColumn("ConVerted_Column_6" , secToHr($"Old_Column_6")).

	  
// Renaming the column with new name 

val InfoCalDF_1 = InfoCalDF.withColumnRenamed("old_colname_1","New_Colname_1").
	  withColumnRenamed("old_colname_2","New_Colname_2")


	  
// joining two data frames based on two columns 
// Note : two columns must have same col names to join by using below command

val intermediateDF = InfoCalDF.join(InfoCalDF_1, Seq("Col_1", "Col_2"))


// Creating the column by dividing col_1/col_2 and inserting the resulted value percentage into final_col


val finalDF = intermediateDF.withColumn("final_col", when($"col_2" === 0, null).otherwise(getPercent($"col_1", $"col_2"))).
	withColumn("final_col", when($"col_2" === 0, null).otherwise(getPercent($"col_1", $"col_2"))).
	withColumn("final_col", when($"col_2" === 0, null).otherwise(getPercent($"col_1", $"col_2")))

// here we are checking weather denominator col_2 is 0 or not to overcome infinite value error
	
//   ***** Note :: By using withColumn option it will create new column with existing column. By the end of the result we will be having all the previuos columns inside dataframe.

// SO we perform selection of columns while writing the finalDf into ADLS or into Hive table

val finalDF = finalDF.select("col_1", "col_2","col_3",..)
     

      

================================================================================================================================================================================================
 
