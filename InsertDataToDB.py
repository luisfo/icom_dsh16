import json
import os.path
import sys
from pymongo import MongoClient
import pymongo
from itertools import islice

"""
Insert tweets into mongoDB in a batch mode of 50000 tweets per query.
We assume that mongoDB is running locally at port 27017. The expected intput
file is a list of a json format tweet per line.
"""


def insert_to_mongo_batch(file_name):
    mongo = MongoClient('localhost', 27017)
    db = mongo.tweets.data
    #fp = open('i_com_hackathon_sample.json', 'r')
    fp = open(file_name, 'r')
    N = 50000
    counter = 0
    while True:
        next_lines = islice(fp,N)
        ll = [json.loads(i) for i in next_lines]
        if len(ll) > 0:
            db.insert_many(ll)
        else:
            break
        counter += 1
        sys.stdout.write(' ' * 8 + '\r')
        sys.stdout.flush()
        obj = counter * N / 1000000.0
        msg = 'Object inserted: %s M' % obj
        sys.stdout.write(msg)

    print '\nCreating Index...'
    #mongo.createIndex( { "id": 1 } )
    index_name = db.create_index([("id", pymongo.ASCENDING)])
    print 'Index name: ' + index_name



if __name__ == "__main__":
    if len(sys.argv) < 2:
        print '%s <filename>' % (sys.argv[0])
        exit(-1)
    if not os.path.isfile(sys.argv[1]):
        print sys.argv[1] + ' is not a filename or filename don\'t exists. Exiting...'
        exit(-1)
    print 'Start Inserting to MongoDB...'
    insert_to_mongo_batch(sys.argv[1])
