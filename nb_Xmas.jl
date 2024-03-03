### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 6d500b52-3931-47c4-81fb-01056b68106a
begin	
	import Pkg
	using  Pkg
		
 	Pkg.activate(mktempdir())
	
	Pkg.add(["HTTP",
		     "BufferedStreams",
		     "PlutoUI", 
		     "HypertextLiteral", 
		     "LaTeXStrings", 
		     "OffsetArrays", 
             "Formatting", 
		     "BenchmarkTools",
	         #"DataFrames", 
	         #"PlutoTest",
	         "Handcalcs",
	         "AbstractPlutoDingetjes"])
	
	using HTTP, 
	      BufferedStreams,
	      PlutoUI, 
	      HypertextLiteral, 
	      LaTeXStrings, 
	      OffsetArrays, 
	      Formatting, 
	      BenchmarkTools,
	     # DataFrames,
	     # PlutoTest,
	      Handcalcs,
	      AbstractPlutoDingetjes

	
	
	
	md"""	
	⬅️ 📦 $(html"<b>packages</b>") 📦
	"""
end

# ╔═╡ 992e042f-e6db-47b0-a07f-93e9447287d7
# GaGa: Gaede's Garbage
module GaGa

using PlutoUI, HTTP, BufferedStreams, OffsetArrays, Formatting#, DataFrames

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Timothy R. Gaede
# 2021-09-30

#= ToDo

function array(typeOrObj, dims;  typeLiteral=false)
function array(typeOrObj, dim1, dim2;  typeLiteral=false)
function array(typeOrObj, dim1, dim2, dim3;  typeLiteral=false)

=#


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function vecStrFrom_url(url)
	response = HTTP.get(url)

	str = String(response.body)

	vecSubstr_n = split(str, "\n")
	vecSubstr_rn = split(str, "\r\n")

	if length(vecSubstr_n) == length(vecSubstr_rn)
		vecSubstr = vecSubstr_rn
	else
		vecSubstr = vecSubstr_n
	end

	if last(vecSubstr) == "";   pop!(vecSubstr);    end
 
	res = Vector{String}(undef, length(vecSubstr))

	for i in eachindex(vecSubstr)
		res[i] = String(vecSubstr[i])
	end

	
	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function vecStrFrom_path(path)	
	
	res = String[]

	f = open(path)
	 
 
	open(path) do f
		for (i, line) in enumerate(eachline(f))
			push!(res, line)
		end
	end	
	 
	# Remove any end-of-file character ⋅⋅⋅⋅⋅⋅⋅
	if last(res) != ""
		if last(res) == "\x1a"
			pop!(res)
		elseif last(last(res)) == '\x1a'
			res[end] = res[end][1:end-1]
		end
	end
	# ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅

	close(f)


	
	res 
end


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function vecStrFrom(path_or_url)

	try VecStrFrom_path(path_or_url)

	catch thrown # thrown <: Exception

		vecStrFrom_url(path_or_url)

	end

end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function toFile(vecStr::AbstractVector{String}, fileName::String)	
 
	res = open(fileName, "w")

	#open(fileName) do file	 
	for i in firstindex(vecStr) : (lastindex(vecStr) - 1)		 
		data = write(res, vecStr[i]*"\n")
	end
 	data = write(res, last(vecStr))

	close(res)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPRECATE!!!!!!!!
function VecStr_from_url(url)
	
	res = String[]	
	 
	# HTTP.jl package needed ⋅⋅⋅⋅
	HTTP.open("GET", url) do io
		for line in eachline(io)
			push!(res, line)
		end
	end	
	# ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅


	
	
	# Remove any end-of-file character ⋅⋅⋅⋅⋅⋅⋅
	if last(res) != ""
		if last(res) == "\x1a"
			pop!(res)
		elseif last(last(res)) == '\x1a'
			res[end] = res[end][1:end-1]
		end
	end
	# ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅

	
	
	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function VecStr_from_path(path)	
	
	res = String[]

	f = open(path)
	 
 
	open(path) do f
		for (i, line) in enumerate(eachline(f))
			push!(res, line)
		end
	end	
	 
	# Remove any end-of-file character ⋅⋅⋅⋅⋅⋅⋅
	if last(res) != ""
		if last(res) == "\x1a"
			pop!(res)
		elseif last(last(res)) == '\x1a'
			res[end] = res[end][1:end-1]
		end
	end
	# ⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅⋅

	close(f)


	
	res 
end



function array(typeOrObj, dims)
	
	msgOffset = "In function array(dType, dims): \n\n" *
                "The value for argument, dims was $dims. \n" *
			    "To have an index less than 1, Try: \n" *
				"1) Downloading the package, OffsetArrays.jl 🙂 \n" *
	            "2) Re-run function array(dType, dims)."
	
	isType = nothing
	isObj  = nothing
	dType  = nothing
	obj    = nothing
	try
		typeOrObj <: Any
		
		isObj  = false
		isType = true
		dType = typeOrObj
		
	catch thrown
		
		isObj  = true
		isType = false
		dType = typeof(typeOrObj)
		obj   = typeOrObj
	end
		
	
	 
	if typeof(dims) <: UnitRange{Int} 
		
		if first(dims) !== 1 # OffsetArrays.jl needed
			
			try # Maybe we already have OffsetArrays.jl
				if isObj
					if obj == 0
						return zeros(dType, dims)
					else
						
						result = OffsetArray{dType}(undef, dims)
						for idx in eachindex(result)
							result[idx] = obj
						end
						return result
						
					end
				else
					return OffsetArray{dType}(undef, dims)
				end
				
			 
			catch thrown # We do NOT have OffsetArrays.jl  	
				#throw(thrown)
				throw(ArgumentError(msgOffset))
			end
			
			
			
			
		else # no need for OffsetArrays.jl
			if isObj
				if obj == 0
					return zeros(dType, last(dims))
				else
					
					result = Vector{dType}(undef, last(dims))
					for idx in eachindex(result)
						result[idx] = obj
					end
					return result
	 
				end				
				
			 
			else
				return Vector{dType}(undef, last(dims)) 
			end			 
		end
		 
		
	elseif typeof(dims) <: Base.OneTo{Int64}
		
		if isObj
			if obj == 0
				return zeros(dType, last(dims))
			else

				result = Vector{dType}(undef, last(dims))
				for idx in eachindex(result)
					result[idx] = obj
				end
				return result

			end	

		else
			return Vector{dType}(undef, last(dims)) 
		end			 
		 	
		
	elseif typeof(dims) <: Int 
		
		
		if isObj	
			
			if obj == 0	 
				return zeros(dType, dims)
			else

				result = Vector{dType}(undef, dims)
				for idx in eachindex(result)
					result[idx] = obj
				end
				return result
			end
				
				
		else
			return Vector{dType}(undef, dims)
		end		
		 			
			
		
	elseif typeof(dims) <: Vector  ||  typeof(dims) <: NTuple	
		
		if typeof(first(dims)) <: UnitRange{Int}
			 
			# Find a range that does not start with 1 ---------------
			offsetIndexFound = false
			for dim in dims
				if first(dim) !== 1;   offsetIndexFound = true;   end
			end
			# -------------------------------------------------------
			
			 
			if offsetIndexFound # OffsetArrays.jl needed
				 
				try # Maybe we already have OffsetArrays.jl
					
					if isObj
						if obj == 0  
							result = zeros(dType, dims...)
						else
							
							result = OffsetArray{dType}(undef, dims...)
							for idx in eachindex(result)
								result[idx] = obj
							end							
							
						end
						
						 
					else				
						result = OffsetArray{dType}(undef, dims...)					
					end


					return result

				catch thrown # We do NOT have OffsetArrays.jl 
					
					
					throw(thrown)
					throw(ArgumentError(msgOffset))		
				end
				
			else # all ranges begin with 1:
				dims′ = [last(dim)   for dim in dims]
				
				
				
				if isObj
					if obj == 0
					
					
						return zeros(dType, dims′...)
					else
						
						result = Array{dType, length(dims)}(undef, dims′...)
						for idx in eachindex(result)
							result[idx] = obj
						end
						return result						
						
					end
				
				
				else					
					return Array{dType, length(dims)}(undef, dims′...)				
				end

			end
			
		
		elseif typeof(first(dims)) <: Int		
		 
			if isObj
				if obj == 0
					return zeros(dType, dims...)
				else
				result = Array{dType, length(dims)}(undef, dims...)	
					for idx in eachindex(result)
						result[idx] = obj
					end
					return result
				end
				
				 			
			else
				return Array{dType, length(dims)}(undef, dims...) 
			end
			
			
		end
	end
	 
	
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
getLines(url) = getVecStr(url)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# DEPRECATED!
# See: vecStrFrom_url(url)

function getVecStr(url)
	
	result = String[]	
	 
	# HTTP.jl package needed
	HTTP.open("GET", url) do io
		for line in eachline(io)
			push!(result, line)
		end
	end	
	 
	# Remove any end-of-file character ........
	if last(result) !== ""
		if last(result) == "\x1a"
			pop!(result)
		elseif last(last(result)) == '\x1a'
			result[end] = result[end][1:end-1]
		end
	end
	# .........................................
	
	result
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~







#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function showText(line::String, gap=0)
		
	width = (gap+1)*(length(line) - 1)
	
	txt = " "^gap * line * " "^gap
	
	TextField((width, 1), txt)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function showText(vecStr::Vector{String};    spacing=1,     gap=0,
                                             width=nothing, height=nothing,              										     leftMargin=0,  rightMargin=0,
										     topMargin=0,   botMargin=0)

	fi, li = firstindex, lastindex
	 
	ℓ = length
	
	if ℓ(vecStr) == 0
		msg = "⚠️ No text to display! ⚠️"
		w = ℓ(msg) + 1
		return PlutoUI.TextField((w, 1), msg)
	end
		
	
	txt = "\n"^(topMargin + 1)	  

	if gap == 0
		for i in fi(vecStr) : (li(vecStr) - 1) 
			txt *= " "^leftMargin * vecStr[i] * " "^rightMargin * "\n"^spacing
		end
		txt *= " "^leftMargin * last(vecStr) * " "^rightMargin
	else
		for r in fi(vecStr) : (li(vecStr) - 1)
			txt *= " "^leftMargin
			for c in fi(vecStr[r]) : (li(vecStr[r]) - 1)
				txt *= vecStr[r][c] * " "^gap
			end
			txt *= last(vecStr[r]) * " "^rightMargin * "\n"^spacing
		end
		
		r = li(vecStr)
		txt *= " "^leftMargin
		for c in fi(vecStr[r]) : (li(vecStr[r]) - 1)
			txt *= vecStr[r][c] * " "^gap
		end
		txt *= last(vecStr[r]) * " "^rightMargin
 
		 
	end
 	txt *= "\n"^botMargin
	

	if width == nothing
		wid = (gap+1)*(maximum(map(x -> ℓ(x), vecStr)) - 1) + 
		      leftMargin + rightMargin
	else
		wid = width
	end

	if height == nothing
		hgt = (ℓ(vecStr) - 1) * spacing + 
		       topMargin + botMargin + 2
	else
		hgt = height
	end
		
	
	
	PlutoUI.TextField((wid, hgt), txt)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Not refined!
function showTextContig(vecVecStr::Vector{Vector{String}};    
                       innerSpacing=1,                                                                      outerSpacing=2,   
                       width=nothing, height=nothing,              										   leftMargin=0,  rightMargin=0,
                       topMargin=0,   botMargin=0)

    fi, li = firstindex, lastindex

    ℓ = length

    if ℓ(vecVecStr) == 0
        msg = "⚠️ No text to display! ⚠️"
        w = ℓ(msg) + 1
        return PlutoUI.TextField((w, 1), msg)
    end


    widMax = 0


    txt = "\n"^(topMargin + 1)	  
    hgtCnt = topMargin


    for i in fi(vecVecStr) : (li(vecVecStr) - 1)
		vecStr = vecVecStr[i]
        for str in vecStr
			line = " "^leftMargin * str * " "^rightMargin * "\n"^innerSpacing
            txt *= line
            if (length(line) - 1) > widMax
                widMax = length(line) - 1
            end
        end
        hgtCnt += length(vecStr)*(innerSpacing) + outerSpacing
        txt *= "\n"^outerSpacing
    end

    
	for str in last(vecVecStr)
		line = " "^leftMargin * str * " "^rightMargin * "\n"^innerSpacing
		txt *= line
		if (length(line) - 1) > widMax
			widMax = length(line) - 1
		end
	end
	hgtCnt += length(last(vecVecStr))*(innerSpacing)
	 
   

	

    hgtCnt += botMargin + 1

	width == nothing ?  wid = widMax  :  wid = width   

    height == nothing ?  hgt = hgtCnt :  hgt = height
     



    PlutoUI.TextField((wid, hgt), txt)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~












#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function showText(vec::Vector;    spacing=1, gap=0, width=nothing, height=nothing)
	
	vecStr = ["$item"    for item in vec] # map(x -> string(x),    vec)
	
 	showText(vecStr, spacing=spacing, gap=gap, width=width, height=height)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function showText(vecInts::Vector{T};   
                  spacing=1, onePerLine = false,
                  gap=4,
                  width=nothing, height=nothing,
                  leftMargin=0,  rightMargin=0,
				  topMargin=0,   botMargin=0) where T <: Integer
	
	
	vecStrRaw = ["$item"    for item in vecInts] # map(x -> string(x),    vecInts)
	widMax = maximum([length(str)   for str in vecStrRaw])
	if onePerLine	
		vecStr = [lpad(strRaw, widMax)    for strRaw in vecStrRaw]
		wid = widMax
	else
		width == nothing ?  wid = 91  :  wid = width
		numPerLine = (wid+gap) ÷ (widMax+gap)
		numFullLines = length(vecInts) ÷ numPerLine

		numInFullLines = numPerLine * numFullLines
		
		if numInFullLines == length(vecInts)
			R = numFullLines
		else
			R = numFullLines + 1
			numInLastLine = length(vecInts) - numInFullLines
		end

		vecStr = Vector{String}(undef, R) 
		
		for r in 1:numFullLines
			str = ""
			for c in 1:numPerLine-1
				i = (r-1)*numPerLine + c
				str *= lpad(vecStrRaw[i], widMax) * " "^gap
			end
			i = r*numPerLine
			str *= lpad(vecStrRaw[i], widMax)

			vecStr[r] = str
		end
		if numFullLines != R
			str = ""
			for c in 1:numInLastLine - 1
				i = (R-1)*numPerLine + c
				str *= lpad(vecStrRaw[i], widMax) * " "^gap
			end
			str *= lpad(last(vecStrRaw), widMax)
			
			
			vecStr[R] = str
		end
	end
	
	
 	showText(vecStr, spacing=spacing, width=wid, height=height)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Index range independent

function showText(mtx::AbstractMatrix{Char};    spacing=1, gap=0, 
								                width=nothing, height=nothing,
										        leftMargin=0,  rightMargin=0,
										        topMargin=0,   botMargin=0)
										        #widthMargin=0, heightMargin=0)



	txt = "\n"^(topMargin + 1)
	
	r̃, c̃ = axes(mtx)	 
	
	
	for r in first(r̃) : (last(r̃) - 1)
	
		txtLine = " "^leftMargin	
		for c in first(c̃) : (last(c̃) - 1)
			txtLine *= mtx[r, c] * " "^gap
		end				
		txtLine *= mtx[r, last(c̃)] * " "^rightMargin * "\n"^spacing
		
		txt *= txtLine
	end
	
	txtLine = " "^leftMargin
	for c in first(c̃) : (last(c̃) - 1)
		txtLine *= mtx[last(r̃), c] * " "^gap
	end
	txtLine *= mtx[last(r̃), last(c̃)] * " "^rightMargin
	
	txt *= txtLine
	
	txt *= "\n"^botMargin




	if width == nothing
		wid = (gap+1)*(length(c̃) - 1) + leftMargin + rightMargin
	else
		wid = width
	end

	if height == nothing
		hgt = (length(r̃) - 1) * spacing + 1 + topMargin + botMargin + 3
	else
		hgt = height
	end
		 
	
	
	
	
	# PlutoUI.TextField((wid+widthMargin, hgt+heightMargin), txt)
	PlutoUI.TextField((wid, hgt), txt)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Index range independent

function showText(mtx::AbstractMatrix{T};     
                  spacing=2, gap=2, 
				  width=nothing, height=nothing,
				  leftMargin=0,  rightMargin=0,
				  topMargin=0,   botMargin=0,
                  cellWidth=nothing) where T <: Integer
										        #widthMargin=0, heightMargin=0)


	if cellWidth == nothing
		widMax = 0

		for item in mtx
			if length("$item") > widMax
				widMax = length("$item")
			end
		end

		cellPad = widMax
	else
		cellPad = cellWidth
	end

	 
	txt = "\n"^(topMargin + 1)
	
	r̃, c̃ = axes(mtx)	 
	
	
	for r in first(r̃) : (last(r̃) - 1)
	
		txtLine = " "^leftMargin	
		for c in first(c̃) : (last(c̃) - 1)
			n = mtx[r, c]
			txtLine *= lpad("$n", cellPad) * " "^gap
		end
		n = mtx[r, last(c̃)]
		txtLine *= lpad("$n", cellPad) * " "^rightMargin * "\n"^spacing
		
		txt *= txtLine
	end
	
	txtLine = " "^leftMargin
	for c in first(c̃) : (last(c̃) - 1)
		n = mtx[last(r̃), c]
		
		txtLine *= lpad("$n", cellPad) * " "^gap
	end
	n = mtx[last(r̃), last(c̃)]
	txtLine *= lpad("$n", cellPad) * " "^rightMargin
	
	txt *= txtLine
	
	txt *= "\n"^botMargin




	if width == nothing	 

		wid = leftMargin +
		      cellPad*(length(c̃)) + 
		      gap*(length(c̃) - 1) + 		
 			  rightMargin
		
	else
		wid = width
	end

	if height == nothing
		hgt = (length(r̃) - 1) * spacing + topMargin + botMargin + 2
	else
		hgt = height
	end
		 
	
	
	
	
	# PlutoUI.TextField((wid+widthMargin, hgt+heightMargin), txt)
	PlutoUI.TextField((wid, hgt), txt)
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function showText(pages::Vector{Vector{String}}; spacing=1, gap=0)
	
	res = Vector{TextField}(undef, length(pages))	
	
	for i in eachindex(pages)
		res[i] = showText(pages[i];  spacing=spacing,  gap=gap)
	end	
	
	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Assert: linesA and linesB are 1-indexed

function woven(linesA, linesB;  separation=1)	
	
	res = String[]
	
	ℓA = length(linesA)
	ℓB = length(linesB)
	
	ℓmin = minimum([ℓA, ℓB])		 
	 
	for i in 1 : (ℓmin-1)
		push!(res, linesA[i])
		push!(res, linesB[i])
		
		for j in 1:separation;    push!(res, "");    end
	end
	push!(res, linesA[ℓmin])
	push!(res, linesB[ℓmin])
				
	
	if ℓA != ℓB
		for j in 1:separation;    push!(res, "");    end
		
		push!(res, "⚠️ The lengths of the lines did not match ⚠️")		
	end	
	
	
	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~











#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function IntsFromString(str::String)#;  asTuple=false)
	
	res = Int[]
	
	strSplit = split(str, " ")
	
	for item in strSplit
		if item != ""
		
			if last(item) ∉ "0123456789.";   item = item[1:end-1];   end
			
			IntOrNothing = tryparse(Int, item)
			
			if IntOrNothing != nothing
				push!(res, IntOrNothing)
			end
		end
	end
	
	res
	#asTuple ?  tuple(res...)  :  res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function Float64sFromString(str::String)#;  asTuple=false)
	
	res = Float64[]
	
	strSplit = split(str, " ")
	
	for item in strSplit
		if item != ""
		
			if last(item) == ',';   item = item[1:end-1];   end
			
			Float64OrNothing = tryparse(Float64, item)
			
			if Float64OrNothing != nothing
				push!(res, Float64OrNothing)
			end
		end
	end
	

	# Deprecate asTuple???
	#asTuple ?  tuple(res...)  :  res
	res
end

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function fmdRound(n,  numDecimals)
	N = n * 10^(numDecimals+1)

	if N % 10 == 5;   N+=1;    end

	n′ = N / 10^(numDecimals+1)

	
	Formatting.format(n′, precision=numDecimals)
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function getLineSeparatedExpectedSolutions(vecStr)

	res = Vector{String}[]

	vecStrCurr = []

	for str in vecStr
		if str == ""
			push!(res, vecStrCurr)
			vecStrCurr = []
		else
			push!(vecStrCurr, str)
		end
	end
	if vecStrCurr != []
		push!(res, vecStrCurr)
	end

	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function getVecTup(vecStr, iₕ, ℓ;  dType=Int, indexing=1)

	shift = 1-indexing
	range = indexing : (ℓ - shift)
	iₒ = iₕ+shift # origin index may be shifted away from the header index
	
	if indexing == 1		 
		res = Vector{Tuple}(undef, ℓ)	 
	else
		res = OffsetVector{Tuple}(undef, range)
	end

 
	

	for Δi in range		
   	#	res[Δi] = tuple(map(str -> parse(dType, str),    split(vecStr[iₒ+Δi]))...)
		res[Δi] = tuple([parse(dType, str)    for str in split(vecStr[iₒ+Δi])]...)	
	end

		 
	
 	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Timothy R. Gaede
# 2021-12-13

# useBrute: suitable when the number of unique items is 
# similar to the number of items

function freqItemsInSorted(sorted;  useBrute=false, sortByCount=false, asDict=false)


	#----------------------------------------------------------------------	
	function firstIndexOfNextHigherItem(a, i)
	    
		item = a[i]
	    iₗₒ = i
	    iₕᵢ = lastindex(a)
		 
		
	    while iₗₒ ≤ iₕᵢ

			iₘᵢ = iₗₒ + (iₕᵢ-iₗₒ)÷2
			iₙₜ = iₘᵢ+1 # next index after the middle index		
	
			
			if iₙₜ > lastindex(a);    return nothing;    end
			
			
	        if a[iₘᵢ] == item  &&  a[iₙₜ] != item;   return iₙₜ;    end
			
			
			if a[iₘᵢ] == item;   iₗₒ = iₘᵢ+1
			else                 iₕᵢ = iₘᵢ-1
			end
			 
	    end
	
	    # nothing
	end
	#----------------------------------------------------------------------

	sortByLast(a) = map(x -> reverse(x),  sort(map(x -> reverse(x), a)))
	
	
	res = Tuple{typeof(first(sorted)), Int}[]
 
	iL = firstindex(sorted)	  

	if useBrute # traverse the array one index at a time to find changes
		
		
		for iR in firstindex(sorted) +1 : lastindex(sorted)
			if sorted[iR] != sorted[iL] # found higher item
				push!(res, (sorted[iL], iR-iL))
				iL = iR
			end
		end	 

	else # use binary searches to find changes
		
		higherItemMayExist = true
		
		while higherItemMayExist
			iR = firstIndexOfNextHigherItem(sorted, iL)
	
			if iR == nothing
				higherItemMayExist = false
			else
				push!(res, (sorted[iL], iR-iL))
				iL=iR
			end
		end

	end
	push!(res, (last(sorted), lastindex(sorted)-iL+1))

	#res = sort(res)

	 

	if sortByCount;    return reverse(sortByLast(res));   end

	
	if asDict
		resDict = Dict()
		
		for tuple in res
			key, val = tuple
			resDict[key] = val
		end

		return resDict

	else

		return res
	end
		
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function condenseFrom_startswiths(vecStr, vecSubstr)
	res = String[]

	for str in vecStr
		
		substrFound = nothing
		
		for substr in vecSubstr

			
			
			if startswith(str, substr)
				if substrFound != nothing
					msg = "In function condense(vecStr, vecSubstr) \n" *
					      "vecStr contains \"$str\" which starts with both \n" *
					      "\"$substrFound\" and \"$substr\", elements of vecSubStr."

					throw(ArgumentError(msg))
				else
					substrFound = substr
					push!(res, substr)
				end
			 
			end

		end
		if substrFound == nothing
			push!(res, str)
		end
	end


	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






















#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function combiCntsSubStrs(vecStr, vecSubStr)

	vecSubStrSorted = reshape(sort(vecSubStr), 0:(length(vecSubStr)-1))
	
	combiID_range = 0 : 2^(length(vecSubStrSorted)) - 1

	cnt_combiID = zeros(Int, combiID_range)

	dictCnts = Dict{Vector{String}, Int}()

	for combiID in combiID_range
		selection = String[]

		rem = combiID
		i = 0
		while rem > 0
			if rem % 2 == 1
				push!(selection, vecSubStrSorted[i])
			end
			rem ÷= 2
			i+=1
		end

		dictCnts[selection] = 0
	end

	for str in vecStr
		slctn = String[]
		for i in eachindex(vecSubStrSorted)
			if occursin(vecSubStrSorted[i], str)
				push!(slctn, vecSubStrSorted[i])
			end
		end
		
		dictCnts[slctn] += 1	 
	end


	dictCnts
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function sortGeneric!(a, f;    cutoff=20)  
	
	# ---------------------------------------------
	function insertionSortGeneric!(a, f)  

		for i in (firstindex(a) + 1 : lastindex(a))
			j = i
			while j > 1  &&  f(a[j], a[j-1]) < 0
 
				a[j-1], a[j] = a[j], a[j-1]

				j -= 1
			end
		end

	end
	# ---------------------------------------------

	
	
	
	# -----------------------------------------------------------------------
	function quickSortGeneric!(a, (lo, hi), f)
		i, j = lo, hi
		while i < hi
			pivot = a[(lo+hi)>>>1]
			while i <= j
				while f(a[i], pivot) < 0;    i = i+1;    end
				while f(a[j], pivot) > 0;    j = j-1;    end
				if i <= j
					a[i], a[j] = a[j], a[i]
					i, j = i+1, j-1
				end
			end
			if lo < j;    quickSortGeneric!(a, (lo, j), f);    end
			lo, j = i, hi
		end 
	end
	# -----------------------------------------------------------------------
	
	
    if length(a) < cutoff 
        insertionSortGeneric!(a, f) 
	else 
        quickSortGeneric!(a, (firstindex(a), lastindex(a)), f) 
    end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sortedGeneric(a, f) = (a′ = copy(a);    sortGeneric!(a′, f);    a′)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~






#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function randomSample(a, N::Int)
	if N == 0;    return typeof(first(a))[];   end
	if N > length(a)  ||  N < 0
		msg = "In function randomSample(a, N): \n" *
		      "The number of items to select was $N. \n" *
		      "The number of items in the array was $(length(a))."

		throw(ArgumentError(msg))
	end

	indexSelected = array(false, eachindex(a)) # GaGa.array()

	res = Vector{typeof(first(a))}(undef, N)
	 
	for n in 1:N
		i = rand(eachindex(indexSelected))
		while indexSelected[i] == true
			i+=1
			if i > lastindex(indexSelected)
				i = firstindex(indexSelected)
			end
		end
		indexSelected[i] = true
		 
		res[n] = a[i]
	end


	res
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~









end

# ╔═╡ 74426140-9f48-4e7c-95ef-57dff5864d3f
@htl("""<div class = "doc">
Add: <julia>hideEverythingBelow()</julia>
</div>""")

# ╔═╡ 1c5dac5f-e58e-443c-a4cd-3dfcd9fba2f4
# My usual aliases for AbstractVector indexing
# DO NOT USE: fi, ei, li, ℓ = firstindex, eachindex, lastindex
fi(a) = firstindex(a);    ei(a) = eachindex(a);    li(a) = lastindex(a);

# ╔═╡ e454ec75-4cc4-4dad-b41d-76a73fc38222
ℓ(a) = length(a) # DO NOT USE ℓ = length

# ╔═╡ 9a35b368-0c05-49c3-b677-ba19c9aa7a9c
M,G,T,P,E = [10^3i    for i in 2:6]

# ╔═╡ ce785f59-4031-4447-baac-26c65b356abf
@htl("""<div class = "doc">
&emsp; 🚧 &emsp; ⚠️<b>Construction Area</b>⚠️ &emsp; 🚧<br><br>

<big>ToDo:  </big>

<ul>
	<li>
	Convert PDF to PNG files
	</li><br>

	<li>
	blah
	</li><br>



</ul>


<br><br>
<a href="https://hspt.ucfprogrammingteam.org/index.php">
UCF programming</a>

</div>""")

# ╔═╡ f87c9399-1c8e-4cb2-94b7-81247233ff6f
begin
	Tyear = 2024
	
	 # nothing for the Main tournament, [] for the online tournament before 
	 # partitioning into divisions
	divisions = [1,2]

	urlExt   = "Books"
	probName = "Lior's Books"
	origName = "Lior's Books"
	
	filenameBase = "books"
	fileIDRange = 1:29 #nothing #1:12 # ← nothing
	fileIDPad = 3

	pgsIns = 5:5

	#=
	sampleFilenameBase = "Rocks"
	sampleFileIDRange = 1:3 #nothing #1:12 # ← nothing
	sampleFileIDPad = 3
	=#
	

	
	# ToDo: overhaul code involving sample data
	pgOrigSample = 1
	pgMineSample = 1
	# -----------------------------------------
	
	
	urlRAW = "https://raw.githubusercontent.com/"

	
	if divisions == nothing #length(divisions) == 0
		urlYr = "Tim-Gaede/UCF_HSPT_$(Tyear)_$urlExt/main/"
	elseif divisions == []
		urlYr = "Tim-Gaede/UCF_HSPT_OE_$(Tyear)_$urlExt/main/"
	elseif divisions ∈ ([1], [1,2])
		urlYr = "Tim-Gaede/UCF_HSPT_OE1_$(Tyear)_$urlExt/main/"
	elseif divisions ∈ ([2], [2,1]) 
		urlYr = "Tim-Gaede/UCF_HSPT_OE2_$(Tyear)_$urlExt/main/"		
	end

	urlMain = urlRAW * urlYr
	url_ = urlMain * filenameBase

	if filenameBase == uppercase(filenameBase)	
		inExt, outExt = ".IN",  ".OUT"
	else
		inExt, outExt = ".in",  ".out"
	end

	

	 
	urlInp_orig = url_ * inExt
	urlOut_orig = url_ * outExt

	
	# urlSampleInp_orig = url_ * inExt
	# urlSAmpleOut_orig = url_ * outExt
	
	
	# If the original file of raw data for sets (raw multiset) ---------
	# had been partitioned into multiple files	
	if fileIDRange != nothing
		url_ = urlMain * "$filenameBase"
		vec_urlInp = OffsetVector{String}(undef, fileIDRange)
		vec_urlOut = OffsetVector{String}(undef, fileIDRange)
		
	 	 
		for i in fileIDRange
			vec_urlInp[i] = url_ * lpad("$i", fileIDPad, '0') * inExt
			vec_urlOut[i] = url_ * lpad("$i", fileIDPad, '0') * outExt
		end
		
		
	   
	end
	# --------------------------------------------------------------------

	
		
	#=
	if sampleFileIDRange != nothing
		url_ = urlMain * "$sampleFilenameBase"
		vec_urlSampleInp = OffsetVector{String}(undef, sampleFileIDRange)
		vec_urlSampleOut = OffsetVector{String}(undef, sampleFileIDRange)
		
	 	 
		for i in sampleFileIDRange
			vec_urlSampleInp[i] = url_ * lpad("$i", sampleFileIDPad, '0') * inExt
			vec_urlSampleOut[i] = url_ * lpad("$i", sampleFileIDPad, '0') * outExt
		end
		
		
	   
	end
	# --------------------------------------------------------------------
	=#
	
	




	
	#urlInstr = urlMain * "Instructions_"

	#if divisions == nothing  ||  length(divisions) == 0


	#if divisions != nothing  &&  length(divisions) > 0	 
	#	urlInstr *= "Div_$(first(divisions))_"
	#end
	 
	#urlInstr *= "pg"
	 


	urlsInstrOrig = String[]

	for pg in pgsIns
		push!(urlsInstrOrig,   urlMain * "pg_" * lpad(pg, 2, '0') * ".png")
	end
end;

# ╔═╡ 7127b4f6-b50e-4bda-815d-8c567fbd4a66
begin
	if probName == origName
		shownName = probName
		annotation = ""
	else
		shownName = probName * "*"
		annotation = """* Based on "$origName" """	
	end


	if divisions == nothing  # ||  length(divisions) == 0
		titleTournament = "$Tyear Tournament"
		subtitleTournament = ""
		url_pdf = urlMain*"Instructions.pdf"
	else
		#TyearStr = 
		titleTournament = "$(Tyear-1)-$(Tyear%100) Online Tournament"

		if length(divisions) == 0
			subtitleTournament = ""
			url_pdf = urlMain*"Instructions.pdf" # ToDo: FIX??
		elseif length(divisions) == 1
			subtitleTournament = "Division $(first(divisions))"
			url_pdf = urlMain*"Instructions_Div_$(first(divisions))"*".pdf"
		elseif length(divisions) == 2
			subtitleTournament = "Divisions 1&2"
			url_pdf = urlMain*"Instructions_Div_1&2.pdf"
		end

		
	end
		
	
	
	@htl("""
	
	<center>
	<h3><big><big><big>$titleTournament</big></big></big></h3>
	<h3><big><big><big>$subtitleTournament</big></big></big></h3>

	
	<a href=$url_pdf>pdf</a>
	<h3><big><big>$shownName</big></big></h3>
	
	<i>Base filename</i>: <data>$filenameBase</data><br>
 
	<br><br>
	
	Port to Pluto notebook by: <a href="https://github.com/Tim-Gaede?tab=repositories">Timothy R. Gaede</a>
	
	</center>

	<br><br>
	
	<small> $annotation </small>
	<div style="border-top: 0.25pt solid lightgrey"></div> 
	""")
end

# ╔═╡ 3a1e6e0f-c819-46f1-8e6e-60e51f829fc8
begin

	SL_instr = @bind instrSelection Select(["(none)", "Original", "Mine"])
	
	md""" $(html"<h3>📋 Instructions</h3>") 
 $(SL_instr) $(html"Please read the original instructions.")
	"""	
end

# ╔═╡ 15c169cc-6211-429d-bdd4-b7d5bc2b2290
if instrSelection== "Original"  &&  length(urlsInstrOrig) > 1
 
	 
	NF_pg_orig = @bind pg_orig @htl("""<input type=number 
										      min=1 
								              max = $(length(urlsInstrOrig))
                                              value=1>""")
elseif instrSelection == "Mine"

	NF_pg_mine = @bind pg_mine @htl("""<input type=number min=1 max = 3 value=1>""")
	 	  
end

# ╔═╡ edfb2419-58c7-4534-a070-d45696c4318f
if instrSelection== "Original"

 
	if length(urlsInstrOrig) > 1
		@htl("""$(Resource(urlsInstrOrig[pg_orig]))""")
	else
		@htl("""$(Resource(urlsInstrOrig[1]))""")
	end	


elseif instrSelection == "Mine"
	if pg_mine == 1
		@htl("""<div class="instructions">

		Blah



		
			
		<!-- ------------------------------------------------------------------ -->
		<div style="border-top: 0.25pt solid lightgrey"></div> 
			
		<h5>The Problem</h5><br> 
		Blah.<br><br>

		blalh blh blahk* tda duh.<br><br>

		<small>*<small>nope</small></small>


		
		</div>""")

	elseif pg_mine == 2
		
		@htl("""<div class="instructions">


		<!-- ------------------------------------------------------------------ -->
		<div style="border-top: 0.25pt solid lightgrey"></div> 
		 
		<h5>The Input</h5><br>

				<center><h6></h6>Coming soon!</center>
			
			<br><br>
		<!-- ------------------------------------------------------------ -->
		<div style="border-top: 0.25pt solid lightgrey"></div> 
		 
	 
		
		<h5>The Output</h5><br>

			<center><h6></h6>Coming soon!</center>

			
		<!-- --------------------------------------------------------------------- -->
		<div style="border-top: 0.25pt solid lightgrey"></div>
			
		<h5>Sample Input and Output:</h5>
			
 
		$(GG.showText([sampleInputVecStr, sampleOutputVecStr])) 
 
		 
		</div>""")

	
	end # pg_mine

	

	 
end

# ╔═╡ cbfec70e-e8f8-4a84-847a-97690e6ff845
if divisions != nothing
	if divisions == []
		@htl("""<div class = "doc">
			This problem appeared before the online tournament was partitioned into divisions 1 & 2 (harder & easier).
		</div>""")
		
	elseif divisions == [1]
		@htl("""<div class = "doc">
			This problem appears only in Division 1, indicating high-to-great difficulty.
		</div>""")
	elseif length(divisions) == 2
		@htl("""<div class = "doc">
			This problem is in both divisions, indicating medium-to-high difficulty.
		</div>""")
	elseif divisions == [2]
		@htl("""<div class = "doc">
			This problem appears only in Division 2, indicating low-to-medium difficulty.
		</div>""")
	end
end

# ╔═╡ 456310a1-3993-44f2-af3a-4ca22a6280e7
begin
	condSampleOrigShown = instrSelection == "Original"  &&  
	   ( length(urlsInstrOrig) == 1  ||  pg_orig >= pgOrigSample )
	
	condSampleMineShown = instrSelection == "Mine"  &&  
	   ( length(urlsInstrOrig) == 1  ||  pg_mine >= pgMineSample )
	
	
	
	if condSampleOrigShown || condSampleMineShown
			 
		CB_show_explnSample = @bind show_explnSample CheckBox() 
		
		md""" $(CB_show_explnSample) 👨‍🏫 $(html"explain <b style='font-family:Times_New_Roman;'>Sample</b>") """
	
	 
		
	else
		show_explnSample = false
		nothing # "Nothing works."
		 
	end
end

# ╔═╡ 33814c7d-e97c-419e-bc98-b78480ee18c6
if instrSelection== "Original"  &&  show_explnSample

 
 	html"""<div class="instructions">

 		Put an explanation here	 
<data>
	
Put data here	<br><br>
 			
</data>			

<br><br>

		
		
		</div>"""	

elseif instrSelection== "Mine"  &&  show_explnSample

 
 	html"""<div class="instructions">

		<h3>Explanation of my sample coming soon!</h3>
	
		<data>
				
		2<br> <br>
		4gg3b <br>
		2aa <br>
		3 <br>
		4zf3a1 <br>
		ayaby5 <br>
		13241 <br>
		0 <br>
									 
		</data>
				
		
																					 
		</div>"""	

	
end

# ╔═╡ 9ad9f0f4-52c0-40f1-81fd-a36d67e36cb0
@htl("""<div class = "doc">
&emsp; 🚧 &emsp; ⚠️<b>Sample 1 Explanation</b>⚠️ &emsp; 🚧<br><br>

 
</div>""")

# ╔═╡ 9312b5b5-2028-47e1-8d5b-6614a8b1800d
@htl(""" 
<div class="instructions">
<hr>

<h4> &emsp; Input</h4>
</div>
""")

# ╔═╡ 592dc70b-c2d8-4ceb-970c-469f76970c00


# ╔═╡ a3fca05d-bc94-40f4-a334-b05295214dc5
begin	
	CB_show_inpVecVecStr = @bind show_inpVecVecStr CheckBox()

	
	md""" $(CB_show_inpVecVecStr) $(html"<big>📄</big>") show input files 
	"""
end

# ╔═╡ 9ab2961f-03d7-4e1b-b0d2-6426e4572126
if show_inpVecVecStr
 
	NF_fileInpID = @bind fileInpID @htl("""
	<input type=number 
	       min = $(first(fileIDRange)) 
	       max = $(last(fileIDRange)) 
	       value=$(first(fileIDRange))
	       style="text-align: right;"
	>
	""")

	 
	md""" 
	file ID: $(NF_fileInpID) $(html"&emsp;")
	"""
end

# ╔═╡ 8830d6cc-2e76-45d2-b7fd-e10cce01994f
@htl(""" 
<div class="instructions">
<hr>
</div>
""")

# ╔═╡ 6840b9a9-05b3-4293-aac1-3a2a24c168ee
@htl(""" 
<div class="instructions">
<hr>

<h4> &emsp; Parsing Input Files</h4>
</div>
""")

# ╔═╡ e3318a07-5aad-49bf-9097-6505a8b2ca82
function parseDataset(raw,    iHeader=nothing)
	iHeader == nothing ?  iₕ = fi(raw)  :  iₕ = iHeader

	nStacks = parse(Int, first(raw))

	heights = [parse(Int, subStr)    for subStr in split(raw[2])]

	if length(heights) != nStacks
		throw(ArgumentError("Expecteded $nStacks stacks but got $(length(heights))"))
	end
	

	heights
end

# ╔═╡ dd722c14-65f0-46c8-bdd3-769a65043c57


# ╔═╡ 91c122c8-05b7-4193-865a-426b858ed113
@htl("""<div class = "doc">

Blah...
</div>""")

# ╔═╡ 4330ba6b-0fa9-410b-a7df-cfa6479a53cb
html"""   
<div style="border-top: 1px solid orange"></div> 
<br>
<div style="border-bottom: 1px solid green"></div> 
"""

# ╔═╡ e15eda21-2997-4c0d-8fa1-ad21a7c61a04
html"""   
<div style="border-bottom: 1px solid red"></div> 
"""

# ╔═╡ 9cdc7670-0504-40f9-acd6-bbf248c1919e


# ╔═╡ 7e9a4175-8c1e-4c94-8852-6932485b4ff3


# ╔═╡ b9ece6e4-6ffc-4276-944d-1b15f9927509
@htl(""" 
<div class="instructions">
<hr>

<h4> &emsp; Solution & Expectation</h4>
</div>
""")

# ╔═╡ 69317844-4c2d-491d-93a4-d8385eddaea6
#=

	
	📝0:  	A "height" is the number of books in a particular stack
            This problem is best visualized with all books the same height.


	📝1:  	If the number of stacks do not evenly divide the number of books,
          	then it is impossible to have the same number of books in each stack.


	📝2:  	h̄: h\bar[Tab↹]²
            ÷ \div[Tab↹]² (fast integer division)

		  	Having a horizontal line over a varibable (a bar)
          	is standard notation to indicate an average value.


 	📝3:  	∑: \sum[Tab↹]²
          	We "even out" the stack heights by repeatedly moving a books from a stack   			above the average height (h̄) to a stacks below the average height.
            We can visualize the number of moves by imagining all books having the 
            same thickness and drawing a line representing the average height.
            We then sum up the number of books above this line.



 	📝4:  	An alternate solution would be to sum the vacancies below the line

=#
function sln(heights) # 📝0

	nBooksTotal = sum(heights)
	nStacks  = length(heights)

	
	if nBooksTotal % nStacks != 0;    return "impossible";    end # 📝1


	h̄ = nBooksTotal ÷ nStacks # 📝2

	

	# 📝3 -------------------------------
	∑above = 0
	for h in heights
		if h > h̄;   ∑above += h-h̄;    end
	end
	# -----------------------------------


	
	# 📝4 -------------------------------
	#=
	
	∑vacancies = 0
	for h in dset
		if h < h̄;   ∑vacancies += h̄-h;    end
	end
	
	# ∑vacancies == ∑above
	
	return "$∑vacancies"
	
	=#
	# -----------------------------------
	

	
	"$∑above"
end

# ╔═╡ 0aa04f5f-be01-4a16-8dfa-a032f0bfb9b5


# ╔═╡ b8e71a33-ac3e-4b57-b932-a3b5aba0a515
#exnOrig = GaGa.vecStrFrom_url(urlOut_orig)

# ╔═╡ 504403a1-fb73-4e00-be57-8385c05435f2
begin
	CB_show_exnVecVecStr = @bind show_exnVecVecStr CheckBox()
	
	md""" $(CB_show_exnVecVecStr) $(html"<big>📄</big>") show expectation files
	"""
end

# ╔═╡ b52cb4e1-1277-43c1-8be8-56f2cd305276
if show_exnVecVecStr
 
	NF_fileExnID = @bind fileExnID @htl("""
	<input type=number 
	       min = $(first(fileIDRange)) 
	       max = $(last(fileIDRange)) 
	       value=$(first(fileIDRange))
	       style="text-align: right;"
	>""")

	 
	md""" 
	file ID: $(NF_fileExnID) $(html"&emsp;")
	"""
end

# ╔═╡ e0e429c5-a6e6-4b79-b93b-d2900acc362b
if show_exnVecVecStr
 
	NF_exnTop = @bind exnTop @htl("""
	<input type=number 
	       min = 1 
	       max = $(length(exn[fileExnID])) 
	       value=1
		   style="text-align: right;"
	>
	""")

	
	if length(exn[fileExnID]) <= 60 
		exnLenDefault = length(exn[fileExnID])
	else
		exnLenDefault = 45
	end
	
	NF_exnLen = @bind exnLen @htl("""
	<input type=number 
	       min = 1 
	       max = $(length(exn[fileExnID])) 
	       value=$exnLenDefault
	       style="text-align: right;"
	>
	""")
	
	md""" 
	top line number: $(NF_exnTop) $(html"&emsp;")
	\# lines desired: $(NF_exnLen)
	"""
end

# ╔═╡ 946b01ec-741d-49fb-ac4c-8e22b6a34504
if show_exnVecVecStr
	exnBot = exnTop + exnLen - 1

	if exnBot > lastindex(exn[fileExnID])
		exnBot = lastindex(exn[fileExnID])
	end
	
	if exnTop <=exnBot
		@htl("""<div class="guidance"> 
		 Showing line numbers $exnTop to $exnBot of $(lastindex(exn[fileExnID]))
		 <br>
			
		$(GaGa.showText(exn[fileExnID][exnTop : exnBot]))

		</div>""")
	end
end

# ╔═╡ 2b906643-f0bc-477e-926d-36c93686bdc4
begin
	CB_show_inpExnSBS = @bind show_inpExnSBS html"<input type=checkbox                                                                     value=false>" 
	 

	md""" $(CB_show_inpExnSBS) $(html"<big>📄📄</big>") show input side-by-side with expectation
	"""
end

# ╔═╡ 2617d0e4-40cc-4a27-811f-7e35cfa336b3
if show_inpExnSBS
 
	NF_fileInpExnSBS_ID = @bind fileInpExnSBS_ID @htl("""
	<input type=number 
	       min = $(firstindex(fileIDRange)) 
	       max = $(lastindex(fileIDRange)) 
	       value=$(firstindex(fileIDRange))
	       style="text-align: right;"
	>
	""")

	 
	md""" 
	files ID: $(NF_fileInpExnSBS_ID)
	"""
end

# ╔═╡ 7aa1e550-2e6b-4024-9912-469864467054
if show_inpExnSBS
 
	NF_InpExnSBS_inpTop = @bind inpExnSBS_inpTop @htl("""
	<input type=number 
	       min = $(first(inp[fileInpExnSBS_ID])) 
	       max =  $(last(inp[fileInpExnSBS_ID])) 
	       value=1
		   style="text-align: right;"
	>
	""")

	
	if length(inp[fileInpExnSBS_ID]) <= 60 
		inpExnSBS_inpLenDefault = length(inp[fileInpExnSBS_ID])
	else
		inpExnSBS_inpLenDefault = 45
	end

	
	NF_InpExnSBS_inpLen = @bind inpExnSBS_inpLen @htl("""
	<input type=number 
	       min = 1 
	       max = $(length(inp[fileInpExnSBS_ID])) 
	       value=$inpExnSBS_inpLenDefault
	       style="text-align: right;"
	>
	""")
	
	md"""
	$(html"<big><b>Input</b> file</big>")
	
	top line number: $(NF_InpExnSBS_inpTop) $(html"&emsp;")
	\# lines desired: $(NF_InpExnSBS_inpLen)
	"""
end

# ╔═╡ b983505a-550c-4d08-900a-b54f16b1598c
if show_inpExnSBS
 
	NF_InpExnSBS_exnTop = @bind inpExnSBS_exnTop @htl("""
	<input type=number 
	       min = $(firstindex(exn[fileInpExnSBS_ID])) 
	       max =  $(lastindex(exn[fileInpExnSBS_ID])) 
	       value=1
		   style="text-align: right;"
	>
	""")

	
	if length(exn[fileInpExnSBS_ID]) <= 60 
		inpExnSBS_exnLenDefault = length(exn[fileInpExnSBS_ID])
	else
		inpExnSBS_exnLenDefault = 45
	end

	
	NF_InpExnSBS_exnLen = @bind inpExnSBS_exnLen @htl("""
	<input type=number 
	       min = 1 
	       max = $(length(exn[fileInpExnSBS_ID])) 
	       value=$inpExnSBS_exnLenDefault
	       style="text-align: right;"
	>
	""")
	
	md"""
	$(html"<big><b>Expectation</b> file</big>")
	
	top line number: $(NF_InpExnSBS_exnTop) $(html"&emsp;")
	\# lines desired: $(NF_InpExnSBS_exnLen)
	"""
end

# ╔═╡ 0e266d7c-92f4-436d-b08f-cb182f78c447
if show_inpExnSBS
	inpExnSBS_inpBot = inpExnSBS_inpTop + inpExnSBS_inpLen - 1

	if inpExnSBS_inpBot > lastindex(inp[fileInpExnSBS_ID])
		inpExnSBS_inpBot = lastindex(inp[fileInpExnSBS_ID])
	end



	inpExnSBS_exnBot = inpExnSBS_exnTop + inpExnSBS_exnLen - 1

	if inpExnSBS_exnBot > lastindex(exn[fileInpExnSBS_ID])
		inpExnSBS_exnBot = lastindex(exn[fileInpExnSBS_ID])
	end


	inpVecStr  = inp[fileInpExnSBS_ID][inpExnSBS_inpTop : inpExnSBS_inpBot]
	exnVecStr  = exn[fileInpExnSBS_ID][inpExnSBS_exnTop : inpExnSBS_exnBot]

	
	GaGa.showText([inpVecStr, exnVecStr])
end

# ╔═╡ 3c731af7-dd5d-4faa-a4be-7d7695f61a66


# ╔═╡ 9fd1dc27-e9c2-4da5-8b4d-d37ee5fe286c
#=
begin
	CB_show_inpExnWoven = @bind show_inpExnWoven html"<input type=checkbox                                                                    value=false>" 
	
	md"""	
	show offset $(html"<span><code class='language-julia'>inputLines</code></span>") woven with $(html"<span><code class='language-julia'>expectedLines</code></span>")         $(CB_show_inpExnWoven)	
	"""
end
=#

# ╔═╡ 6f3a4855-73b0-4755-9b4b-741de291322b
#=
if show_inpExnWoven

	i_inpExn_wvnMax = length(exnVecStr)
 
	NF_inpExn_wvnTop = @bind inpExn_wvnTop @htl("""<input type=number min=1 max = $i_inpExn_wvnMax value=1>""")

	
	
	if i_inpExn_wvnMax <= 20 
		inpExn_wvnLenDefault = i_inpExn_wvnMax
	else
		inpExn_wvnLenDefault = 10
	end

	
	NF_inpExn_wvnLen = @bind inpExn_wvnLen @htl("""<input type=number min=1 max = $i_inpExn_wvnMax value=$inpExn_wvnLenDefault>""")


	NF_inpExn_wvnSep = @bind inpExn_wvnSep @htl("""<input type=number min=0 max=5 value=1>""")

	
	md""" 
	woven Top $(NF_inpExn_wvnTop) $(html"&emsp;") woven Len $(NF_inpExn_wvnLen)  $(html"&emsp;")  woven Sep $(NF_inpExn_wvnSep) 
	"""
  
end
=#

# ╔═╡ 588069dd-ce5d-42c1-8bb9-26f704bb2352
#=
if show_inpExnWoven
	inpExn_wvnBot = inpExn_wvnTop + inpExn_wvnLen - 1

	if inpExn_wvnBot > i_inpExn_wvnMax
		inpExn_wvnBot = i_inpExn_wvnMax
	end
	 
	GaGa.showText(GaGa.woven(inputVecStr[inpExn_wvnTop+1 : inpExn_wvnBot+1], 
                         exnVecStr[inpExn_wvnTop : inpExn_wvnBot], 
                         separation=inpExn_wvnSep))	 
end
=#

# ╔═╡ bd6ec7ba-b342-46a8-955f-f2d18912778d
html"""   
<div style="border-top: 1px solid red"></div> 
<br>
<div style="border-bottom: 1px solid orange"></div> 
"""

# ╔═╡ e0b4231f-5d35-45d6-be1d-35cb7fadbc85
begin
	CB_show_sideBySide = @bind show_sideBySide CheckBox()
	
	md""" $(CB_show_sideBySide) $(html"<big>📄</big>") show expectation & solution side-by-side
	"""
end

# ╔═╡ c077432c-3da8-4f38-93fb-802704b506d9
begin
	CB_show_exnSln_Woven = @bind show_exnSln_Woven CheckBox()
	
	md""" $(CB_show_exnSln_Woven) $(html"<big>📄</big>") show expectation & solution woven
	"""
end

# ╔═╡ 14466cbf-656b-4b36-aa45-68f964026336
#exnOrig

# ╔═╡ aa091b16-ef38-49aa-9492-8d55a995165c
#exnParts = [exnOrig[d]          for d in ei(exnOrig)]

# ╔═╡ 1dd0b634-37ff-46c1-b3cf-1d97b792fa6b
a=5; b=12

# ╔═╡ 6d461faf-d290-4689-b829-1d06209f3f19
@handcalcs c = sqrt(a^2 + b^2)

# ╔═╡ 6043e040-77b5-406f-b7d4-5955b0f11d43
LaTeXsizeStrs = ["\\tiny", "\\scriptsize", #"\\footnotesize", 
		         "\\small", "\\normalsize",
		         "\\large", "\\Large",
		         "\\LARGE", "\\huge", 
		         "\\Huge"]

# ╔═╡ 77607f34-ba86-4348-b2ca-17d5087506e7
begin
	RNG_iₛₑ = @bind iₛₑ @htl(""" 
	<input  type="range" 
				   min =   1
				   max =   $(li(LaTeXsizeStrs)) 
				   value = 5 
	

	
			style="width: 80%;" 
			oninput="document.getElementById('lbl_iₛₑ').innerHTML = this.value" 
	>""")
	
	 
	LBL_iₛₑ = @htl("""
	<label id="lbl_iₛₑ" 
	style="font-family: JuliaMono, Consolas, Courier;">5</label> 
	""")
	 
	
	@htl("""<data>iₛₑ</data> $(RNG_iₛₑ)  $(LBL_iₛₑ) """)
	 
end

# ╔═╡ ee979dc1-f66d-4f83-af87-2fa71c8104f5
function LaTeXsepStr(sep)

	if sep < -9
		msg = "\n sep was $sep.\n" *
		      "It must be at least -9."

		throw(ArgumentError(msg))
	end
	
	s₅ = "\\;"
	s₄ = "\\:"
	s₃ = "\\,"
	s₋₃= "\\!"


	
	if sep == -9;   return s₋₃^3;      end
	if sep == -8;   return s₄*s₋₃^4;      end
	if sep == -7;   return s₅*s₋₃^4;      end
	
	if sep == -6;   return s₋₃*s₋₃;       end	
	if sep == -5;   return s₄*s₋₃^3;      end
	if sep == -4;   return s₅*s₋₃^3;      end
	
	if sep == -3;   return s₋₃;           end
	if sep == -2;   return s₄*s₋₃*s₋₃;    end
	if sep == -1;   return s₅*s₋₃*s₋₃;    end
	
	rem = sep
	
	n_qq = rem ÷ 36
	rem -= 36n_qq

	n_q = rem ÷ 18
	rem -= 18n_q




	if rem == 0
		remStr = " "
	else

		remVec = [s₄*s₋₃,      s₅*s₋₃,      s₃,         s₄,         s₅,
				  s₃*s₃,       s₄*s₃,       s₅*s₃,      s₃^3,       s₅*s₅,
				  s₄*s₄*s₃,    s₄^3,        s₅*s₄*s₄,   s₅*s₅*s₄,   s₅^3,
				  s₄^4,        s₅*s₄^3]

		remStr = remVec[rem]
	end


	
	"\\qquad"^n_qq * "\\quad"^n_q * remStr
end

# ╔═╡ 08ed1e71-4c22-441c-a931-eb2de187139c
LaTeXsepStrs = reshape([LaTeXsepStr(s)    for s in -9:99], -9:99)

# ╔═╡ da869f84-2cbc-43af-a258-9532a4927374
begin
	RNG_iₑₛ = @bind iₑₛ @htl(""" 
	<input  type="range" 
				   min =   $(fi(LaTeXsepStrs))
				   max =   $(li(LaTeXsepStrs)) 
				   value = 0 
	
	 
			style="width: 80%;" 
			oninput="document.getElementById('lbl_iₑₛ').innerHTML = this.value" 
	>""")
	
	 
	LBL_iₑₛ = @htl("""
	<label id="lbl_iₑₛ" 
	style="font-family: JuliaMono, Consolas, Courier;">0</label> 
	""")
	 
	
	@htl("""<data>iₑₛ</data> $(RNG_iₑₛ)  $(LBL_iₑₛ) """)
	 
end

# ╔═╡ 61459cf9-3541-4b02-a670-fdc593de4095
begin
	RNG_i➕ = @bind i➕ @htl(""" 
	<input  type="range" 
				   min =   $(fi(LaTeXsepStrs))
				   max =   $(li(LaTeXsepStrs)) 
				   value = 0 
	
	 
			style="width: 80%;" 
			oninput="document.getElementById('lbl_i➕').innerHTML = this.value" 
	>""")
	
	 
	LBL_i➕ = @htl("""
	<label id="lbl_i➕" 
	style="font-family: JuliaMono, Consolas, Courier;">0</label> 
	""")
	 
	
	@htl("""<data>i➕</data> $(RNG_i➕)  $(LBL_i➕) """)
	 
end

# ╔═╡ 9408575b-2c40-4eb3-882c-07d4952cbf54
L"""%$(LaTeXsizeStrs[iₛₑ]){

	c 
    %$(LaTeXsepStrs[iₑₛ]) = %$(LaTeXsepStrs[iₑₛ])
   
    \sqrt{
			a^{2} 
            %$(LaTeXsepStrs[i➕]) + %$(LaTeXsepStrs[i➕])   
            b^{2}
		 } 
  
    %$(LaTeXsepStrs[iₑₛ]) = %$(LaTeXsepStrs[iₑₛ]) 

    \sqrt{
			%$(a)^{2}  
			%$(LaTeXsepStrs[i➕]) + %$(LaTeXsepStrs[i➕])  
			%$(b)^{2}
		 } 

    %$(LaTeXsepStrs[iₑₛ]) = %$(LaTeXsepStrs[iₑₛ]) 

    %$(c)

}"""

# ╔═╡ 1e903710-7acd-45f1-9a76-44811ed7c68e
# DataViewer.jl ? # https://www.youtube.com/watch?v=HiI4jgDyDhY&t=481s

# ╔═╡ 892fa24a-057e-406a-b424-59ed0aa823f6
begin
	CB_benchEn = @bind benchEn html"<input type=Checkbox>"
	@htl("""<span style="font-weight: bold;
						 font-size: 1.2em;
	                     color: rgb(0, 0, 150);">
	        Benchmarking Enabled  $(CB_benchEn)
	        </span>
	    """)
end

# ╔═╡ 04e5c074-85ea-4ef5-82d7-ad954eb98fda
#BenchmarkTools.DEFAULT_PARAMETERS.seconds = 1

# ╔═╡ 2cb56698-7ef9-4f74-aefa-e8104d559822
thinDivStr = "0.25pt"

# ╔═╡ b72d1627-8607-4f56-beb8-99e5cc8b439e
colorRegStr = "rgb(150, 0, 0)"

# ╔═╡ ac9615fc-e19b-48b5-9884-8658aed9a775
begin
	CB_benchI64 = @bind benchI64 html"<input type=Checkbox>"
	@htl("""<span style="font-weight: bold; 
	                     color: $(colorRegStr);">
	        Benchmark Int64
	        </span>
	     $(CB_benchI64)""")
end

# ╔═╡ f2d8abe1-8ab2-4221-9194-2d3fb24dcf5e
colorSafeStr = "rgb(0, 100, 0)"

# ╔═╡ cc70315f-96fc-4c25-80c5-2a168ed4cdb6
colorUnsStr = "rgb(125, 75, 0)"

# ╔═╡ 4c161d45-ccef-4919-8818-3d13a8a39f01
function und(n)
	rem = n
	resRev = ""

	e=0
	while rem > 0
		d = rem % 10
		rem ÷= 10
		
		resRev *= "$d"
		e+=1
		if e % 3 == 0  &&  rem > 0
			resRev *= "_"
		end
	end

	reverse(resRev)
end

# ╔═╡ bb518a47-f813-461a-9908-056d1a20cbbe
@htl("""   
	<div style="border-top: $(thinDivStr) solid green"></div> 
<br>
	<div style="border-bottom: $(thinDivStr) solid dodgerblue"></div> 
""")

# ╔═╡ ff844525-e446-436c-8de5-b39f99556f66


# ╔═╡ ecd9b7be-11b2-4015-ad02-9b97de881a55
@htl("""   
	<div style="border-top: $(thinDivStr) solid dodgerblue"></div> 
<br>
	<div style="border-bottom: $(thinDivStr) solid purple"></div> 
""")

# ╔═╡ dcd03de9-7054-4d5c-b67e-03c98f1106ae
begin
	 
	# Color pickers .................................................
	CP_link = @bind color_link html"<input type=color value=#0000aa>"

	CP_keyboard_background = @bind color_keyboard_background html"<input type=color value=#f5f5dc>"

	CP_keyboard_font = @bind color_keyboard_font html"<input type=color value=#000044>"	

	CP_tag = @bind color_tag html"<input type=color value=#666600>"
	# ...............................................................
	 
	md""" 
	$(CP_link) $(html"&nbsp; <a href='https://github.com/Tim-Gaede?tab=repositories'>
	links</a>")  $(html"&emsp; &emsp; &emsp; &emsp;")	$(CP_keyboard_background) $(html"&emsp; &emsp;")	$(CP_keyboard_font) $(html"&nbsp;<span class='keyboard'>keyboard</span>")

	$(CP_tag) 
	$(html"&nbsp;tags")
	
	"""
end

# ╔═╡ 0dc30566-d013-41c9-85fa-6ed2a0896fc5
begin

julia_font_size_str = "0.9em"
julia_background_str = "#FFFFFC"
julia_blue_str = "#4063D8"
julia_purple_str = "#9558B2"
	
jlStyle = "     
	  border: 0.5pt solid $julia_purple_str;
	  background: $julia_background_str;
	  font-weight: bold;
"	

@htl("""

<!-- 
Feel free to tinker with the code here 
Suggestions: TimGaede@gmail.com
-->

<style>

.tag {font-family: Arial; font-weight: bold;  color: $color_tag;">

divisibility, digit-manipulation

</span>}

.Shift_up {background: rgb(255, 250, 250);}
.Shift_DN {background: rgb(230, 255, 230);}	
	
.instructions h2::before { content: "📋"; } /* U+1F4CB */

.instructions { font-family: "Times New Roman"; } /* background: */

.doc { font-family: "Times New Roman"; } /* background: */



.box {
	font-family: "Arial";
    background: rgb(240, 245, 230);
    border: 2pt solid rgb(200, 200, 200);

	padding-top: 2pt;
    padding-right: 2pt;
	padding-bottom: 4pt;
	padding-left: 4pt;

	margin:6pt;
}



/*
.julia {       font-family: "JuliaMono";
               font-weight: bold;
               font-size: $julia_font_size_str;
			   color: blue;
		       background: $julia_background_str;                
		       border: 0.5pt solid $julia_purple_str;
}
/*





/*
.jl {       font-family: "JuliaMono";
            font-weight: bold;
            font-size: $julia_font_size_str;
	        color: blue;
	   	    background: $julia_background_str;                
		    border: 0.5pt solid $julia_purple_str;
}
/*


 
 
/*	U+1F5A5, U+FE0F   see also 💻 U+1F4BB */  
.guidance h5::before { content: "🖥️"; } 
	
.guidance {font-family: "Times";
	   background: rgb(254, 255, 254);}



.hints {font-family: "Georgia";}

.notes {font-family: "Arial";}

 
 
.Tab    { font-family: "Arial";
	        color: rgb(255, 255, 255);
	        background: rgb(100, 100, 100); 
			border-radius: 2px; }	
	
.bonus h5::before { content: "🎓"; } /* U+1F393 */
.bonus {font-family: "Times";
           background: rgb(254, 255, 254);}




/* ToDo: Box each letter?   
https://stackoverflow.com/questions/5050805/box-around-each-letter-with-css-without-using-spans
*/
.keyboard {background: $color_keyboard_background; 
           font-family: "Arial"; 
           font-size: 1.0em;
	       letter-spacing: 0pt;
		   border-style: solid;
		   border-width: 0.5pt;
		   border-radius: 2pt;
		   border-color: black;
		   font-weight: normal;
           color: $color_keyboard_font;}


 
					   

 


.BIG{font-size : 6.0em;}



a {color: $color_link; font-weight: bold} 
/* font-family: Arial;}  also re-styles package names */	



/* consider: .link {color: rgb(0, 0, 255);} */
	
data {font-family: "JuliaMono", "Courier";  
      font-weight: normal;  background: rgb(253, 253, 251);}

julia {        
               font-family: "JuliaMono";
               font-weight: bold;
               font-size: $julia_font_size_str;
               color: darkblue;
		       background: $julia_background_str;                
		       border: 0.5pt solid $julia_purple_str;
               border-radius: 2pt;
			   /* padding-top: 2pt; */
               padding-left: 2pt;
               padding-right: 2pt;
               /* padding-bottom: 2pt */;
       }

	

/*
If you do not have JuliaMono installed, INSTALL IT NOW! 🙂
     https://juliamono.netlify.app/download/ 
*/

 
table {border: 1px solid black;}

tr,td {border: 1px solid lightgrey;}
	
	
</style>

⬅️ 🎨<b>CSS</b>
""")


end

# ╔═╡ e4bf0354-a17e-4f27-969b-61e28aabcbbc
@htl("""<div class = "doc">

	In

	<code class='language-julia'        
          style = "$jlStyle"
	>	
    function DenckerDice()
    </code>, I 



</div>""")

# ╔═╡ 3bbfbf82-4ea5-4608-9cc2-e57c6dc633ed
html"""   
<div style="border-top: 1px solid dodgerblue"></div> 
<br>
<div style="border-bottom: 1px solid purple"></div> 
"""

# ╔═╡ f4a71b19-b2e0-46e6-b0a3-68c921416efa
#writeFiles(inpPrtnd, filenameBase, 3, "in")

# ╔═╡ a0beecc9-192f-4a68-99e3-03993da1ae0a


# ╔═╡ 2e46a838-08cc-48a4-8fc7-4dff6884ac5e
#writeFiles(outVecVecStr, filenameBase, 3, "out")

# ╔═╡ 8ba66db6-b59f-49cb-9dd6-6fd9b26d90ad


# ╔═╡ 1e132c3d-f5a1-48a9-9611-79272068f0c2
# inpVecVecStr = partitionInpVecStr(inpOrig)

# ╔═╡ b52cc127-d4a4-4ed5-a938-a068f17ddb86
# exn = get_IO(vec_urlOut, fileIDRange)

# ╔═╡ 20436422-cdc9-43cd-82b8-489ce9928752
# writeFiles(inpVecVecStr, filenameBase, 3, "in")

# ╔═╡ cbdc8055-5367-4b7e-bb6d-3cc70dcf4aa9
#writeOUTfilesSingleLine(exnOrig, "tray")

# ╔═╡ cb3abc6b-40ae-4f3f-b213-94a05c49be51
# writeFiles(outNew, filenameBase, 3, "out")

# ╔═╡ fb9f3cb9-9137-4df7-bf21-60eaf6f62278
# exn = get_IO(vec_urlOut, fileIDRange)

# ╔═╡ 4d0bc608-081c-4661-bd17-28f8c60d92df
#submissionValid(dSets[d₁], expectedParsed[d₁])

# ╔═╡ e811ef4a-cdfc-466f-af6a-b1177bf2d285
function writeFiles(vecVecStr::AbstractVector{Vector{String}}, 
	                baseName, pad, extension)

	first(extension) == '.' ?  ext = extension  :  ext = ".$extension"
	 
	for i in eachindex(vecVecStr)
		  
		file = open(baseName * lpad(i, pad, '0') * ext,    "w")
		
		for str in vecVecStr[i];    write(file, "$str\n");    end

		close(file)
	end
	 
end

# ╔═╡ 3c9f0e2e-eab3-495d-bb91-684ccfbf98e1
function writeFiles(vecStr::AbstractVector{String}, baseName, pad, extension)

	first(extension) == '.' ?  ext = extension  :  ext = ".$extension"
	 
	for i in eachindex(vecStr)
		  
		file = open(baseName * lpad(i, pad, '0') * ext,    "w")
		
		write(file, "$(vecStr[i])")

		close(file)
	end
	 
end

# ╔═╡ 31436936-6418-4c65-9311-dc29dd99df64


# ╔═╡ 27121dc3-010e-43fd-8e74-a8c26db9cc7b
#=
	Move to GaGa?
=#
function vStrip(raw::AbstractVector{String})
	iₜₒₚ = firstindex(raw)

	while raw[iₜₒₚ] == ""  &&  iₜₒₚ < lastindex(raw)
		iₜₒₚ += 1
	end

	

	iₗₐₛₜ = lastindex(raw)
	while raw[iₗₐₛₜ] == ""  && iₗₐₛₜ > firstindex(raw)
		iₗₐₛₜ -= 1
	end


	raw[iₜₒₚ : iₗₐₛₜ]
end

# ╔═╡ 8eddf751-4f46-4b89-9dbe-bcfa27b30e90
function stripHeaderWithIndex(vecVecStr::Vector{Vector{String}}, headerLenSansIndex)

	res = Vector{Vector{String}}(undef, length(vecVecStr))

	for i in eachindex(res)
		

		

		vecStr = copy(vecVecStr[i])
		headerLen = headerLenSansIndex + length(string(i))
		iStart = headerLen+1

		vecStr[1] = vecStr[1][iStart:end]
		
		res[i] = vecStr
		
	
	end

	res
end

# ╔═╡ cfe0692c-06be-46c2-89b1-2a6c6fcaeb4a
stripAll(arr) = map(x -> strip(x), arr)

# ╔═╡ 9534d7db-789c-4231-83dd-4d9f769e7132


# ╔═╡ ca720adc-39ab-4b8f-abd6-29ea687e22b3
function get_IO(vec_url, range)

	if first(range) == 1
		res = Vector{Vector{String}}(undef, last(range))
	else
		res = OffsetVector{Vector{String}}(undef, range)
	end
	

	for i in range
		res[i] = GaGa.vecStrFrom_url(vec_url[i])
	end


	res
end

# ╔═╡ ac85d673-cbe9-4d87-8b89-17889358ff25
inpParts = get_IO(vec_urlInp, fileIDRange)

# ╔═╡ 9a7987ad-435a-4bb7-b71a-44718e063d3d
begin
	RNG_dᵢ = @bind dᵢ @htl(""" 
	<input  type="range" 
	 		min = $(fi(inpParts)) 
	  		max = $(li(inpParts))  
	  		value =  $(fi(inpParts))
	
	 
			style="width: 90%;" 
			oninput="document.getElementById('lbl_dᵢ').innerHTML = this.value" 
	>""")
	
	 
	LBL_dᵢ = @htl("""
	<label id="lbl_dᵢ" 
	style="font-family: JuliaMono, Consolas, Courier;">$(fi(inpParts))</label> 
	""")
	 
	
	@htl("""<data>dᵢ</data> $(RNG_dᵢ)  $(LBL_dᵢ) """)
	 
end

# ╔═╡ b43ea412-614f-4a91-b586-71acc23eea6c
GaGa.showText(inpParts[dᵢ])

# ╔═╡ 96901d93-900a-4dd5-ba35-b7441393adce
inpParts[dᵢ]

# ╔═╡ 5fcd53dd-8600-4469-a70c-b50243a12a01
if show_inpVecVecStr
 
	NF_inpTop = @bind inpTop @htl("""
	<input type=number 
	       min = $(fi(inpParts[fileInpID]))  
	       max = $(li(inpParts[fileInpID])) 
	       value=1
	       style="text-align: right;"
	>
	""")

	
	if ℓ(inpParts[fileInpID]) <= 60 
		inpLenDefault = ℓ(inpParts[fileInpID])
	else
		inpLenDefault = 45
	end
	
	NF_inpLen = @bind inpLen @htl("""
	<input type=number 
	       min = 1 
	       max = $(ℓ(inpParts[fileInpID])) 
	       value=$inpLenDefault
	       style="text-align: right;"
	>	
	""")
	
	md""" 
	top line number: $(NF_inpTop) $(html"&emsp;")
	\# lines desired: $(NF_inpLen)
	"""
end

# ╔═╡ 3a6411dd-b187-48a3-8917-e7e81a6fefa2
if show_inpVecVecStr
	inpBot = inpTop + inpLen - 1

	if inpBot > li(inpParts[fileInpID])
		inpBot = li(inpParts[fileInpID])
	end
	
	if inpTop <= inpBot
		@htl("""<div class="guidance"> 
		 Showing line numbers $inpTop to $inpBot of $(li(inpParts[fileInpID]))
		 <br>
			
		$(GaGa.showText(inpParts[fileInpID][inpTop : inpBot]))

		</div>""")
	end
end

# ╔═╡ c2648cfc-2c3d-4308-86b0-15e71445770b
dsets = [parseDataset(raw)     for raw in inpParts]

# ╔═╡ 2f689281-2458-482d-bc32-4bb2e25beb89
begin
	RNG_dₚ = @bind dₚ @htl(""" 
	<input  type="range" 
	 		min = $(fi(dsets)) 
	  		max = $(li(dsets))  
	  		value =  $(fi(dsets))
	
	 
			style="width: 90%;" 
			oninput="document.getElementById('lbl_dₚ').innerHTML = this.value" 
	>""")
	
	 
	LBL_dₚ = @htl("""
	<label id="lbl_dₚ" 
	style="font-family: JuliaMono, Consolas, Courier;">$(fi(dsets))</label> 
	""")
	 
	
	@htl("""<data>dₚ</data> $(RNG_dₚ)  $(LBL_dₚ) """)
	 
end

# ╔═╡ 0b667319-4c86-4d46-9135-f5a2d4b5d958
dsets[dₚ]

# ╔═╡ 47d32647-9a74-478d-b495-2dabb66e2574
GaGa.showText(dsets[dₚ])

# ╔═╡ 3d96dfc1-5040-4a97-971c-c55c02104057
dsets[dₚ]

# ╔═╡ d7c4d7a2-0027-49de-9fd1-ddad87f77227
sln(dsets[1])

# ╔═╡ 823bce6b-27b8-4043-8862-f5b0f81ed0ea
slns = [sln(dsets[d])    for d in ei(dsets)]

# ╔═╡ c3a22126-3ace-4ee6-83ae-e91f272d830c
begin
	RNG_dₛ = @bind dₛ @htl(""" 
	<input  type="range" 
	 		min = $(fi(slns)) 
	  		max = $(li(slns))  
	  		value =  $(fi(slns))
	
	 
			style="width: 90%;" 
			oninput="document.getElementById('lbl_dₛ').innerHTML = this.value" 
	>""")
	
	 
	LBL_dₛ = @htl("""
	<label id="lbl_dₛ" 
	style="font-family: JuliaMono, Consolas, Courier;">$(fi(slns))</label> 
	""")
	 
	
	@htl("""<data>dₛ</data> $(RNG_dₛ)  $(LBL_dₛ) """)
	 
end

# ╔═╡ b5f70284-22eb-4702-a5a4-37b71f688400
slns[dₛ]

# ╔═╡ 21fe2ea3-7c9d-473f-9ea1-195ee9aa1563
slnParts = [sln(dsets[d])    for d in ei(inpParts)]

# ╔═╡ 68fa7d9e-c1d9-47ee-9f6e-350cce69db1d
exnPartsVecStr = get_IO(vec_urlOut, fileIDRange)

# ╔═╡ a7eb568d-221c-49b2-9069-3f50243208aa
exnParts = map(vecStr -> only(vecStr), exnPartsVecStr)

# ╔═╡ 4a8ea51b-6eb2-44c8-95ab-23e0f42737f7
exns = exnParts

# ╔═╡ 5d761469-be33-460c-bf73-75e9e40ba8aa
slns == exns

# ╔═╡ d93372bd-a9f7-4b87-b458-1ff41faccdde
begin
	RNG_dₑ = @bind dₑ @htl(""" 
	<input  type="range" 
	 		min = $(fi(exns)) 
	  		max = $(li(exns))  
	  		value =  $(fi(exns))
	
	 
			style="width: 90%;" 
			oninput="document.getElementById('lbl_dₑ').innerHTML = this.value" 
	>""")
	
	 
	LBL_dₑ = @htl("""
	<label id="lbl_dₑ" 
	style="font-family: JuliaMono, Consolas, Courier;">$(fi(exns))</label> 
	""")
	 
	
	@htl("""<data>dₑ</data> $(RNG_dₑ)  $(LBL_dₑ) """)
	 
end

# ╔═╡ b9b746c4-5acf-4cf7-ab7f-d4e757e5abd4
exns[dₑ]

# ╔═╡ 875299ac-a343-4aca-a59d-cf705e6cef25
if show_sideBySide

	i_sbsMax = maximum([ℓ(exnParts), ℓ(slnParts)])
 
	NF_sbsTop = @bind sbsTop @htl("""<input type=number min=1 max = $i_sbsMax value=1>""")

	
	
	if i_sbsMax <= 60 
		sbsLenDefault = i_sbsMax
	else
		sbsLenDefault = 30
	end
	
	NF_sbsLen = @bind sbsLen @htl("""<input type=number min=1 max = $i_sbsMax value=$sbsLenDefault>""")
 
	
	md""" 
	side-by-side Top $(NF_sbsTop) $(html"&emsp;") side-by-side Len $(NF_sbsLen)
	"""
  
end

# ╔═╡ 3c676a79-e8a4-4892-90c6-131baa6ba431
if show_sideBySide
	sbsBot = sbsTop + sbsLen - 1

	if sbsBot > i_sbsMax
		sbsBot = i_sbsMax
	end
	 
	GaGa.showText([exnParts[sbsTop:sbsBot], slnParts[sbsTop:sbsBot]])
end

# ╔═╡ 65c3473c-a622-4c2f-a71c-4632617f1fb3
if show_exnSln_Woven

	i_wvnMax = maximum([ℓ(slnParts), ℓ(exnParts)])
 
	NF_wvnTop = @bind wvnTop @htl("""<input type=number min=1 max = $i_wvnMax value=1>""")

	
	
	if i_wvnMax <= 20 
		wvnLenDefault = i_wvnMax
	else
		wvnLenDefault = 10
	end
	
	NF_wvnLen = @bind wvnLen @htl("""<input type=number min=1 max = $i_wvnMax value=$wvnLenDefault>""")


	NF_wvnSep = @bind wvnSep @htl("""<input type=number min=0 max=5 value=1>""")

	
	md""" 
	woven Top $(NF_wvnTop) $(html"&emsp;") woven Len $(NF_wvnLen)  $(html"&emsp;")  woven Sep $(NF_wvnSep) 
	"""
  
end

# ╔═╡ c9723306-9f26-4bed-b0cb-afbf511d452c
if show_exnSln_Woven
	wvnBot = wvnTop + wvnLen - 1

	if wvnBot > i_wvnMax
		wvnBot = i_wvnMax
	end
	 
	GaGa.showText(GaGa.woven(exnParts[wvnTop:wvnBot], slnParts[wvnTop:wvnBot], separation=wvnSep))	 
end

# ╔═╡ f20251e5-d2f0-4d77-a6bd-12f3fa52fc3a
 
begin
	diffIndices = []
	for i in ei(exnParts)
		if slnParts[i] != exnParts[i]
			push!(diffIndices, i)
		end
	end
	
	diffIndices
end

 

# ╔═╡ 3e2c7535-23f1-46fb-b0bd-3a5865542b64
diffsDsets = [dsets[i]    for i in diffIndices]

# ╔═╡ 6066ed69-2dc1-4742-ad37-124f83cb7afe
begin
	
	sames = Int[]
	diffs = Int[]

	for d in ei(dsets)
		if slnParts[d] == exnParts[d]
			push!(sames, d)
		else
			push!(diffs, d)
		end
	end


	sames, diffs
end 

# ╔═╡ 5511044f-1152-4a00-b1c6-caeb666ed200
diffsExn = [exnParts[i]    for i in diffIndices]

# ╔═╡ d5190f6e-5512-4c02-bf1d-570400369d6b
function get_OA_Vec_Str(vec_url, range)
	res = OffsetVector{Vector{String}}(undef, range)

	for i in range
		res[i] = GaGa.vecStrFrom_url(vec_url[i])
	end


	res
end

# ╔═╡ 45ab4a8c-0a99-4a27-b79a-0dd7dfa457fc
function get_OA_Str(vec_url, range)
	res = OffsetVector{String}(undef, range)

	for i in range
		res[i] = only( GaGa.vecStrFrom_url(vec_url[i]) )
	end


	res
end

# ╔═╡ 6e576828-6581-46d8-836c-be601cd3b318


# ╔═╡ 281d95fc-6e06-4fdd-be15-abc8987abd6e


# ╔═╡ 60a2a778-8f9c-4ff9-a49a-b3955927fef4


# ╔═╡ c1d779f3-886d-4a4b-ab89-81599740de25
html"""<div class="instructions">
📝  <br><br>

<pre><code class='language-julia'>	
function getDatasets(lines)
	
	 
	dTypeDataset = Tuple{Int, Vector{Tuple{Int, Int}}}

	res = dTypeDataset[]

	iOrigin = 1
	while ( dset = getDataset(lines, iOrigin) ) != nothing
		push!(res, dset)

		numNodes, edges = dset

		iOrigin += length(edges) + 1
	end

	
	res
end
</pre></code><br><br> 

</div>"""

# ╔═╡ f2674557-16df-4413-a321-d3e213ce35a3
function vSplit(raw::AbstractVector{String})
	
	res = Vector{String}[]
	
	vStripped = vStrip(raw)
	##return vStripped
	
	if length(vStripped) == 0;    return res;    end

	vecStr = [vStripped[1]]

 
	for i in 2:lastindex(vStripped)
		if vStripped[i] == ""
			push!(res, vecStr)		 
			vecStr = String[]			 
		else
			push!(vecStr, vStripped[i])
		end
	end
	push!(res, vecStr)


	
	res
end

# ╔═╡ 5f84ff10-b2b0-4ccd-954c-253557a0a378


# ╔═╡ cb3eba93-943f-4fac-9c52-e0ecf3383d32
html"""   
<div style="border-top: 1px solid purple"></div> 
<br>
 <div style="border-bottom: 1px solid violet"></div> 
"""

# ╔═╡ c1b190f2-2d39-4fce-be52-85a6c4a6d7ca
begin
	CB_cont_Pkgs_and_CSS = @bind cont_Pkgs_and_CSS html"<input type=Checkbox>"
	@htl("""<span style="font-weight: bold; 
	                     color: rgb(50, 100, 150);">
	        Continue
	        </span>
	     ⬇️$(CB_cont_Pkgs_and_CSS)""")
end

# ╔═╡ f73c83b7-2726-463c-9e35-3077d0af9f46


# ╔═╡ 6ad22f86-0dd2-401f-9219-268606490cf5


# ╔═╡ efe7a2e1-932d-4b26-8bcd-d755141cce90
function partitionInp(orig)
	D = parse(Int, first(orig))

	res = Vector{Vector{String}}(undef, D)

	iₕ = fi(orig) + 1 # header index for dataset
	for d in 1:D
		t, a, b = [parse(Int, s)      for s in split(orig[iₕ])]
		n, m = [parse(Int, s)      for s in split(orig[iₕ+1])]
		
		
		iₑ = iₕ+1+n+m
		
		res[d] = orig[iₕ:iₑ]

		
	 	iₕ = iₑ+1
	end


	res
end

# ╔═╡ 208ae351-c9dc-4003-81a0-cd167ed1f3ee
inpPrtnd = partitionInp(inpOrig)

# ╔═╡ 87c66094-1783-46cf-95c7-54817a5e21af
# hide_everything_below

# ╔═╡ 37348ff5-3f05-4c2d-8e67-1ee70c799c89
hide_everything_below =
	html"""
	<style>
	pluto-cell.hide_everything_below ~ pluto-cell {
		display: none;
	}
	</style>
	
	<script>
	const cell = currentScript.closest("pluto-cell")
	
	const setclass = () => {
		console.log("change!")
		cell.classList.toggle("hide_everything_below", true)
	}
	setclass()
	const observer = new MutationObserver(setclass)
	
	observer.observe(cell, {
		subtree: false,
		attributeFilter: ["class"],
	})
	
	invalidation.then(() => {
		observer.disconnect()
		cell.classList.toggle("hide_everything_below", false)
	})
	
	</script>
	""";

# ╔═╡ 7c8deda8-9ecc-495c-9add-7e05a3b07e33
if cont_Pkgs_and_CSS === false;   hide_everything_below;     end

# ╔═╡ Cell order:
# ╠═74426140-9f48-4e7c-95ef-57dff5864d3f
# ╠═1c5dac5f-e58e-443c-a4cd-3dfcd9fba2f4
# ╠═e454ec75-4cc4-4dad-b41d-76a73fc38222
# ╠═9a35b368-0c05-49c3-b677-ba19c9aa7a9c
# ╟─ce785f59-4031-4447-baac-26c65b356abf
# ╟─f87c9399-1c8e-4cb2-94b7-81247233ff6f
# ╟─7127b4f6-b50e-4bda-815d-8c567fbd4a66
# ╟─3a1e6e0f-c819-46f1-8e6e-60e51f829fc8
# ╟─15c169cc-6211-429d-bdd4-b7d5bc2b2290
# ╟─edfb2419-58c7-4534-a070-d45696c4318f
# ╟─cbfec70e-e8f8-4a84-847a-97690e6ff845
# ╟─456310a1-3993-44f2-af3a-4ca22a6280e7
# ╟─33814c7d-e97c-419e-bc98-b78480ee18c6
# ╠═9ad9f0f4-52c0-40f1-81fd-a36d67e36cb0
# ╟─9312b5b5-2028-47e1-8d5b-6614a8b1800d
# ╠═ac85d673-cbe9-4d87-8b89-17889358ff25
# ╠═592dc70b-c2d8-4ceb-970c-469f76970c00
# ╠═b43ea412-614f-4a91-b586-71acc23eea6c
# ╟─9a7987ad-435a-4bb7-b71a-44718e063d3d
# ╠═96901d93-900a-4dd5-ba35-b7441393adce
# ╟─a3fca05d-bc94-40f4-a334-b05295214dc5
# ╟─9ab2961f-03d7-4e1b-b0d2-6426e4572126
# ╟─5fcd53dd-8600-4469-a70c-b50243a12a01
# ╟─3a6411dd-b187-48a3-8917-e7e81a6fefa2
# ╟─8830d6cc-2e76-45d2-b7fd-e10cce01994f
# ╟─6840b9a9-05b3-4293-aac1-3a2a24c168ee
# ╠═e3318a07-5aad-49bf-9097-6505a8b2ca82
# ╠═c2648cfc-2c3d-4308-86b0-15e71445770b
# ╟─2f689281-2458-482d-bc32-4bb2e25beb89
# ╠═0b667319-4c86-4d46-9135-f5a2d4b5d958
# ╠═47d32647-9a74-478d-b495-2dabb66e2574
# ╠═3d96dfc1-5040-4a97-971c-c55c02104057
# ╠═dd722c14-65f0-46c8-bdd3-769a65043c57
# ╠═91c122c8-05b7-4193-865a-426b858ed113
# ╟─4330ba6b-0fa9-410b-a7df-cfa6479a53cb
# ╟─e15eda21-2997-4c0d-8fa1-ad21a7c61a04
# ╠═9cdc7670-0504-40f9-acd6-bbf248c1919e
# ╠═7e9a4175-8c1e-4c94-8852-6932485b4ff3
# ╟─b9ece6e4-6ffc-4276-944d-1b15f9927509
# ╠═69317844-4c2d-491d-93a4-d8385eddaea6
# ╠═d7c4d7a2-0027-49de-9fd1-ddad87f77227
# ╠═823bce6b-27b8-4043-8862-f5b0f81ed0ea
# ╟─c3a22126-3ace-4ee6-83ae-e91f272d830c
# ╠═b5f70284-22eb-4702-a5a4-37b71f688400
# ╠═0aa04f5f-be01-4a16-8dfa-a032f0bfb9b5
# ╠═4a8ea51b-6eb2-44c8-95ab-23e0f42737f7
# ╠═5d761469-be33-460c-bf73-75e9e40ba8aa
# ╠═b9b746c4-5acf-4cf7-ab7f-d4e757e5abd4
# ╠═d93372bd-a9f7-4b87-b458-1ff41faccdde
# ╠═b8e71a33-ac3e-4b57-b932-a3b5aba0a515
# ╟─504403a1-fb73-4e00-be57-8385c05435f2
# ╟─b52cb4e1-1277-43c1-8be8-56f2cd305276
# ╟─e0e429c5-a6e6-4b79-b93b-d2900acc362b
# ╟─946b01ec-741d-49fb-ac4c-8e22b6a34504
# ╟─2b906643-f0bc-477e-926d-36c93686bdc4
# ╟─2617d0e4-40cc-4a27-811f-7e35cfa336b3
# ╟─7aa1e550-2e6b-4024-9912-469864467054
# ╟─b983505a-550c-4d08-900a-b54f16b1598c
# ╟─0e266d7c-92f4-436d-b08f-cb182f78c447
# ╟─3c731af7-dd5d-4faa-a4be-7d7695f61a66
# ╟─9fd1dc27-e9c2-4da5-8b4d-d37ee5fe286c
# ╟─6f3a4855-73b0-4755-9b4b-741de291322b
# ╟─588069dd-ce5d-42c1-8bb9-26f704bb2352
# ╟─bd6ec7ba-b342-46a8-955f-f2d18912778d
# ╟─e0b4231f-5d35-45d6-be1d-35cb7fadbc85
# ╟─875299ac-a343-4aca-a59d-cf705e6cef25
# ╟─3c676a79-e8a4-4892-90c6-131baa6ba431
# ╟─c077432c-3da8-4f38-93fb-802704b506d9
# ╟─65c3473c-a622-4c2f-a71c-4632617f1fb3
# ╟─c9723306-9f26-4bed-b0cb-afbf511d452c
# ╠═14466cbf-656b-4b36-aa45-68f964026336
# ╠═aa091b16-ef38-49aa-9492-8d55a995165c
# ╠═68fa7d9e-c1d9-47ee-9f6e-350cce69db1d
# ╠═a7eb568d-221c-49b2-9069-3f50243208aa
# ╠═21fe2ea3-7c9d-473f-9ea1-195ee9aa1563
# ╠═f20251e5-d2f0-4d77-a6bd-12f3fa52fc3a
# ╠═6066ed69-2dc1-4742-ad37-124f83cb7afe
# ╠═1dd0b634-37ff-46c1-b3cf-1d97b792fa6b
# ╟─6d461faf-d290-4689-b829-1d06209f3f19
# ╟─9408575b-2c40-4eb3-882c-07d4952cbf54
# ╟─77607f34-ba86-4348-b2ca-17d5087506e7
# ╟─da869f84-2cbc-43af-a258-9532a4927374
# ╟─61459cf9-3541-4b02-a670-fdc593de4095
# ╟─6043e040-77b5-406f-b7d4-5955b0f11d43
# ╠═08ed1e71-4c22-441c-a931-eb2de187139c
# ╟─ee979dc1-f66d-4f83-af87-2fa71c8104f5
# ╠═3e2c7535-23f1-46fb-b0bd-3a5865542b64
# ╠═5511044f-1152-4a00-b1c6-caeb666ed200
# ╠═1e903710-7acd-45f1-9a76-44811ed7c68e
# ╠═892fa24a-057e-406a-b424-59ed0aa823f6
# ╠═04e5c074-85ea-4ef5-82d7-ad954eb98fda
# ╠═ac9615fc-e19b-48b5-9884-8658aed9a775
# ╠═2cb56698-7ef9-4f74-aefa-e8104d559822
# ╠═b72d1627-8607-4f56-beb8-99e5cc8b439e
# ╠═f2d8abe1-8ab2-4221-9194-2d3fb24dcf5e
# ╠═cc70315f-96fc-4c25-80c5-2a168ed4cdb6
# ╠═4c161d45-ccef-4919-8818-3d13a8a39f01
# ╠═bb518a47-f813-461a-9908-056d1a20cbbe
# ╠═ff844525-e446-436c-8de5-b39f99556f66
# ╠═ecd9b7be-11b2-4015-ad02-9b97de881a55
# ╠═6d500b52-3931-47c4-81fb-01056b68106a
# ╟─dcd03de9-7054-4d5c-b67e-03c98f1106ae
# ╟─0dc30566-d013-41c9-85fa-6ed2a0896fc5
# ╟─e4bf0354-a17e-4f27-969b-61e28aabcbbc
# ╟─3bbfbf82-4ea5-4608-9cc2-e57c6dc633ed
# ╠═208ae351-c9dc-4003-81a0-cd167ed1f3ee
# ╠═f4a71b19-b2e0-46e6-b0a3-68c921416efa
# ╠═a0beecc9-192f-4a68-99e3-03993da1ae0a
# ╠═2e46a838-08cc-48a4-8fc7-4dff6884ac5e
# ╠═8ba66db6-b59f-49cb-9dd6-6fd9b26d90ad
# ╠═1e132c3d-f5a1-48a9-9611-79272068f0c2
# ╠═b52cc127-d4a4-4ed5-a938-a068f17ddb86
# ╠═20436422-cdc9-43cd-82b8-489ce9928752
# ╠═cbdc8055-5367-4b7e-bb6d-3cc70dcf4aa9
# ╠═cb3abc6b-40ae-4f3f-b213-94a05c49be51
# ╠═fb9f3cb9-9137-4df7-bf21-60eaf6f62278
# ╠═4d0bc608-081c-4661-bd17-28f8c60d92df
# ╟─e811ef4a-cdfc-466f-af6a-b1177bf2d285
# ╟─3c9f0e2e-eab3-495d-bb91-684ccfbf98e1
# ╠═31436936-6418-4c65-9311-dc29dd99df64
# ╟─27121dc3-010e-43fd-8e74-a8c26db9cc7b
# ╟─8eddf751-4f46-4b89-9dbe-bcfa27b30e90
# ╠═cfe0692c-06be-46c2-89b1-2a6c6fcaeb4a
# ╠═9534d7db-789c-4231-83dd-4d9f769e7132
# ╟─ca720adc-39ab-4b8f-abd6-29ea687e22b3
# ╟─d5190f6e-5512-4c02-bf1d-570400369d6b
# ╟─45ab4a8c-0a99-4a27-b79a-0dd7dfa457fc
# ╠═6e576828-6581-46d8-836c-be601cd3b318
# ╠═281d95fc-6e06-4fdd-be15-abc8987abd6e
# ╠═60a2a778-8f9c-4ff9-a49a-b3955927fef4
# ╠═992e042f-e6db-47b0-a07f-93e9447287d7
# ╟─c1d779f3-886d-4a4b-ab89-81599740de25
# ╟─f2674557-16df-4413-a321-d3e213ce35a3
# ╠═5f84ff10-b2b0-4ccd-954c-253557a0a378
# ╟─cb3eba93-943f-4fac-9c52-e0ecf3383d32
# ╠═c1b190f2-2d39-4fce-be52-85a6c4a6d7ca
# ╠═7c8deda8-9ecc-495c-9add-7e05a3b07e33
# ╠═f73c83b7-2726-463c-9e35-3077d0af9f46
# ╠═6ad22f86-0dd2-401f-9219-268606490cf5
# ╟─efe7a2e1-932d-4b26-8bcd-d755141cce90
# ╠═87c66094-1783-46cf-95c7-54817a5e21af
# ╠═37348ff5-3f05-4c2d-8e67-1ee70c799c89
