from pickle import load

from classify import CLASSES, Dataset


def get_class(value):
    return CLASSES.keys()[CLASSES.values().index(value)]


def main():
    with open('classifier.pkl') as f:
        features, classifier = load(f)

    path = 'test.data'
    dataset = Dataset.load(path, features)

    predictions = classifier.predict(dataset.data)

    for sample, prediction in zip(dataset.samples, predictions):
        print sample, get_class(prediction)

    print classifier.score(dataset.data, dataset.target)


if __name__ == '__main__':
    main()
