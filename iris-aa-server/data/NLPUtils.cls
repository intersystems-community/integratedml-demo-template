<?xml version="1.0" encoding="UTF-8"?>
<Export generator="IRIS" version="26">
<Class name="%ML.NLPUtils">
<IncludeCode>%IKInclude</IncludeCode>
<TimeCreated>65407,36216.674515</TimeCreated>

<Method name="DropView">
<ClassMethod>1</ClassMethod>
<FormalSpec>pViewName:%String</FormalSpec>
<ReturnType>%Status</ReturnType>
<SqlName>Drop_NLP</SqlName>
<SqlProc>1</SqlProc>
<Implementation><![CDATA[
	set tSC = $$$OK
	try {
		
		// drop domain
		do $classmethod(pViewName_".Domain","%DropData")
		do $system.OBJ.Delete(pViewName_".Domain","-d")
		
		// drop table
		do $classmethod(pViewName_".Features","%KillExtent")
		do $system.OBJ.Delete(pViewName_".Features","-d")
		
		// drop view
		do $system.OBJ.Delete(pViewName,"-d")
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
]]></Implementation>
</Method>

<Method name="BuildView">
<ClassMethod>1</ClassMethod>
<FormalSpec><![CDATA[pFrom:%String,pTextColumn:%String,&pViewName:%String,pIDColumn:%String="ID",pTopCount:%Integer=200,pTopMetric:%String="freq",pVerbose:%Boolean=1]]></FormalSpec>
<ReturnType>%Status</ReturnType>
<SqlName>Build_NLP</SqlName>
<SqlProc>1</SqlProc>
<Implementation><![CDATA[
	set tSC = $$$OK
	try {
		// check / generate name
		if $g(pViewName)="" {
			set i = "", pViewName = $s($zname(pFrom,4):pFrom, 1:"NLP.Temp")
			while $$$defClassDefined(pViewName_i) { set i=i+1 }
			set pViewName = pViewName_i
		} elseif '$zname(pViewName,4) {
			set tSC = $$$ERROR($$$GeneralError, "Invalid name for view: "_pViewName)
			quit:$$$ISERR(tSC)
		}
		
		set tTopMetric = $e($$$UPPER(pTopMetric),1,4)
		
		// check query
		set tStatement = ##class(%SQL.Statement).%New()
		set tSQL = $s($f(pFrom," "):pFrom,1:"SELECT * FROM "_pFrom)
		set tSC = tStatement.%Prepare(tSQL)
		quit:$$$ISERR(tSC)
		
		// iKnow Domain
		set tBuildFlags = $tr($$$MINBUILDFLAGS,$c($$$IKBFNEVER,$$$IKBFALWAYS),"09"),
			$e(tBuildFlags,$$$IKBENTUNIDET)=9
		set:tTopMetric="FREQ" $e(tBuildFlags,$$$IKBENTUNIFREQ)=9
		set:tTopMetric="SPRE" $e(tBuildFlags,$$$IKBENTUNISPREAD)=9
		set tDomain = ##class(%iKnow.Model.domain).%New()
		set tDomain.name = pViewName
		set tDomain.buildFlags = tBuildFlags
		set tDomain.data = ##class(%iKnow.Model.data).%New()
		set tDomainSource = ##class(%iKnow.Model.listQuery).%New()
		set tDomainSource.data = tDomain.data
		set tDomainSource.sql = tSQL
		set tDomainSource.idField = pIDColumn
		set tDomainSource.groupField = pIDColumn
		set tDomainSource.dataFields = pTextColumn
		set tDomainParam = ##class(%iKnow.Model.parameter).%New()
		set tDomainParam.parent = tDomain
		set tDomainParam.name = $$$IKPSIMPLEEXTIDS
		set tDomainParam.value = 1
		if pVerbose {
			set tDomainParam = ##class(%iKnow.Model.parameter).%New()
			set tDomainParam.parent = tDomain
			set tDomainParam.name = $$$IKPSTATUS
			set tDomainParam.value = 1
		}
		
		set tSC = tDomain.%SaveToClass(pViewName_".Domain",0,pVerbose,1)
		quit:$$$ISERR(tSC)
		
		
		// Feature table
		set tTableClass = ##class(%Dictionary.ClassDefinition).%New()
		set tTableClass.Name = pViewName_".Features"
		set tTableClass.SqlRowIdPrivate = 1
		set tTableClass.ProcedureBlock = 1
		set tTableClass.Super = "%Persistent"
		
		do AddColumn(tTableClass, "NLP_ID", "Identifier corresponding to '"_pIDColumn_"' in source query")
		set tIndexDef = ##class(%Dictionary.IndexDefinition).%New()
		set tIndexDef.parent = tTableClass
		set tIndexDef.Name = "IDKEY"
		set tIndexDef.Properties = "NLPID"
		set tIndexDef.Unique = 1
		set tIndexDef.PrimaryKey = 1
		set tIndexDef.IdKey = 1
		
		set tSC = tTableClass.%Save()
		quit:$$$ISERR(tSC)
		
		// view
		set tViewClass = ##class(%Dictionary.ClassDefinition).%New()
		set tViewClass.Name = pViewName
		set tViewClass.ClassType = "view"
		set tViewClass.ViewQuery = "SELECT * FROM "_$s($f(pFrom," "):"("_pFrom_")",1:pFrom)_" s JOIN "_$tr(pViewName,".","_")_".Features f ON f.NLP_ID = s."_pIDColumn
		set tViewClass.CompileAfter = tTableClass.Name
		set tViewClass.ProcedureBlock = 1
		w:pVerbose !,"View query:",!,tViewClass.ViewQuery,!
		
		set tSC = tViewClass.%Save()
		quit:$$$ISERR(tSC)
		
		set tSC = $system.OBJ.Compile(tViewClass.Name,"ck"_$s(pVerbose:"d",1:"-d"))
		quit:$$$ISERR(tSC)
		
		// build domain
		set tSC = $classmethod(pViewName_".Domain","%Build",pVerbose)
		quit:$$$ISERR(tSC)
		
		// select features
		write:pVerbose !,"Retrieving top ",pTopCount," entities by ",pTopMetric
		set tDomainId = $system.iKnow.GetDomainId(pViewName)
		if tTopMetric="FREQ" {
			set tSC = ##class(%iKnow.Queries.EntityAPI).GetTop(.tEntities, tDomainId, 1, pTopCount,,,$$$SORTBYFREQUENCY)
		} elseif tTopMetric="SPRE" {
			set tSC = ##class(%iKnow.Queries.EntityAPI).GetTop(.tEntities, tDomainId, 1, pTopCount,,,$$$SORTBYSPREAD)
		} elseif tTopMetric="BM25" {
			set tSC = ##class(%iKnow.Queries.EntityAPI).GetTopBM25(.tEntities, tDomainId, 1, pTopCount)
		} elseif tTopMetric="TFID" {
			set tSC = ##class(%iKnow.Queries.EntityAPI).GetTopTFIDF(.tEntities, tDomainId, 1, pTopCount)
		} else {
			set tSC = $$$ERROR($$$GeneralError, "Unknown entity selection metric: "_pTopMetric)
		}
		quit:$$$ISERR(tSC)
		write:pVerbose !,"Setting up feature table"
		
		set i="", tEntUniIds=""
		for {
			set i = $order(tEntities(i),1,tEntity)
			quit:i=""
			
			set tEntUniId = $lg(tEntity,1),
				tEntValue = $lg(tEntity,2),
				tPropName = "NLP"_$tr(tEntValue,"_- ""'+$=<>[](){}/\|.;,:=?"),
				tPropNames(tEntUniId)=tPropName,
				tEntUniIds = tEntUniIds_","_tEntUniId
			
			if $d(tPropIndex(tPropName)) {
				// duplicate! - ignore for now, we'll just sum up frequencies
			} else {
				do AddColumn(tTableClass,tPropName,"Frequency for '"_tEntValue_"' (ID:"_tEntUniId_")") 
			}
			set tPropIndex(tPropName,tEntUniId)=""
		}
		set tSC = tTableClass.%Save()
		quit:$$$ISERR(tSC)
		
		set tSC = $system.OBJ.Compile(tTableClass.Name,"ck"_$s(pVerbose:"d",1:"-d"))
		quit:$$$ISERR(tSC)
		
		write:pVerbose !,"Populating feature table"
		set tSC = tStatement.%Prepare("SELECT EntUniId, FrequencyAsConcept+FrequencyAsRelation Frequency FROM %iKnow_Objects.EntityInSourceDetails WHERE DomainId = "_tDomainId_" AND SourceId = ? AND EntUniId IN ("_$e(tEntUniIds,2,*)_")")
		quit:$$$ISERR(tSC)
		set tRS1 = ##class(%SQL.Statement).%ExecDirect(,"SELECT SourceId, LocalReference FROM %iKnow_Objects.Source where domainid = "_tDomainId)
		while tRS1.%Next() {
			set tRow = $classmethod(tTableClass.Name,"%New")
			set tRow.NLPID = tRS1.%Get("LocalReference")
			set tRS2 = tStatement.%Execute(tRS1.%Get("SourceId"))
			while tRS2.%Next() {
				set $property(tRow, tPropNames(tRS2.%Get("EntUniId"))) = $property(tRow, tPropNames(tRS2.%Get("EntUniId"))) + tRS2.%Get("Frequency")
			}
			set tSC = tRow.%Save()
			quit:$$$ISERR(tSC)
		}
		quit:$$$ISERR(tSC)
		
		write:pVerbose !
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	if $$$ISERR(tSC) && pVerbose {
		write !
		do $system.OBJ.DisplayError(tSC)
		write !
	}
	quit tSC
	
AddColumn(cls, name, desc, type="%Integer")
	set prop = ##class(%Dictionary.PropertyDefinition).%New()
	set prop.parent = cls
	if '$zname(name,6) {
		set prop.SqlFieldName = name
		set prop.Name = $tr(name,"_- ""'+$=<>[](){}/\|.;,:=?")
	} else {
		set prop.Name = name
	}
	set prop.Description = desc
	set prop.Type = type
	quit
	
AddParam(cls, name, value)
	set param = ##class(%Dictionary.ParameterDefinition).%New()
	set param.parent = cls
	set param.Name = name
	set param.Default = value
]]></Implementation>
</Method>
</Class>
</Export>
