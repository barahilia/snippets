---
layout: post
---

# Machine Learning

Install `sklearn`:

```sh
pip install numpy scipy
pip install scikit-learn
```

Full example code can be found in `$checkout/data/ml`.

## Classify children as boys or girls by their toys

The *classes* are: `classes = {'boy': 0, 'girl': 1}`. Assuming learning dataset:

```
# name  gender  toys
alice   girl    doll,ball,apple
bob     boy     car,ball
charlie boy     ball,apple
desy    girl    apple,doll
```

For convenience load into stucture:

```py
Child = namedtuple('Clild', ['name', 'gender', 'toys'])
```

Extract the *samples* and the *features*:

```py
samples = [child.name for child in children]

features = list(set(
    chain.from_iterable(child.toys for child in children)))
```

After that *data* matrix and *target* vector can be built:

```py
data = [
    [toy in child.toys for toy in features]
    for child in children
]
target = [classes[child.gender] for child in children]
```

Finally classifier can be trained:

```py
from sklearn.naive_bayes import GaussianNB
classifier = GaussianNB()
classifier.fit(data, target)
```

To use it, test data can be loaded into another dataset:

```
# name  gender  toys
eli     boy     car,apple
fiona   girl    ball,doll
```

And prediction made:

```py
print classifier.predict(data)
print classifier.score(data, target)
```

## Useful links and terms

* [Working with text data](http://scikit-learn.org/stable/tutorial/text_analytics/working_with_text_data.html)
* sparse dataset
* TF-IDF
* PCA
