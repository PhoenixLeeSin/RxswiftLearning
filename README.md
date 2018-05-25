# RxswiftLearning
## 时间：2018-05-19
## Xcode Version:Xcode 9
## Swift Version: swift 4.1
### *rxswift已经出了有一段时间，这个demo记录自己的学习过程，主要通过学习大神们的思想结合自己的练手项目强化知识的记忆，如有纰漏，望多指正\~\~ 联系Q：350541732*
### 模型代码
````
class FlightPlanModel: Object,Mappable {
@objc dynamic var flightId:String? = nil
@objc dynamic  var preparationId:Int = 1    //行前准备id
@objc dynamic  var flightNo:String? = nil      //航班号
@objc dynamic  var flightDate:String?  = nil       //航班日期
@objc dynamic  var arrivalTime:String?  = nil       //到岗时间
@objc dynamic  var enterTime:String?   = nil       //进场时间
@objc dynamic  var acType:String?    = nil          //机型
@objc dynamic  var acReg:String?    = nil          //机号
@objc dynamic  var flightVoyage:String?  = nil    //航线
@objc dynamic  var crewCount:String?   = nil         //机组人数
@objc dynamic  var captain:String?    = nil       //机长工号
@objc dynamic  var h001:String?     = nil           //乘务长工号
@objc dynamic var h001Name:String?   = nil         //乘务长姓名
var  h003 = List\<h003Model\>()           //乘务员3
@objc dynamic  var is3Certificate:String?  = nil     //3证
@objc dynamic  var isApperence:String?   = nil    //仪容仪表
@objc dynamic  var lateList:String?   = nil        //迟到人员列表
@objc dynamic  var planTime:String?    = nil      //计划时间
var crewBack = List\<crewBackModel\>() //
@objc dynamic  var h003List:String? = nil
@objc dynamic var flightStatus:String? = nil  //航班状态
@objc dynamic var  isUpdate:Int = 1  //乘务日志是否填写
   
required convenience init?(map: Map) {
self.init()
}
func mapping(map: Map)
{
preparationId \<- map["preparationId"]()
flightNo \<- map["flightNo"]()
flightDate \<- map["flightDate"]()
flightId \<- map["flightId"]()
arrivalTime \<- map["arrivalTime"]()
enterTime \<- map["enterTime"]()
acReg \<- map["acReg"]()
acType \<- map["acType"]()
flightVoyage \<- map["flightVoyage"]()
crewCount \<- map["crewCount"]()
captain \<- map["captain"]()
h001 \<- map["h001"]()
h001Name \<- map["h001Name"]()
h003 \<- (map["h003"]())
is3Certificate \<- map["is3Certificate"]()
isApperence \<- map["isApperence"]()
lateList \<- map["lateList"]()
planTime \<- map["planTime"]()
crewBack \<- (map["crewBack"]())
h003List \<- map["h003List"]()
flightStatus \<- map["flightStatus"]()
isUpdate \<- map["isUpdate"]()
}
override static func primaryKey()-\>String?{
return "preparationId"
}
}
````
#### 应该注意的是这里包含着嵌套模型，对于realm来说，暂时还没有解决好这个问题，但我在stockoverflow上发现了一个比较好的答案，详情参考名为“ListExtensions.swift”文件
### 填写航班任务 文件夹的主要内容为自定义View与数据的绑定  
## 路漫漫其修远兮 吾将上下而求索





