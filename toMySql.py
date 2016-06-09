import MySQLdb
import json
import sys


"""
Insert tweets features into MySql database. We assume that MySql database in
running locally with root user and password "icom". The input file is a list of
json object, one object per line, with the tweet extracted features.
"""

def insert_records(f_name):
    conn = MySQLdb.connect(host= "localhost", user="root", passwd="icom", db="hackathon")
    x = conn.cursor()

    time_slot = f_name.split('_')[1].split('.')[0]
    #print 'time_slot = ' + time_slot
    with open(f_name, 'r') as fp:
        lines = fp.readlines()
        all_recs = {}
        for line in lines:
            record = json.loads(line)
            hashtag =  record['_id']['hashtag']
            #print 'id = ' + hashtag
            count_tweets = record['count_tweets']
            #print 'count_tweets = ' + str(count_tweets)
            totalFavoritesCount =  record['totalFavoritesCount']
            #print 'totalFavoritesCount = %s' % totalFavoritesCount
            totalRetweetCount =  record['totalRetweetCount']
            #print 'totalRetweetCount = %s' % totalRetweetCount
            AvgFollowers =  record['AvgFollowers']
            #print 'AvgFollowers = %s' % AvgFollowers
            MaxRetweetCount =  record['MaxRetweetCount'] # string
            #print 'MaxRetweetCount = %s' % MaxRetweetCount
            MaxFavoritesCount =  record['MaxFavoritesCount'] # string
            #print 'MaxFavoritesCount = %s' % MaxFavoritesCount
            AvgFavoritesCount =  record['AvgFavoritesCount'] # string
            #print 'AvgFavoritesCount = %s' % AvgFavoritesCount
            AvgRetweetCount =  record['AvgRetweetCount'] # string
            #print 'AvgRetweetCount = %s' % AvgRetweetCount
            MaxFollowers =  record['MaxFollowers'] # string
            #print 'MaxFollowers = %s' % MaxFollowers
            totalfollower =  record['totalfollower'] # string
            #print 'totalfollower = %s' % totalfollower
            #print record

        try:

            x.execute("""INSERT INTO
hachathon (hashtag, count_tweets, totalFavoritesCount, totalRetweetCount, AvgFollowers, MaxRetweetCount,
MaxFavoritesCount, AvgFavoritesCount, AvgRetweetCount, MaxFollowers, totalfollower)
VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)""",(hashtag, count_tweets, totalFavoritesCount, totalRetweetCount, AvgFollowers, MaxRetweetCount,
                   MaxFavoritesCount, AvgFavoritesCount, AvgRetweetCount, MaxFollowers, totalfollower))
            conn.commit()
        except:
            conn.rollback()

        conn.close()


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print '%s <file_xx.json>\nArguments error. Exiting'
        exit()
    f_name = sys.argv[1]

    insert_records(f_name=f_name)

