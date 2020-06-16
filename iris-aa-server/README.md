# IRIS Advanced Analytics with IntegratedML Demo 

This folder contains a few simple datasets to demonstrate InterSystems IRIS IntegratedML (previously known as QuickML). The enclosed Dockerfile can be used separately from the rest of the integratedml-demo-template, if you do not want to use the Jupyter Notebook interface.

## How to build

The included Dockerfile will pull the IRIS Advanced Analytics Community Edition (with IntegratedML) container image from the InterSystems public Docker repository, and set up a few simple datasets.

```
docker build --tag integratedml-demo .
```

To start your container, use the following command (or your favourite equivalent, as this one will drop your container after stopping)

```
docker run --rm -d -p 9091:51773 -p 9092:52773 --name integratedml integratedml-demo
```

The IRIS password is initialized as SYS, but you can get in directly through the following command, the SMP or connecting through a SQL client such as [DBeaver](https://dbeaver.io/)

```
docker exec -it integratedml iris sql IRIS
```

## How to demo

Using IntegratedML takes only three simple commands:

```sql
CREATE MODEL Flowers PREDICTING (Species) FROM DataMining.IrisDataset;
TRAIN MODEL Flowers FROM DataMining.IrisDataset;
SELECT TOP 20 PREDICT(Flowers) AS PredictedSpecies, Species AS ActualSpecies FROM DataMining.IrisDataset;
```

Note that the semicolons at the end are for use in a multiline-style client such as DBeaver or SQuirreL and not part of regular IRIS SQL. See the [IntegratedML Syntax overview](https://usconfluence.iscinternal.com/display/TBD/IntegratedML+Syntax) if you want to be more creative. For example, you can add ```USING { "provider": "H2O" }``` to your CREATE or TRAIN commands to test the H2O provider instead of the default one.

### Included datasets

These are broadly available datasets, but we may not have permission to _re_-distribute them, so keep this repo to yourself:
- \[SQLUser.\]Campaign: as used in the campaign showcase in the [ML Toolkit](https://github.com/intersystems/MLToolkit). The target column to put your crosshairs on is RESPONSE
- \[SQLUser.\]BreastCancer
