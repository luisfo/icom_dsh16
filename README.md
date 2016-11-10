# i-com Data Science Hackathon 2016
## UC3M Team code

## WARNING! tweets file (_tweets\_2015.json_) NOT included
### Step I
Insert tweets file to mongoDB
> InsertDataToDB.py _tweets\_2015.json_

### Step II
Extract features from mongoDB into files (monthly and quarterly)
> extractFeaturesFromMongo\_v3.sh

You should put all these generated files into a separate folder (e.g, featuresFolder)

### Step III
Insert the features files to MySql DB
> sqlMongoFeaturesLoader.sh _$featuredFolder_

### Step IV
Dump the MySql DB tables into a csv file.

### Step V
Run regressions
> regressions.R

