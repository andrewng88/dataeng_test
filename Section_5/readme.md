# Section 5: Machine Learning

I think this section might be the most fun for me due to the dataset that is provided and also the prediction that I made due to some of findings.

We can also brute force our way using PyCaret whereby it will run all the algos under the sun but perhaps some good ole analytics and judgement is good for this fun dataset.

For myself as I'm analytically trained , we're always advised methods that are simple to understand. Explainable models such as Linear & Logistic Regression and Decision Trees are much preferred unless one go to non-structural data which requires Neural Networks in industry such as image, video and NLP.

### Answer : 

![](https://i.imgur.com/iA6h16B.png "Title")

Using Decision Tree supported by pandas groupby method with an accuracy of 30% with the prediction. The answer is ``1(low)``

## Explanation
![](https://i.imgur.com/Fj3VFW9.png "Title")


From feature selection we found out that feature 4 `class` is significant in predicting. With only 1 feature to predict , we will have a higher adjusted `R^2` too.

We double confirmed with a simple groupby. We have almost twice odds of predicting a 1 rather than a 2 ,given the `buy_price` values
![](https://i.imgur.com/rmWGKVa.png "Title")