import os
import argparse
import sys 
sys.path.append("../../")

from config import Config
config = Config()

import math
import cv2 
import numpy as np

config.set_lib('pydbow2')
import pydbow2 as dbow2
config.set_lib('pydbow3')
import pydbow3 as dbow3


kScriptPath = os.path.realpath(__file__)
kScriptFolder = os.path.dirname(kScriptPath)
kRootFolder = kScriptFolder + '/../..'
kDataFolder = kRootFolder + '/data'
kOrbVocabFile = kDataFolder + '/ORBvoc_test.txt'


kUseDbow3 = True   


def main(input_file, output_file):

    print(f'loading descriptors array from {input_file} ...')
    # load descriptors array from a file
    descriptors = np.load(input_file)
    print(f'loaded descriptors array of shape {descriptors.shape}')

    # generate vocabulary
    voc = dbow3.Vocabulary() if kUseDbow3 else dbow2.BinaryVocabulary()
    print(f'generating vocabulary...')
    voc.create(descriptors)
    print(f'saving vocabulary to {output_file} ...')
    compressed_file = True if kUseDbow3 else False # NOTE: dbow2 seems to have issues in saving compressed files
    voc.save(output_file, compressed_file)
    print(f'...done')
    

# load descriptors array from a file and generate vocabulary      
if __name__ == '__main__':
    argparser = argparse.ArgumentParser()
    argparser.add_argument("-i","--input_file", required=False, type=str, default=kDataFolder+"/descriptors.npy", help="Path to your descriptors array")
    argparser.add_argument("-o","--output_file", required=False, type=str, default=kOrbVocabFile, help="Path to save the vocabulary")
    args = argparser.parse_args()

    main(args.input_file, args.output_file)