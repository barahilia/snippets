from itertools import chain
from collections import namedtuple
from pickle import dump

import numpy
from sklearn.naive_bayes import GaussianNB

CLASSES = {'boy': 0, 'girl': 1}
Child = namedtuple('Clild', ['name', 'gender', 'toys'])


def load_file(path):
    with open(path) as f:
        for line in f:
            if not line or line.startswith('#'):
                continue

            line = Child(*line.split())
            assert line.gender in CLASSES
            yield line


def get_features(path):
    return list(set(chain.from_iterable(l.toys.split(',')
                                        for l in load_file(path))))

def get_samples(path):
    return list(l.name for l in load_file(path))


class Dataset:
    def __init__(self, *args):
        self.samples, self.features, self.data, self.target = args

    @staticmethod
    def load(path, features):
        samples = get_samples(path)

        indexed_features = {feature: i for i, feature in enumerate(features)}
        indexed_samples = {sample: i for i, sample in enumerate(samples)}

        data_shape = len(samples), len(features)
        data = numpy.zeros(data_shape, dtype=numpy.int8)

        target = numpy.zeros(len(indexed_samples), dtype=numpy.int8)

        for line in load_file(path):
            assert line.gender in CLASSES

            sample_index = indexed_samples[line.name]
            target[sample_index] = CLASSES[line.gender]

            for toy in line.toys.split(','):
                if toy in features:
                    feature_index = indexed_features[toy]
                    data[sample_index][feature_index] = 1  # exists

        return Dataset(samples, features, data, target)


def main():
    path = 'learn.data'
    features = get_features(path)
    dataset = Dataset.load(path, features)

    classifier = GaussianNB()
    classifier.fit(dataset.data, dataset.target)

    with open('classifier.pkl', 'w') as f:
        dump((features, classifier), f)


if __name__ == '__main__':
    main()
