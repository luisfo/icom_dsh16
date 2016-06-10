#!/bin/bash
# Script to extract features from mongoDB using the console interface.

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-01-01T00:00:00.000Z",
        "$lt": "2015-02-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_01.json


mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-02-01T00:00:00.000Z",
        "$lt": "2015-03-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_02.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-03-01T00:00:00.000Z",
        "$lt": "2015-04-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

             "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_03.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-04-01T00:00:00.000Z",
        "$lt": "2015-05-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

             "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_04.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-05-01T00:00:00.000Z",
        "$lt": "2015-06-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_05.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-06-01T00:00:00.000Z",
        "$lt": "2015-07-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_06.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-07-01T00:00:00.000Z",
        "$lt": "2015-08-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_07.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-08-01T00:00:00.000Z",
        "$lt": "2015-09-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_08.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-09-01T00:00:00.000Z",
        "$lt": "2015-10-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_09.json


mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-10-01T00:00:00.000Z",
        "$lt": "2015-11-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_10.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-11-01T00:00:00.000Z",
        "$lt": "2015-12-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_11.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-12-01T00:00:00.000Z",
        "$lt": "2016-01-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_12.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-01-01T00:00:00.000Z",
        "$lt": "2015-04-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_q1.json

mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-04-01T00:00:00.000Z",
        "$lt": "2015-07-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_q2.json


mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-07-01T00:00:00.000Z",
        "$lt": "2015-10-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

            "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_q3.json


mongo 127.0.0.1/tweets --eval 'var c = db.data.aggregate([
{ $unwind : "$twitter_entities.hashtags" },
{ $match: { postedTime: { "$gte": "2015-10-01T00:00:00.000Z",
        "$lt": "2016-01-01T00:00:00.000Z" } } },
{ $group : { _id : { hashtag: "$twitter_entities.hashtags.text" },

             "inReplyTo": { "$sum": {
            "$cond": [ { "$ifNull": ["$inReplyTo", false] }, 1, 0 ] 
            } },         
           
           count_post: {$sum: { $cond: [ { $eq: [ "$verb", "post"] } , 1, 0 ] }},
           count_share: {$sum: { $cond: [ { $eq: [ "$verb", "share"] } , 1, 0 ] }},

           totalklout_score: { $sum: "$gnip.klout_score" },
           Avgklout_score: { $avg: "$gnip.klout_score" },
           Maxklout_score: { $max: "$gnip.klout_score" },
           
       	   totalRetweetCount: { $sum: "$retweetCount" },
           AvgRetweetCount: { $avg: "$retweetCount" },
           MaxRetweetCount: { $max: "$retweetCount" },
           
           totalFriends: { $sum: "$actor.friendsCount" },
           AvgFriends: { $avg: "$actor.friendsCount" },
           MaxFriends: { $max: "$actor.friendsCount" },         

           totalfollower: { $sum: "$actor.followersCount" },
           AvgFollowers: { $avg: "$actor.followersCount" },
           MaxFollowers: { $max: "$actor.followersCount" },
           
           totalstatusesCount: { $sum: "$actor.statusesCount" },
           AvgstatusesCount: { $avg: "$actor.statusesCount" },
           MaxstatusesCount: { $max: "$actor.statusesCount" },
    
           count_tweets: { $sum: 1 } }
       }
   ] , {
  allowDiskUse:true }
  ); while(c.hasNext()) {printjsononeline(c.next())}' >> list_q4.json
