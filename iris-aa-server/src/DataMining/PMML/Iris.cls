/// Sample PMML file based on Iris measurements in <class>DataMining.IrisDataset</class>.
Class DataMining.PMML.Iris Extends %DeepSee.PMML.Definition [ ProcedureBlock ]
{

XData PMML [ XMLNamespace = "http://www.intersystems.com/deepsee/pmml" ]
{
<PMML version="4.1">
<Header>
<Application name="KNIME" version="2.8.2"/>
<Timestamp>03/11/2013 11:54:41</Timestamp>
</Header>
<DataDictionary numberOfFields="5">

<!-- This custom extension allows mapping table or cube data to model input -->
<Extension name="isc:datasource">
<X-SQLDataSource name="Analysis dataset" idField="ID">
<X-FieldMap fieldName="PetalLength" spec="PetalLength" />
<X-FieldMap fieldName="PetalWidth" spec="PetalWidth" />
<X-FieldMap fieldName="SepalLength" spec="SepalLength" />
<X-FieldMap fieldName="SepalWidth" spec="SepalWidth" />
<X-FieldMap fieldName="Species" spec="Species" />
<X-SQL>SELECT ID, PetalLength, PetalWidth, SepalLength, SepalWidth, Species FROM DataMining.IrisDataset</X-SQL>
</X-SQLDataSource>

</Extension>

<DataField name="Species" optype="categorical" dataType="string">
<Value value="Iris-setosa"/>
<Value value="Iris-versicolor"/>
<Value value="Iris-virginica"/>
</DataField>
<DataField name="PetalLength" optype="continuous" dataType="double" />
<DataField name="PetalWidth" optype="continuous" dataType="double" />
<DataField name="SepalLength" optype="continuous" dataType="double" />
<DataField name="SepalWidth" optype="continuous" dataType="double" />
</DataDictionary>

<TreeModel modelName="DecisionTree" functionName="classification" splitCharacteristic="binarySplit" missingValueStrategy="lastPrediction" noTrueChildStrategy="returnNullPrediction">
<MiningSchema>
<MiningField name="PetalLength" invalidValueTreatment="asIs"/>
<MiningField name="PetalWidth" invalidValueTreatment="asIs"/>
<MiningField name="SepalLength" invalidValueTreatment="asIs"/>
<MiningField name="SepalWidth" invalidValueTreatment="asIs"/>
<MiningField name="Species" invalidValueTreatment="asIs" usageType="predicted"/>
</MiningSchema>
<Output>
<OutputField name="Species" feature="predictedValue" />
<OutputField name="Probability" feature="probability" />
</Output>
<Node id="0" score="Iris-setosa" recordCount="150.0">
<True/>
<ScoreDistribution value="Iris-setosa" recordCount="50.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="50.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="50.0"/>
<Node id="1" score="Iris-setosa" recordCount="50.0">
<SimplePredicate field="PetalWidth" operator="lessOrEqual" value="0.8"/>
<ScoreDistribution value="Iris-setosa" recordCount="50.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="0.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="0.0"/>
</Node>
<Node id="2" score="Iris-versicolor" recordCount="100.0">
<SimplePredicate field="PetalWidth" operator="greaterThan" value="0.8"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="50.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="50.0"/>
<Node id="3" score="Iris-versicolor" recordCount="54.0">
<SimplePredicate field="PetalWidth" operator="lessOrEqual" value="1.75"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="49.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="5.0"/>
<Node id="4" score="Iris-versicolor" recordCount="48.0">
<SimplePredicate field="PetalLength" operator="lessOrEqual" value="4.95"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="47.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="1.0"/>
</Node>
<Node id="7" score="Iris-virginica" recordCount="6.0">
<SimplePredicate field="PetalLength" operator="greaterThan" value="4.95"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="2.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="4.0"/>
<Node id="8" score="Iris-virginica" recordCount="3.0">
<SimplePredicate field="PetalWidth" operator="lessOrEqual" value="1.55"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="0.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="3.0"/>
</Node>
<Node id="9" score="Iris-versicolor" recordCount="3.0">
<SimplePredicate field="PetalWidth" operator="greaterThan" value="1.55"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="2.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="1.0"/>
</Node>
</Node>
</Node>
<Node id="10" score="Iris-virginica" recordCount="46.0">
<SimplePredicate field="PetalWidth" operator="greaterThan" value="1.75"/>
<ScoreDistribution value="Iris-setosa" recordCount="0.0"/>
<ScoreDistribution value="Iris-versicolor" recordCount="1.0"/>
<ScoreDistribution value="Iris-virginica" recordCount="45.0"/>
</Node>
</Node>
</Node>
</TreeModel>


<GeneralRegressionModel modelName="SepalLength Regression" modelType="generalizedLinear" 
functionName="regression" algorithmName="glm" distribution="normal" linkFunction="identity">
<MiningSchema>
<MiningField name="SepalLength" usageType="predicted"/>
<MiningField name="SepalWidth" usageType="active"/>
<MiningField name="PetalLength" usageType="active"/>
<MiningField name="PetalWidth" usageType="active"/>
<MiningField name="Species" usageType="active"/>
</MiningSchema>

<ParameterList>
<Parameter name="p0" label="Intercept"/>
<Parameter name="p1" label="SepalWidth"/>
<Parameter name="p2" label="PetalLength"/>
<Parameter name="p3" label="PetalWidth"/>
<Parameter name="p4" label="classIris-versicolor"/>
<Parameter name="p5" label="classIris-virginica"/>
</ParameterList>
<FactorList>
<Predictor name="Species"/>
</FactorList>
<CovariateList>
<Predictor name="SepalWidth"/>
<Predictor name="PetalLength"/>
<Predictor name="PetalWidth"/>
</CovariateList>
<PPMatrix>
<PPCell value="1" predictorName="SepalWidth" parameterName="p1"/>
<PPCell value="1" predictorName="PetalLength" parameterName="p2"/>
<PPCell value="1" predictorName="PetalWidth" parameterName="p3"/>
<PPCell value="Iris-versicolor" predictorName="Species" parameterName="p4"/>
<PPCell value="Iris-virginica" predictorName="Species" parameterName="p5"/>
</PPMatrix>
<ParamMatrix>
<PCell parameterName="p0" df="1" beta="2.22413677241697"/>
<PCell parameterName="p1" df="1" beta="0.462828301295544"/>
<PCell parameterName="p2" df="1" beta="0.912364461921148"/>
<PCell parameterName="p3" df="1" beta="-0.384539403624331"/>
<PCell parameterName="p4" df="1" beta="-0.944151669544111"/>
<PCell parameterName="p5" df="1" beta="-1.33483727247749"/>
</ParamMatrix>
</GeneralRegressionModel>
</PMML>
}

}
