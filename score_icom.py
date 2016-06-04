import numpy as np
import pandas as pd
import sys

from scipy.stats.stats import pearsonr
import time

truth = 'hashtag_q415_truth.csv'
pred = sys.argv[1]


d_truth = pd.read_csv(truth, sep = ',', names = ['hashtag', 'y'])
d_pred = pd.read_csv(pred, sep = ',', names = ['hashtag', 'p'])

#Check for counts
cnt_t = d_truth.shape[0]
cnt_p = d_pred.shape[0]

if cnt_t == cnt_p:
    print 'All hashtags accounted for'
    print ''

else:
    print 'WARNING: {} hashtags given, {} expected'.format(cnt_p, cnt_t)

#Now get correlation

d_fin = d_truth.merge(d_pred, how = 'left', left_on = 'hashtag', right_on = 'hashtag')
d_fin = d_fin.fillna(0)

print 'Hackathon score is: {}'.format(pearsonr(d_fin.y, d_fin.p)[0])

