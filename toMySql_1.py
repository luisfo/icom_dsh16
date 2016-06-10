import MySQLdb
import json
import sys


def insert_records(f_name):
    conn = MySQLdb.connect(
        host='127.0.0.1', user='root',
        passwd='icom',
        db='Hackathon',
        charset='utf8',
        use_unicode=True
    )
    x = conn.cursor()

    time_slot = f_name.split('_')[1].split('.')[0]
    with open(f_name, 'r') as fp:
        lines = fp.readlines()
        for line in lines:
            try:
                record = json.loads(line)
            except Exception, e:
                print e
                continue
            hashtag =  record['_id']['hashtag']
            count_tweets = record['count_tweets']
            totalRetweetCount =  record['totalRetweetCount']
            AvgFollowers =  record['AvgFollowers']
            MaxRetweetCount =  record['MaxRetweetCount'] # string
            AvgRetweetCount =  record['AvgRetweetCount'] # string
            MaxFollowers =  record['MaxFollowers'] # string
            totalfollower =  record['totalfollower'] # string
            count_post = str(record['count_post'])
            count_share = str(record['count_share'])

            ratio_count_post = str(float(count_post) / count_tweets)
            ratio_count_share = str(float(count_share) / count_tweets)

            totalklout_score = str(record['totalklout_score'])
            Avgklout_score = str(record['Avgklout_score'])
            Maxklout_score = str(record['Maxklout_score'])
            totalFriends = str(record['totalFriends'])
            AvgFriends = str(record['AvgFriends'])
            MaxFriends = str(record['MaxFriends'])
            totalstatusesCount = str(record['totalstatusesCount'])
            AvgstatusesCount = str(record['AvgstatusesCount'])
            MaxstatusesCount = str(record['MaxstatusesCount'])
            inReplyTo = str(record['inReplyTo'])
            try:
                x.execute(
                    "INSERT INTO Data (" + \
                    "hashtag, time_slot, count_tweets, totalRetweetCount, " + \
                    "AvgFollowers, MaxRetweetCount, AvgRetweetCount, MaxFollowers, " + \
                    "totalfollower, count_post, count_share, ratio_count_post, " + \
                    "ratio_count_share, totalklout_score, Avgklout_score, Maxklout_score, " + \
                    "totalFriends, AvgFriends, MaxFriends, totalstatusesCount, " + \
                    "AvgstatusesCount, MaxstatusesCount, inReplyTo)" + \
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, " + \
                    "%s, %s, %s, %s, %s, %s, %s)",
                    ( hashtag, time_slot, count_tweets, totalRetweetCount, AvgFollowers,
                      MaxRetweetCount, AvgRetweetCount, MaxFollowers, totalfollower,
                      count_post, count_share, ratio_count_post, ratio_count_share,
                      totalklout_score, Avgklout_score, Maxklout_score, totalFriends,
                      AvgFriends, MaxFriends, totalstatusesCount, AvgstatusesCount,
                      MaxstatusesCount, inReplyTo
                    )
                )
                conn.commit()
            except Exception, e:
                conn.rollback()
                #print 'Insert exception'
                print e
                print 'line =', line

        conn.close()


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print '%s <file_xx.json>\nArguments error. Exiting'
        exit()
    f_name_o = sys.argv[1]

    insert_records(f_name_o)

