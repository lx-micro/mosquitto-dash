JFile = "config.json"

local function DTread( data )
 if(file.open(JFile, "r")) then
	  ok, FV = pcall(cjson.decode, file.read())
	  file.close()
	  if(ok) then
	    ok = nil 
		ok, e = pcall(loadstring('if(FV.'..data..' ~= nil) then return FV.'..data..' else return nil end'))
		FV = nil
		if(ok and e ~= nil) then
			if (type(e) == "table" or e == nil or e == "") then
				e = nil
				msj = "La consulta devolvio un valor vacio"
			else				
				msj = ""
				return e
			end
		else
		   FV = nil
		   e = nil 	
		   return nil
		end	
	  else
		msj = "Error de codificación del archivo 'config.json'"
		FV = nil
		return nil	
	  end
  else
     file.close()
	 return nil
  end  
  msj = "No fue posible leer el archivo de configuracion"  
  return nil
end

local function DTsave(data, val)
  if(file.open(JFile, "r")) then
	ok, FV = pcall(cjson.decode, file.read())	
	file.close()	
	if(ok) then
	    ok = nil
		ok, rslt = pcall(loadstring('if(FV.'..data..' ~= nil) then FV.'..data..' = "'..val..'" return true else return false end'))
		if(ok and rslt) then
			if(file.open(JFile, "w+")) then
				file.write(cjson.encode(FV))				
				file.close()
				FV = nil
				return true
			else
				file.close()
				FV = nil
				return false
			end
			FV = nil
			return false
		else
		   FV = nil
		   return false	
		end
	else
      return false	
	end
  else
	file.close()
	return false
  end
return false 
end

local function DTadd(data, val)
  if(file.open(JFile, "r")) then
	ok, FV = pcall(cjson.decode, file.read())
	file.close()	
	if(ok) then
	    ok = nil
		ok, rslt = pcall(loadstring('if(FV.'..data..' == nil) then FV.'..data..' = "'..val..'" return true else return false end'))
		if(ok and rslt) then
			if(file.open(JFile, "w+")) then
				file.write(cjson.encode(FV))				
				file.close()
				FV = nil
				return true
			else
				file.close()
				FV = nil
				return false
			end
			FV = nil
			return false
		else
		   FV = nil
		   return false	
		end
	else
      return false	
	end
  else
	file.close()
	return false
  end
return false 
end

local function DTrm(data)
  if(file.open(JFile, "r")) then
	ok, FV = pcall(cjson.decode, file.read())
	file.close()	
	if(ok) then
	    ok = nil
		ok, rslt = pcall(loadstring('if(FV.'..data..' == nil or type(FV.'..data..') == "table") then return false else FV.'..data..' = nil return true end'))
		if(ok and rslt) then
			if(file.open(JFile, "w+")) then
				file.write(cjson.encode(FV))				
				file.close()
				FV = nil
				return true
			else
				file.close()
				FV = nil
				return false
			end
			FV = nil
			return false
		else
		   FV = nil
		   return false	
		end
	else
      return false	
	end
  else
	file.close()
	return false
  end
return false 
end

local function DTclr(data)
  if(file.open(JFile, "r")) then
	ok, FV = pcall(cjson.decode, file.read())
	file.close()	
	if(ok) then
	    ok = nil
		ok, rslt = pcall(loadstring('if(FV.'..data..' ~= nil) then FV.'..data..' = "" return true else return false end'))
		if(ok and rslt) then
			if(file.open(JFile, "w+")) then
				file.write(cjson.encode(FV))				
				file.close()
				FV = nil
				return true
			else
				file.close()
				FV = nil
				return false
			end
			FV = nil
			return false
		else
		   FV = nil
		   return false	
		end
	else
      return false	
	end
  else
	file.close()
	return false
  end
return false 
end

local function parse(data) 
  local str
  r_str = ""
  string.gsub(data, "(%w+)", function( s ) r_str = r_str .. '[{"'..s..'"}]' end);
  str = string.gsub(r_str, '"%}%]%[%{"', '.')
  r_str = nil
  str = string.gsub(str, '"%}%]', '')
  str = string.gsub(str, '%[%{"', '')
  if (type(str) == "table" or str == nil or str == "") then
    return nil
  else
	return str  
  end
  return nil
end

function json_read( par )
   local snd = parse( par )   
   if (type(snd) == "table" or snd == nil or snd == "") then
	return nil
   else
	return DTread( snd )   	
   end
   return nil   
end

function json_rm( par )
   local snd = parse(par)   
   if (type(snd) == "table" or snd == nil or snd == "") then
	return false
   else
	return DTrm(snd)   	
   end
   return false  
end

function json_clear( par )
   local snd = parse(par)   
   if (type(snd) == "table" or snd == nil or snd == "") then
	return false
   else
	return DTclr(snd)   	
   end
   return false   
end

function json_save(par, val)
   local snd = parse(par)
   if (type(snd) == "table" or snd == nil or snd == "") then
	return false
   else
	  if(val == nil or val == "") then
		return false
	  else	
		if(DTsave(snd, val)) then
			return true
		else
			return false
		end	
	  end   
   end
   return false
end

function json_add(par, val)
   local snd = parse(par)
   if (type(snd) == "table" or snd == nil or snd == "") then
	return false
   else
	  if(val == nil or val == "") then
		return false
	  else	
		if(DTadd(snd, val)) then
			return true
		else
			return false
		end	
	  end   
   end
   return false
end