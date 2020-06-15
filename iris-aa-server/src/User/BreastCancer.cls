Class User.BreastCancer Extends (%Persistent, %XML.Adaptor) [ SqlTableName = "" ]
{

Property Diagnosis As %String [ SqlColumnNumber = 2 ];

Property MeanRadius As %Numeric [ SqlColumnNumber = 3 ];

Property MeanTexture As %Numeric [ SqlColumnNumber = 4 ];

Property MeanPerimeter As %Numeric [ SqlColumnNumber = 5 ];

Property MeanArea As %Numeric [ SqlColumnNumber = 6 ];

Property MeanSmoothness As %Numeric [ SqlColumnNumber = 7 ];

Property MeanCompactness As %Numeric [ SqlColumnNumber = 8 ];

Property MeanConcavity As %Numeric [ SqlColumnNumber = 9 ];

Property MeanConcavePoints As %Numeric [ SqlColumnNumber = 10 ];

Property MeanSymmetry As %Numeric [ SqlColumnNumber = 11 ];

Property MeanFractalDimension As %Numeric [ SqlColumnNumber = 12 ];

Property StandardRadius As %Numeric [ SqlColumnNumber = 13 ];

Property StandardTexture As %Numeric [ SqlColumnNumber = 14 ];

Property StandardPerimeter As %Numeric [ SqlColumnNumber = 15 ];

Property StandardArea As %Numeric [ SqlColumnNumber = 16 ];

Property StandardSmoothness As %Numeric [ SqlColumnNumber = 17 ];

Property StandardCompactness As %Numeric [ SqlColumnNumber = 18 ];

Property StandardConcavity As %Numeric [ SqlColumnNumber = 19 ];

Property StandardConcavePoints As %Numeric [ SqlColumnNumber = 20 ];

Property StandardSymmetry As %Numeric [ SqlColumnNumber = 21 ];

Property StandardFractalDimension As %Numeric [ SqlColumnNumber = 22 ];

Property WorstRadius As %Numeric [ SqlColumnNumber = 23 ];

Property WorstTexture As %Numeric [ SqlColumnNumber = 24 ];

Property WorstPerimeter As %Numeric [ SqlColumnNumber = 25 ];

Property WorstArea As %Numeric [ SqlColumnNumber = 26 ];

Property WorstSmoothness As %Numeric [ SqlColumnNumber = 27 ];

Property WorstCompactness As %Numeric [ SqlColumnNumber = 28 ];

Property WorstConcavity As %Numeric [ SqlColumnNumber = 29 ];

Property WorstConcavePoints As %Numeric [ SqlColumnNumber = 30 ];

Property WorstSymmetry As %Numeric [ SqlColumnNumber = 31 ];

Property WorstFractalDimension As %Numeric [ SqlColumnNumber = 32 ];

Storage Default
{
<Data name="BreastCancerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Diagnosis</Value>
</Value>
<Value name="3">
<Value>MeanRadius</Value>
</Value>
<Value name="4">
<Value>MeanTexture</Value>
</Value>
<Value name="5">
<Value>MeanPerimeter</Value>
</Value>
<Value name="6">
<Value>MeanArea</Value>
</Value>
<Value name="7">
<Value>MeanSmoothness</Value>
</Value>
<Value name="8">
<Value>MeanCompactness</Value>
</Value>
<Value name="9">
<Value>MeanConcavity</Value>
</Value>
<Value name="10">
<Value>MeanConcavePoints</Value>
</Value>
<Value name="11">
<Value>MeanSymmetry</Value>
</Value>
<Value name="12">
<Value>MeanFractalDimension</Value>
</Value>
<Value name="13">
<Value>StandardRadius</Value>
</Value>
<Value name="14">
<Value>StandardTexture</Value>
</Value>
<Value name="15">
<Value>StandardPerimeter</Value>
</Value>
<Value name="16">
<Value>StandardArea</Value>
</Value>
<Value name="17">
<Value>StandardSmoothness</Value>
</Value>
<Value name="18">
<Value>StandardCompactness</Value>
</Value>
<Value name="19">
<Value>StandardConcavity</Value>
</Value>
<Value name="20">
<Value>StandardConcavePoints</Value>
</Value>
<Value name="21">
<Value>StandardSymmetry</Value>
</Value>
<Value name="22">
<Value>StandardFractalDimension</Value>
</Value>
<Value name="23">
<Value>WorstRadius</Value>
</Value>
<Value name="24">
<Value>WorstTexture</Value>
</Value>
<Value name="25">
<Value>WorstPerimeter</Value>
</Value>
<Value name="26">
<Value>WorstArea</Value>
</Value>
<Value name="27">
<Value>WorstSmoothness</Value>
</Value>
<Value name="28">
<Value>WorstCompactness</Value>
</Value>
<Value name="29">
<Value>WorstConcavity</Value>
</Value>
<Value name="30">
<Value>WorstConcavePoints</Value>
</Value>
<Value name="31">
<Value>WorstSymmetry</Value>
</Value>
<Value name="32">
<Value>WorstFractalDimension</Value>
</Value>
</Data>
<DataLocation>^User.BreastCancerD</DataLocation>
<DefaultData>BreastCancerDefaultData</DefaultData>
<IdLocation>^User.BreastCancerD</IdLocation>
<IndexLocation>^User.BreastCancerI</IndexLocation>
<StreamLocation>^User.BreastCancerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
