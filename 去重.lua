--去重.lua

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

function newfolder(path)
	--创建文件夹
	-- 参数说明：path为要创建文件夹的路径。
	-- 如要创建test文件夹，则输入：
	-- newfolder("/User/Media/TouchSprite/lua/test");
    os.execute("mkdir "..path);
end

function delFile(path)
	--删除文件
	--参数说明：path为要删除文件的路径，支持*通配符。
    os.execute("rm -rf "..path);
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
		-- 2015年08月27日 增加 ok 变量：只要是跳出的，ok 值必然为 true，非 true 必然是列完了整个文件，for 循环非 break 跳出
		-- 一念成佛，想不通的时候，换个思路解决问题
		return "结a束"
	end

	if fileRowArray == "" then
		return ""
	else
		return fileRowArray[column]
	end
end

--定义源文件路径
old_txt_file_path="/User/Media/TouchSprite/lua/txt/old.ini"

--定义去重后的文件路径
new_txt_file_path="/User/Media/TouchSprite/lua/txt/new.ini"


old_txt_file=io.open(old_txt_file_path,"r");


--读取一行需要对比的数据
ii=0 --对比数据所在行
while true do
	ii=ii+1
	line_txt=readFile(old_txt_file_path,ii,1,"aa")
	-- dialog(line_txt,1)
	-- mSleep(1500)

	if line_txt == "结a束" then
		--处理完所有数据
		break
	end

	
	--开始历遍文件
	repeated=false
	i=0
	for line_txt_temp in old_txt_file:lines() do
		i=i+1

		if i == ii then

		else
			if line_txt == line_txt_temp then
				repeated=true
				break
			end
		end
	end

	if repeated == false then
		--历遍文件没出现重复

		--开始记录不重复
		local file=io.open(new_txt_file_path,"a")
		file:write(line_txt)
		file:close()
		file=nil
	end
end

dialog("操作完成",0)


	-- --开始对比
	-- i=0
	-- while true do
	-- 	i=i+1

	-- 	if i == ii then;
	-- 		--防止和自己对比
	-- 		i=i+1;
	-- 	end;

	-- 	line_txt_temp=readFile(old_txt_file_path,i,1,"aa");

	-- 	if line_txt_temp == "结a束" then
	-- 		--对比到文件最后一行也没有重复的

	-- 		--开始记录不重复
	-- 		local file=io.open(new_txt_file_path,"a")
	-- 		file:write(line_txt)
	-- 		file:close()
	-- 		file=nil

	-- 		break
	-- 	end

	-- 	if line_txt == line_txt_temp then
	-- 		break
	-- 	end
	-- end