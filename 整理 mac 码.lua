function Split(szFullString, szSeparator)
	-- 字符串分割函数
	-- szFullString 待分割字符串
	-- szSeparator 分割字符
	-- 返回一个 Table
	local nFindSmain_tartIndex = 1
	local nSplitIndex = 1
	local nSplimain_tarray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindSmain_tartIndex)  
	   if not nFindLastIndex then  
	    nSplimain_tarray[nSplitIndex] = string.sub(szFullString, nFindSmain_tartIndex, string.len(szFullString))  
	    break
	   end
	   nSplimain_tarray[nSplitIndex] = string.sub(szFullString, nFindSmain_tartIndex, nFindLastIndex - 1)  
	   nFindSmain_tartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplimain_tarray
end

function myRandom(n,m)
	-- 构造自己的随机函数
	-- 思路是用随机结果放大处理以后再置随机种子,然后随机
	-- n,m 随机数起止,返回 N 到 M 之间的随机数
	-- m 可用没有,如果没有,返回从1到 N 的随机数
	if m == nil then
		m=n
		n=1
	end

	math.randomseed(os.clock()*math.random(9999999,99999999)+math.random(9999999,99999999));
	return math.random(n,m)
end

function myRand(rnType,rnLen,rnUL)
	-- 随机字符串函数
	-- rnType 字符串样式，1、纯数字，2、手机号码，3、随机大小写字母，4、字母+数字，5、邮箱，6、16进制 7、生成62开头16位银行卡号
	-- rnLen 字符a串长度
	-- rnUL 字符串大小写（可选参数）1，字母全部大写，2，字母全部小写
	-- 返回:相应字符串
    local zmRan,HexRan,myrandS,rns
    rnLen=rnLen or 1
    rnUL=rnUL or 3
    rns=rns or 0 
    rns=rns+1
    zmRan={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
    HexRan={"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","A","B","C","D","E","F"}
    myrandS=""
    --myRandomseed(rns..tostring(os.time()):reverse():sub(1, 6))
    if rnType==1 then
    	--生成纯数字
        myrandS=myRandom(9)
        for r1=1,rnLen-1 do
            myrandS=myrandS..myRandom(0,9)
        end
    elseif rnType==2 then 
    	--生成13开头和15开头的手机号
        local mheader={"13","15","18"}
        myrandS=mheader[myRandom(#mheader)]
        for r1=1,9 do
            myrandS=myrandS..myRandom(0,9)
        end
    elseif rnType==3 then
    	--生成大小写随机字母
        for r1=1,rnLen do
            myrandS=myrandS..zmRan[myRandom(52)]
        end
    elseif rnType==4 or rnType==5 then 
    	--rnType==4的时候，生成前2到5位是字母，后面是数字的字母+数字字符串组合
    	--rnType==5的时候，把==4得到的字符串后面加邮箱地址
        local rn3=myRandom(2,5)
        for r1=1,rn3 do
             myrandS=myrandS..zmRan[myRandom(52)]
        end
        for r1=1,rnLen-rn3 do
            myrandS=myrandS..myRandom(0,9)
        end
        if rnType==5 then
            local mailheader={"@qq.com","@hotmail.com","@sohu.com"} 
            myrandS=myrandS..mailheader[myRandom(#mailheader)]
        end
    elseif rnType==6 then
    	--生成16进制
        myrandS=HexRan[myRandom(2,22)]
        for r1=1,rnLen-1 do
            myrandS=myrandS..HexRan[myRandom(22)]
        end
    elseif  rnType == 7 then
    	--生成62开头16位银行卡号
    	myrandS="62"
    	for r1=1,14 do
    		myrandS=myrandS..myRandom(0,9)
    	end
    end

    if rnUL==1 then
        return string.upper(myrandS)
        --字母全部大写
    elseif rnUL==2 then
        return string.lower(myrandS)
        --字母全部小写
    else
        return myrandS
    end
end

function click(x,y,z)
	-- 适用于触动精灵点击函数
	-- x,y 点击位置 x 坐标和 y 坐标
	-- z 点击后停留时间(毫秒)
	-- 返回:无返回
    touchDown(1,x,y)
    mSleep(100)
    touchUp(1,x,y)

    if z ~= nil then
    	mSleep(z)
    end
end

function isColor(x,y,c1,wc)
	-- 适用于触动精灵的找色函数
	-- x,y 找色点的 x 坐标和 y 坐标
	-- c1 要找的颜色
	-- wc 找色精度
	-- 返回值: 找到色返回 true,找不到返回 false
    if wc == nil then
        wc=0
    end
    
    r, g, b = getColorRGB(x, y);
    local r1=math.modf(c1/65536);
    local g1=math.modf(c1/256)%256;
    local b1=c1%256;

    if math.abs(r-r1)<=wc and math.abs(g-g1)<=wc and math.abs(b-b1)<=wc then
        return true
    else
        return false
    end
end

function delFile(path)
	--删除文件
	--参数说明：path为要删除文件的路径，支持*通配符。
    os.execute("rm -rf "..path);
end

function newfolder(path)
	--创建文件夹
	-- 参数说明：path为要创建文件夹的路径。
	-- 如要创建test文件夹，则输入：
	-- newfolder("/User/Media/TouchSprite/lua/test");
    os.execute("mkdir "..path);
end

function readFile(filePath,row,column,Separator)
	-- filePath 文件路径 字符串
	-- row 行 数字
	-- column 列 数字
	-- Separator 分割符 字符串 千万不要用 "-"
	--[[
	本函数使用说明：
	首先把需要读取文件路径赋值给变量“filePath”
	如：qqNumberFilePath = "/User/Media/TouchSprite/lua/magic/03配置.ini"
	a=readFile(qqNumberFilePath,1,1)
	a的值为，文件03配置.ini里面第一行，第一列的值
	qqNumberFilePath 变量名可以随意
	行和列也可以随意
	这样就可以很简单的获取文件里的任意值，让代码的结构变简单
	]]

	local file=io.open(filePath,"r")
	if not(file) then
		return "文件不存在"
	end
	local currentLine=1
	local ok = false;
	for fileRow in file:lines() do
 		if currentLine == row then
			fileRowArray=Split(fileRow,Separator)
			ok=true
			break
		else
			currentLine=currentLine+1
		end
	end
	fileRow=nil
	file:close()
	file=nil

	if ok == false then
		-- 上面的 for 循环，如果执行了 break 那么必然 currentLine == row
		-- 如果 currentLine ~= row 应该是文件的行数没有需要的行数多，文件被读完了一遍，还没到需要的行数，自然跳出了
		-- 2015年08月27日 增加 ok 变量：只要是跳出的，ok 值必然为 true，非 true 必然是列完了整个文件，for 循环自然完成
		-- 一念成佛，想不通的时候，换个思路解决问题
		return "结a束"
	end

	if fileRowArray == "" then
		return ""
	else
		return fileRowArray[column]
	end
end

function writeFile(filePath,write_type,content)
	-- 写文件函数
	-- filePath 字符串 文件路径
	-- write_type 字符串 写入方式 "w" 覆盖写入 "a" 追加写入
	-- content 字符串 写入内容
	if content == nil then
		conten=" "
	end

	local file=io.open(filePath,write_type);

	if file ~= nil then
		file:write(content)
		file:close()
		file=nil
	end
end

function getList(path)
	-- 遍历文件
	-- 参数说明：path为要列举文件的文件夹的路径。
	-- 返回值：返回一个table。
	-- 如要列举触动精灵lua文件夹下所有的脚本文件，则输入：
	-- list = getList("/User/Media/TouchSprite/lua/");
    local a = io.popen("ls "..path);
    local f = {};
    for l in a:lines() do
        table.insert(f,l)
    end
    return f
end

function get_bid()
	-- 显示包名函数
	mSleep(5000)
	bid = frontAppBid()
	mSleep(1000)
	dialog(bid,0)
end

function Preferences( ... )
	-- 重置设置函数
	--开始重置设置
	runApp("com.apple.Preferences")
	mSleep(4000)
	closeApp("com.apple.Preferences")
	mSleep(4000)
	--重置 设置 完成
end

function get_iphone_type()
	-- 获取运行设备分辨率及系统版
	iphone_type=""

	width, height = getScreenSize();

	if width == 640 and height == 1136 then
	    --iPhone 5, 5S, iPod touch 5
		dialog("设备是<iphone5系列>",1)
		mSleep(1500)
		iphone_type="iphone5"	    
	elseif width == 640 and height == 960 then
		--iPhone 4,4S, iPod touch 4
		dialog("设备是<iphone4>",1)
		mSleep(1500)
		iphone_type="iphone4"
	elseif width == 1242 and height == 2208 then
		--iphone6p
		dialog("设备是<iphone6p>",1)
		mSleep(1500)
		iphone_type="iphone6p"
	elseif width == 750 and height == 1334 then
		-- iphone6
		dialog("设备是<iphone6>",1)
		mSleep(1500)
		iphone_type="iphone6"
	elseif width == 320 and height == 480 then
	    --iPhone 非高分屏
	elseif width == 768 and height == 1024 then
	    --iPad 1,2, mini 1
	elseif width == 1536 and height == 2048 then
	    --iPad 3,4,5, mini 2
	end

	return iphone_type
end

function airModel_5()
	-- 适用于 iphone5分辨率 飞行模式函数
	runApp("com.apple.Preferences")
	mSleep(3000)
	color = getColor(526, 241);
	if color == 0xffffff then
		click(548,239)
		mSleep(4000)
	end
	click(548,239)
	mSleep(5000)
	closeApp("com.apple.Preferences")
	mSleep(1000)
end

function airModel_4(status)
	-- 适用于 iphone4分辨率 分辨率函数
	runApp("com.apple.Preferences")
	mSleep(5000)

	if status == "on" then
		if isColor(537, 238, 0xffffff) then
			--飞行模式关闭的正常联网状态
			click(537, 238)--点击打开飞行模式
			mSleep(6000)
			for i=1,60 do
				if isColor(530, 239, 0x4cd864) then
					break
				else
					mSleep(1000)
				end
			end
		end
	end

	if status == "off" then
		if isColor(530, 239, 0x4cd864) then
			--飞行模式 打开的状态
			click(537, 238)--点击关闭 飞行模式
			mSleep(1000*10)
			for i=1,60 do
				if isColor(537, 238, 0xffffff) or isColor(65, 223, 0x995900) then
					--isColor(65, 223, 0x995900)出现未安装好 sim 卡提示
					break
				else
					mSleep(1000)
				end
			end

			if isColor(65, 223, 0x995900) then
				--出现未安装好 sim 卡提示
				click(321, 533)--点好
				mSleep(1000)
			end
		end
	end		

	if status == nil then
		--打开再关闭飞行模式
		click(537, 238)--点击打开飞行模式
		mSleep(7000)
		click(537, 238)--点击关闭飞行模式
		mSleep(1000*10)
		if isColor(65, 223, 0x995900) then
			--出现未安装好 sim 卡提示
			click(321, 533)--点好
			mSleep(1000)
		end
	end

	closeApp("com.apple.Preferences")
	mSleep(2000)
end

function http_get(url)
	-- 调用插件 http get 方式访问网络 函数
	loadPlugin("NetworkTools")
	local result = callPlugin("NetworkTools", "httpGet", url)
	unloadPlugin("NetworkTools")

	if result == "!HTTP GET ERROR" then
		dialog("访问"..url.."失败,将重试",3)
		mSleep(3000)
		return http_get(url)
	else
		return result
	end
end

function ftp_download(ftp_path,save_path)
	-- ftp 下载函数
	-- ftp_path 待下载文件路径
	-- save_path本地保存路径
	-- 下载成功返回 true 失败返回 fales
	local sz = require("sz")
	local ftp = sz.ftp

	-- ftp_path="ftp://lua:lua@202.146.219.111/resource/open47.png"
	-- save_path="/User/Media/TouchSprite/res/open47.png"

	_, err = ftp.download(ftp_path,save_path)
	if err then
	    dialog(ftp_path.."下载文件失败", 1);
	    mSleep(1000);
	    return false;
	else
	    dialog(ftp_path.."文件已下载成功", 1)
	    mSleep(1000);
	    return true;
	end
end

function vpn_5()
	-- 重播 vpn
	dialog("开始设置VPN", 1)
	mSleep(1000)

	openURL("prefs:root=General&path=VPN");  --打开VPN界面

	for i=1,10 do
		if isColor(21,83,0x007aff) then
			mSleep(1000)
			break
		else
			mSleep(1000)
		end
	end

	-- 到vpn 设置界面

	click(537,282,3000); -- 关闭
	click(537,282,3000); -- 打开
	for i=1,60 do
		if isColor(194,293,0x000000) then
			mSleep(1000)
		else
			mSleep(1000)
			break
		end
	end

	closeApp("com.apple.Preferences")
	mSleep(2000)
	--关闭设置完成
end

function vpn_4( ... )
	runApp("com.apple.Preferences")
	mSleep(5000)

	mSleep(1000);
	touchDown(1,10,900);
	mSleep(1000);
	for i=0,700,10 do
		touchMove(1,10,900-i);
		mSleep(20);
	end
	mSleep(1000);
	touchUp(1,10,200);
	mSleep(1000)
	-- 开始找 通用
	keepScreen(true);
	y=0;
	for i=130,950,6 do
		if (isColor(34,i,0x34aadc,0)) then;
			y=i-88
			mSleep(1000);
			break
		end
	end
	keepScreen(false);

	click(34,y,3000); -- 点通用
	--滑动两次寻找VPN
	for i=1,2 do
		mSleep(1000);
		touchDown(1,10,900);
		mSleep(1000);
		for i=0,700,10 do
			touchMove(1,10,900-i);
			mSleep(20);
		end
		mSleep(1000);
		touchUp(1,10,200);
		mSleep(1000)
	end

	click(61,678,3000)--点击VPN

	if isColor(534,239,0x4cd864) then--vpn打开
		click(534,239,2000)--点vpn开关  关闭
	end
	
	if isColor(535,242,0xffffff) then --vpn关闭
		local times=0
		while true do
			times=times+1
			if times == 10 then
				break
				dialog("vpn连接失败，请检查！",0)
				dialog("退出脚本",0)
				lua_exit()
			end

			click(535,242,1000)--点vpn开关-打开
			for i=1,60 do
				if isColor(534,239,0x4cd864) then
					mSleep(1000)
					-- 连接成功
					break
				elseif isColor(533,79,0x949494) then
					-- 出现弹窗
					click(318,559,1000); -- 好
					break
				else
					mSleep(1000)
				end
			end

			if isColor(534,239,0x4cd864) then
				break
			end
		end
	end
	closeApp("com.apple.Preferences")
	mSleep(2000)
end

dialog("开始",1)
mSleep(1500)


--定义源文件路径
old_txt_file_path="/User/Media/TouchSprite/lua/mac2/old/"

--定义新生成的文件路径
new_txt_file_path="/User/Media/TouchSprite/lua/mac2/new/"

--定义文件名文件路径
file_name_file_path="/User/Media/TouchSprite/lua/mac2/2.ini"

sz = require("sz")

name_id=0
is_over=false
while true do
	name_id=name_id+1

	file_name=readFile(file_name_file_path,name_id,1,"中文")
	file_name=file_name:atrim()

	old_file_path=old_txt_file_path..file_name
	
-- 	dialog(old_file_path, 0)
-- 	mSleep(1500)
	
	row_i=0; -- 当前读取行号
	i=0; -- 有效行

	file_error=false
	while true do
		row_i=row_i+1
		row_string=readFile(old_file_path,row_i,1,"分割符");--获取整行内容
		-- string.sub(s,i,j)      函数截取字符串s的从第i个字符到第j个字符之间的串
		if row_string == "结a束" then
			-- 读取完一个文件
			break
		end

		if row_string == "文件不存在" then
			--读完所有文件
			is_over=true
			break
		end

		bb=0
		first_word=string.sub(row_string,1,1); --获取得到这行的第一个字符
		if first_word == "-" then
			bb=2
			first_word=string.sub(row_string,3,3);
		end
		first_word=tonumber(first_word)
		
		if first_word ~= nil then
			i=i+1

			new_row_string=string.sub(row_string,38,-1); -- 读取后面有用的内容
			-- 把有用的内容赋值给字符串
			if i == 1 then
				Gq3489ugfi=new_row_string
				if Gq3489ugfi == nil or Gq3489ugfi == "" then
					Gq3489ugfi=" "
				end
			elseif i == 2 then
				Fyp98tpgj=new_row_string
				if Fyp98tpgj == nil or Fyp98tpgj == "" then
					Fyp98tpgj=" "
				end
			elseif i == 3 then
				kbjfrfpoJU=new_row_string
				if kbjfrfpoJU == nil or kbjfrfpoJU == "" then
					kbjfrfpoJU=" "
				end
			elseif i == 4 then
				IOPlatformSerialNumber=new_row_string
				if IOPlatformSerialNumber == nil or IOPlatformSerialNumber == "" then
					IOPlatformSerialNumber=" "
				end				
			elseif i == 5 then
				IOPlatformUUID=new_row_string
				if IOPlatformUUID == nil or IOPlatformUUID == "" then
					IOPlatformUUID=" "
				end
			elseif i == 6 then
				board_id=new_row_string
				if board_id == nil or board_id == "" then
					board_id=" "
				end
			elseif i == 7 then
				product_name=new_row_string
				if product_name == nil or product_name == "" then
					product_name=" "
				end
			elseif i == 8 then
				ROM_System_ID=new_row_string
				if ROM_System_ID == nil or ROM_System_ID == "" then
					ROM_System_ID=" "
				end
			elseif i == 9 then
				MLB=new_row_string
				if MLB == nil or MLB == "" then
					MLB=" "
				end
			elseif i == 10 then
				oycqAZloTNDm=new_row_string
				if oycqAZloTNDm == nil or oycqAZloTNDm == "" then
					oycqAZloTNDm=" "
				end
			elseif i == 11 then
				abKPld1EcMni=new_row_string
				if abKPld1EcMni == nil or abKPld1EcMni == "" then
					abKPld1EcMni=" "
				end
			end
		else
			-- print(first_word)
			-- print("非数字")
		end
	end

	if is_over == true then
		break
	end

	--dialog(product_name,0)

	if file_error == false then

		--开始处理每一个字符串
		--Model: =product_name
		if product_name ~= nil then			
			product_name=string.sub(product_name,15,-1)
			Model="              Model: "..product_name.."\r\n"
		else
			Model="              Model: ".."\r\n"
		end

		--Board-id: =board_id
		if board_id ~= nil then
			board_id=string.sub(board_id,11,-1)
			Board_id="           Board-id: "..board_id.."\r\n"
		else
			Board_id="           Board-id: ".."\r\n"
		end

		--SerialNumber: =IOPlatformSerialNumber
		if IOPlatformSerialNumber ~= nil then
			IOPlatformSerialNumber=string.sub(IOPlatformSerialNumber,25,-1)
			SerialNumber="       SerialNumber: "..IOPlatformSerialNumber.."\r\n"
		else
			SerialNumber="       SerialNumber: ".."\r\n"
		end

		--Hardware UUID: =IOPlatformUUID
		if IOPlatformUUID ~= nil then
			IOPlatformUUID=string.sub(IOPlatformUUID,17,-1)
			Hardware_UUID="      Hardware UUID: "..IOPlatformUUID.."\r\n\r\n"
		else
			Hardware_UUID="      Hardware UUID: ".."\r\n\r\n"
		end

		--System-ID:=ROM_System_ID
		if ROM_System_ID ~= nil then
			System_ID="          System-ID: "..string.sub(ROM_System_ID,1,36).."\r\n"
		else
			System_ID="          System-ID: ".."\r\n"
		end

		--ROM =ROM_System_ID
		if ROM_System_ID ~= nil then
			ROM="                ROM: "..string.sub(ROM_System_ID,44,51)..string.sub(ROM_System_ID,53,56).."\r\n"
		else
			ROM="                ROM: ".."\r\n"
		end


		--BoardSerialNumber =MLB
		if MLB ~= nil then
			BoardSerialNumber="  BoardSerialNumber: "..string.sub(MLB,43,-1).."\r\n\r\n"
		else
			BoardSerialNumber="  BoardSerialNumber: ".."\r\n\r\n"
		end

		--Gq3489ugfi=Gq3489ugfi
		if Gq3489ugfi ~= nil then
			Gq3489ugfi_temp=string.sub(Gq3489ugfi,14,-2)
			Gq3489ugfi_temp=Gq3489ugfi_temp:atrim()
			Gq3489ugfi="         Gq3489ugfi: "..Gq3489ugfi_temp.."\r\n"
		else
			Gq3489ugfi="         Gq3489ugfi: ".."\r\n"
		end

		--Fyp98tpgj=Fyp98tpgj
		if Fyp98tpgj ~= nil then
			Fyp98tpgj_temp=string.sub(Fyp98tpgj,13,-2)
			Fyp98tpgj_temp=Fyp98tpgj_temp:atrim()
			Fyp98tpgj="          Fyp98tpgj: "..Fyp98tpgj_temp.."\r\n"
		else
			Fyp98tpgj="          Fyp98tpgj: ".."\r\n"
		end

		--kbjfrfpoJU=kbjfrfpoJU
		if kbjfrfpoJU ~= nil then
			kbjfrfpoJU_temp=string.sub(kbjfrfpoJU,14,-2)
			kbjfrfpoJU_temp=kbjfrfpoJU_temp:atrim()
			kbjfrfpoJU="         kbjfrfpoJU: "..kbjfrfpoJU_temp.."\r\n"
		else
			kbjfrfpoJU="         kbjfrfpoJU: ".."\r\n"
		end

		--oycqAZloTNDm=oycqAZloTNDm
		if oycqAZloTNDm ~= nil then
			oycqAZloTNDm_temp=string.sub(oycqAZloTNDm,16,-2)
			oycqAZloTNDm_temp=oycqAZloTNDm_temp:atrim()
			oycqAZloTNDm="       oycqAZloTNDm: "..oycqAZloTNDm_temp.."\r\n"
		else
			oycqAZloTNDm="       oycqAZloTNDm: ".."\r\n"
		end

		--abKPld1EcMni=abKPld1EcMni
		if abKPld1EcMni ~= nil then
			abKPld1EcMni_temp=string.sub(abKPld1EcMni,16,-2)
			abKPld1EcMni_temp=abKPld1EcMni_temp:atrim()
			abKPld1EcMni="       abKPld1EcMni: "..abKPld1EcMni_temp.."\r\n\r\n"
		else
			abKPld1EcMni="       abKPld1EcMni: ".."\r\n\r\n"
		end


		--开始写新文件
		new_file_path=new_txt_file_path..file_name
		
		writeFile(new_file_path,"a",Model)
		writeFile(new_file_path,"a",Board_id)
		writeFile(new_file_path,"a",SerialNumber)
		writeFile(new_file_path,"a",Hardware_UUID)

		writeFile(new_file_path,"a",System_ID)
		writeFile(new_file_path,"a",ROM)
		writeFile(new_file_path,"a",BoardSerialNumber)

		writeFile(new_file_path,"a",Gq3489ugfi)
		writeFile(new_file_path,"a",Fyp98tpgj)
		writeFile(new_file_path,"a",kbjfrfpoJU)
		writeFile(new_file_path,"a",oycqAZloTNDm)
		writeFile(new_file_path,"a",abKPld1EcMni)
	end
end

dialog("完成",0)
lua_exit()






