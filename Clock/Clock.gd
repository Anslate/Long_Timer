extends Control

var addr
var unix_time
var Timer_time = {"hour":0,"minute":0,"second":0}
var Timer_start = false

func _ready():
	#北京时间计算
	unix_time = OS.get_unix_time()+28800;
	var timeDict = OS.get_time();
	var dateDict = OS.get_date();
	$Real_time.text = "%02d:%02d:%02d" % [timeDict["hour"],timeDict["minute"],timeDict["second"]]
	$Real_Date.text = "%04d-%02d-%02d" % [dateDict["year"],dateDict["month"],dateDict["day"]]
	#读取计时器值
	var args = OS.get_cmdline_args()#文件位置	
	addr = Array(args).find("--addr")
	if(addr!=-1):
		addr = args[addr+1]
		var file = File.new()
		file.open(addr,File.READ)
		var text = file.get_as_text()
		file.close()
		Timer_time = JSON.parse(text).result
	$C.text = "%03d:%02d:%02d" % [Timer_time["hour"],Timer_time["minute"],Timer_time["second"]]
	#背景颜色
	var g = Array(args).find("--g")
	if(g!=-1):
		$Sprite.modulate = Color(0,1,0,1)
func _on_1s_timeout():
	#北京时间
	unix_time += 1
	var a = OS.get_datetime_from_unix_time(unix_time);
	$Real_Date.text = "%04d-%02d-%02d" % [a["year"],a["month"],a["day"]]
	$Real_time.text = "%02d:%02d:%02d" % [a["hour"],a["minute"],a["second"]]
	#计时器时间
	if(!Timer_start):
		return
	Timer_time["second"]+=1
	if(Timer_time["second"]==60):
		Timer_time["second"]=0
		Timer_time["minute"]+=1
	if(Timer_time["minute"]==60):
		Timer_time["minute"]=0
		Timer_time["hour"]+=1
	#实时保存
	#var file = File.new()
	#file.open(addr, File.WRITE)
	#file.store_string(JSON.print(Timer_time))
	#file.close()
	$C.text = "%03d:%02d:%02d" % [Timer_time["hour"],Timer_time["minute"],Timer_time["second"]]


func _on_Button_pressed():
	if(Timer_start):
		Timer_start=false
		$Button.text = "启动"
		$Button2.text="重置"
		if(addr!=-1):
			var file = File.new()
			file.open(addr, File.WRITE)
			file.store_string(JSON.print(Timer_time))
			file.close()
		return
	else:
		Timer_start=true
		$Button.text = "暂停"
		$Button2.text="重置"
		return

func _on_Button2_pressed():
	if($Button2.text!="确认"):
		$Button2.text="确认"
		return
	Timer_time = {"hour":0,"minute":0,"second":0}
	if(addr!=-1):
		var file = File.new()
		file.open(addr, File.WRITE)
		file.store_string(JSON.print(Timer_time))
		file.close()
	Timer_start=false
	$C.text = "%03d:%02d:%02d" % [Timer_time["hour"],Timer_time["minute"],Timer_time["second"]]
	$Button2.text="重置"
	$Button.text="启动"

func _notification(what):
	if(what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		if(addr!=-1):
			var file = File.new()
			file.open(addr, File.WRITE)
			file.store_string(JSON.print(Timer_time))
			file.close()
		get_tree().quit()
