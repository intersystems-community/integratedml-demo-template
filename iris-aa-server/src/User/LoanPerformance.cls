Class User.LoanPerformance Extends %Persistent
{

Property DisbursedAmount As %Integer;

Property AssetCost As %Integer;

Property LTV As %Double;

Property BranchId As %Integer;

Property SupplierId As %Integer;

Property ManufacturerId As %Integer;

Property CurrentPincodeId As %Integer;

Property DateOfBirth As %Date;

Property EmploymentType As %String;

Property DisbursalDate As %Date;

Property StateId As %Integer;

Property EmployeeCodeId As %Integer;

Property MobileNumberAvailable As %Boolean;

Property Aadhar As %Boolean;

Property PAN As %Boolean;

Property Voter As %Boolean;

Property Driving As %Boolean;

Property Passport As %Boolean;

Property CNSScore As %Integer;

Property CNSScoreDescription As %String(MAXLEN = 256);

Property PrimaryAccounts As %Integer;

Property PrimaryAccountsActive As %Integer;

Property PrimaryAccountsOverdue As %Integer;

Property PrimaryCurrentBalance As %Integer;

Property PrimarySanctionedAmount As %Integer;

Property PrimaryDisbursedAmount As %Integer;

Property SecondaryAccounts As %Integer;

Property SecondaryAccountsActive As %Integer;

Property SecondaryAccountsOverdue As %Integer;

Property SecondaryCurrentBalance As %Integer;

Property SecondarySanctionedAmount As %Integer;

Property SecondaryDisbursedAmount As %Integer;

Property PrimaryInstallmentAmount As %Integer;

Property SecondaryInstallmentAmount As %Integer;

Property NewAccountsLastSixMonths As %Integer;

Property DelinquentAccountsLastSixMonths As %Integer;

Property AverageAccountAgeMonths As %Integer;

Property CreditHistoryLengthMonths As %Integer;

Property Inquiries As %Integer;

Property LoanDefault As %Boolean;

Index LoanDefault On LoanDefault [ Type = bitmap ];

Index AssetCost On AssetCost;

ClassMethod Load(csv As %String)
{
	Do ..%KillExtent()
	Set in=##class(%Stream.FileCharacter).%New()
	Set sc=in.LinkToFile(csv)
	Set count = 0
	While 'in.AtEnd {
		Set line=in.ReadLine()
		If '+line CONTINUE //skip header
		Do ..LoadOne(line)
		Set count = count + 1
	}
	Write count _ " records loaded",!
}

ClassMethod LoadOne(line As %String)
{
	Set o = ..%New()
	Set col = 1
	Set o.DisbursedAmount = $p(line,",",$i(col))
	Set o.AssetCost = $p(line,",",$i(col))
	Set o.LTV = $p(line,",",$i(col))
	Set o.BranchId = $p(line,",",$i(col))
	Set o.SupplierId = $p(line,",",$i(col))
	Set o.ManufacturerId = $p(line,",",$i(col))
	Set o.CurrentPincodeId = $p(line,",",$i(col))
	Set o.DateOfBirth = ..ToDate($p(line,",",$i(col)))
	Set o.EmploymentType = $p(line,",",$i(col))
	Set o.DisbursalDate = ..ToDate($p(line,",",$i(col)))
	Set o.StateId = $p(line,",",$i(col))
	Set o.EmployeeCodeId = $p(line,",",$i(col))
	Set o.MobileNumberAvailable = $p(line,",",$i(col))
	Set o.Aadhar = $p(line,",",$i(col))
	Set o.PAN = $p(line,",",$i(col))
	Set o.Voter = $p(line,",",$i(col))
	Set o.Driving = $p(line,",",$i(col))
	Set o.Passport = $p(line,",",$i(col))
	Set o.CNSScore = $p(line,",",$i(col))
	Set o.CNSScoreDescription = $p(line,",",$i(col))
	Set o.PrimaryAccounts = $p(line,",",$i(col))
	Set o.PrimaryAccountsActive = $p(line,",",$i(col))
	Set o.PrimaryAccountsOverdue = $p(line,",",$i(col))
	Set o.PrimaryCurrentBalance = $p(line,",",$i(col))
	Set o.PrimarySanctionedAmount = $p(line,",",$i(col))
	Set o.PrimaryDisbursedAmount = $p(line,",",$i(col))
	Set o.SecondaryAccounts = $p(line,",",$i(col))
	Set o.SecondaryAccountsActive = $p(line,",",$i(col))
	Set o.SecondaryAccountsOverdue = $p(line,",",$i(col))
	Set o.SecondaryCurrentBalance = $p(line,",",$i(col))
	Set o.SecondarySanctionedAmount = $p(line,",",$i(col))
	Set o.SecondaryDisbursedAmount = $p(line,",",$i(col))
	Set o.PrimaryInstallmentAmount = $p(line,",",$i(col))
	Set o.SecondaryInstallmentAmount = $p(line,",",$i(col))
	Set o.NewAccountsLastSixMonths = $p(line,",",$i(col))
	Set o.DelinquentAccountsLastSixMonths = $p(line,",",$i(col))
	Set o.AverageAccountAgeMonths = ..ToMonths($p(line,",",$i(col)))
	Set o.CreditHistoryLengthMonths = ..ToMonths($p(line,",",$i(col)))
	Set o.Inquiries = $p(line,",",$i(col))
	Set o.LoanDefault = $p(line,",",$i(col))
	Set sc = o.%Save()
	If 'sc throw ##class(%Exception.StatusException).CreateFromStatus(sc)
}

ClassMethod ToMonths(str) As %Integer
{
	Set months = 0
	Set months = months + (+str * 12)
	Set months = months + (+$p(str," ",2))
	Return months
}

ClassMethod ToDate(str) As %Date
{
	Set day = $p(str,"-",1)
	Set mon = $p(str,"-",2)
	Set yr2 = $p(str,"-",3)
	Set yr = $s(yr2 < 20:"20",1:"19")_yr2
	Return ##class(%Date).DisplayToLogical(mon_"/"_day_"/"_yr)
}

Storage Default
{
<Data name="LoanPerformanceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DisbursedAmount</Value>
</Value>
<Value name="3">
<Value>AssetCost</Value>
</Value>
<Value name="4">
<Value>LTV</Value>
</Value>
<Value name="5">
<Value>BranchId</Value>
</Value>
<Value name="6">
<Value>SupplierId</Value>
</Value>
<Value name="7">
<Value>ManufacturerId</Value>
</Value>
<Value name="8">
<Value>CurrentPincodeId</Value>
</Value>
<Value name="9">
<Value>DateOfBirth</Value>
</Value>
<Value name="10">
<Value>EmploymentType</Value>
</Value>
<Value name="11">
<Value>DisbursalDate</Value>
</Value>
<Value name="12">
<Value>StateId</Value>
</Value>
<Value name="13">
<Value>EmployeeCodeId</Value>
</Value>
<Value name="14">
<Value>MobileNumberAvailable</Value>
</Value>
<Value name="15">
<Value>Aadhar</Value>
</Value>
<Value name="16">
<Value>PAN</Value>
</Value>
<Value name="17">
<Value>Voter</Value>
</Value>
<Value name="18">
<Value>Driving</Value>
</Value>
<Value name="19">
<Value>Passport</Value>
</Value>
<Value name="20">
<Value>CNSScore</Value>
</Value>
<Value name="21">
<Value>PrimaryAccounts</Value>
</Value>
<Value name="22">
<Value>PrimaryAccountsActive</Value>
</Value>
<Value name="23">
<Value>PrimaryAccountsOverdue</Value>
</Value>
<Value name="24">
<Value>PrimaryCurrentBalance</Value>
</Value>
<Value name="25">
<Value>PrimarySanctionedAmount</Value>
</Value>
<Value name="26">
<Value>PrimaryDisbursedAmount</Value>
</Value>
<Value name="27">
<Value>SecondaryAccounts</Value>
</Value>
<Value name="28">
<Value>SecondaryAccoutsActive</Value>
</Value>
<Value name="29">
<Value>SecondaryAccountsOverdue</Value>
</Value>
<Value name="30">
<Value>SecondaryCurrentBalance</Value>
</Value>
<Value name="31">
<Value>SecondarySanctionedAmount</Value>
</Value>
<Value name="32">
<Value>SecondaryDisbursedAmount</Value>
</Value>
<Value name="33">
<Value>PrimaryInstallmentAmount</Value>
</Value>
<Value name="34">
<Value>SecondaryInstallmentAmount</Value>
</Value>
<Value name="35">
<Value>NewAccountsLastSixMonths</Value>
</Value>
<Value name="36">
<Value>DelinquentAccountsLastSixMonths</Value>
</Value>
<Value name="37">
<Value>AverageAccountAgeMonths</Value>
</Value>
<Value name="38">
<Value>CreditHistoryLengthMonths</Value>
</Value>
<Value name="39">
<Value>Inquiries</Value>
</Value>
<Value name="40">
<Value>LoanDefault</Value>
</Value>
<Value name="41">
<Value>CNSScoreDescription</Value>
</Value>
<Value name="42">
<Value>SecondaryAccountsActive</Value>
</Value>
</Data>
<DataLocation>^User.LoanPerformanceD</DataLocation>
<DefaultData>LoanPerformanceDefaultData</DefaultData>
<IdFunction>sequence</IdFunction>
<IdLocation>^User.LoanPerformanceD</IdLocation>
<IndexLocation>^User.LoanPerformanceI</IndexLocation>
<StreamLocation>^User.LoanPerformanceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
