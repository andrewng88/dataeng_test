# Section 3: System Design

Caveat Emptor:
Not really familiar with this topic and I tried my best to piece up based on Networking 101 , general knowledge , googl-ing , youtubing and prior interfaces with good like-minded peeps in the tech industry.

Assumptions : Users are mostly from Singapore since it's a Govtech assignment
We should be using a [AWS Pricing Calculator](https://calculator.aws/#/) to see if it's within budget too.

![](https://i.imgur.com/qxfnKk1.png "Title")

>We can see that there is `2 Availability Zones` for redundancy purposes eventhough we have 3 AZ here.

End user access will be divided between public and private dns access. This is for security purposes which is handled by the NAT gateway.

Then, the data(images) will flow to the `Web Portal` with the help of the `Application Load Balance`. It automatically distributes your incoming traffic across multiple targets.

Then, `AWS Auto Scaling` monitors your applications and automatically adjusts capacity to maintain steady, predictable performance at the lowest possible cost. For example, perhaps the company wanted to provide free services for 24 hours then this would be of good use.

Then data will be transferred to our model also via another `Application Load Balance` to a `Web App Instance` process the images and then stored in the 'S3 bucket'. S3( Object Storage) benefits are better data analytics(metadata), infinite scalibiliy and cost effective. We can also be exploring `Hadoop`'s distributed database.

At the same time, the `Web Portal` and `Web App Instances` will be processing information to the `RDS` for Dashboarding purposes via `QuickSight`.

Last but not least which is the essential part of the question is `Kafka` which provides a framework for storing, reading and analysing streaming data(real time ) and is used in a 'distributed' evnvironment. When we put a Bid Data analytics framework together, `Kafka` will be the brain that data(images) passes to and fro from datalakes.

Finally, the processed image will route back to the front.