package com.xiaomu.util
{
	public class TimeFormat
	{
		/**
		 * 时间格式化
		 */
		public function TimeFormat()
		{
//			var str:String = "2019-04-10T06:43:55.000Z";
//			trace(JSON.stringify(getTimeObj(str))); ///{"date":"2019-04-10 14:43:55","time":1554878635000}
		}
		
		public static function getTimeObj(str:String):Object
		{
			if(!str){
				return {"time":'',"date":0}
			}
			var newStr:String = str.substr(0,10)+" "+str.substr(11,8);
			var beijingTime:Number = Date.parse(convertDateStr(newStr))+60*60*8*1000;
			var date : Date = new Date(beijingTime);
			var fullyear:String = date.getFullYear()+"";
			var month:String = (date.getMonth()+"").length<2?("0"+(date.getMonth()+1)):((date.getMonth()+1)+"");
			var day :String = (date.getDate()+"").length<2?("0"+date.getDate()):(date.getDate()+"");
			var hour :String = (date.getHours()+"").length<2?("0"+date.getHours()):(date.getHours()+"");
			var minute :String = (date.getMinutes()+"").length<2?("0"+date.getMinutes()):(date.getMinutes()+"");
			var second :String = (date.getSeconds()+"").length<2?("0"+date.getSeconds()):(date.getSeconds()+"");
			var dateFormat : String = fullyear+"-"+month+"-"+day
				+" "+hour+":"+minute+":"+second
			return {"time":beijingTime,"date":dateFormat}
		}
		
		public static function convertDateStr(dateStr:String):String{
			var strArr:Array = dateStr.split(" ");
			var fStr:String = "{0} {1} {2}";
			return format(fStr, (strArr[0] as String).split("-").join("/"), strArr[1], "GMT");
		}
		public static function format(str:String, ...args):String{
			for(var i:int = 0; i<args.length; i++){
				str = str.replace(new RegExp("\\{" + i + "\\}", "gm"), args[i]);
			}
			return str;
		}
	}
}