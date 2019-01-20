

num=0
i=10150
path=0
file_name=0

while (true) do
	-- 循环体
	num=num+1
	if num > 100 then
		break
	end
	
	file_path="C:/Users/xiexianliang/Desktop/num/num"..num..".txt"
	file=io.open(file_path,"a")
	
	while true do
	-- 	if i > 10250 then
	-- 		break
	-- 	end

		path=path+1
		if path > 350 then
			path=0
			break
		end
		
		i=i+1
		for f=1,16 do
			str=i..","..path.."/"..f..".jpg"
			file:write(str.."\n")
		end
	end
	file:close()
end
--450151

print("写入完成")